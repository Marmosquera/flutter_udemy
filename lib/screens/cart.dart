import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/widgets/app_dialogs.dart';
import '/consts/app_icons.dart';
import '/providers/cart_provider.dart';
import '/widgets/cart_empty.dart';
import '/widgets/cart_full.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);
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
                    onTap: () {},
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
