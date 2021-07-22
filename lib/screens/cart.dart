import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/repositories/stripe_repository.dart';
import 'package:udemy_course/widgets/app_dialogs.dart';
import '/consts/app_icons.dart';
import '/providers/cart_provider.dart';
import '/widgets/cart_empty.dart';
import '/widgets/cart_full.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartProvider _cartProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StripeRepository.init();
  }

  Future<void> payWithCard({required int amount}) async {
    double amountInCents = _cartProvider.totalAmount * 1000;
    int intengerAmount = (amountInCents / 10).ceil();

    var snack = ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('please wait'),
        duration: Duration(seconds: 1),
      ),
    );
    var response = await StripeRepository.payWithNewCard(
        currency: 'USD', amount: intengerAmount.toString());
    snack.close();
    //print('response : ${response.success}');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('ok'),
      duration: Duration(milliseconds: response.success ? 1200 : 3000),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    return _cartProvider.cartItems.isEmpty
        ? Scaffold(
            appBar: AppBar(
              title: Text('Empty Cart'),
            ),
            body: CartEmpty())
        : Scaffold(
            appBar: AppBar(
              title: Text('Cart (${_cartProvider.cartItems.length})'),
              actions: [
                IconButton(
                  onPressed: () {
                    AppDialogs.showAlert(
                        context,
                        'Clear cart',
                        'All products will be removed from cart',
                        () {},
                        () => _cartProvider.clearCart());
                  },
                  icon: Icon(AppIcons.delete),
                )
              ],
            ),
            bottomSheet: checkoutSection(context, _cartProvider.totalAmount),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: _cartProvider.cartItems.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return CartFull(
                        cartItem:
                            _cartProvider.cartItems.values.toList()[index]);
                  }),
            ));
  }

  Widget checkoutSection(BuildContext ctx, double subtotal) {
    return Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            /// mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Material(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.red,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () async => payWithCard,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Checkout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                                Theme.of(ctx).textSelectionTheme.selectionColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Text(
                'Total:',
                style: TextStyle(
                    color: Theme.of(ctx).textSelectionTheme.selectionColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                'US \$${subtotal.toStringAsFixed(3)}',
                //textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
