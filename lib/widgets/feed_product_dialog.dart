import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/consts/app_icons.dart';
import 'package:udemy_course/models/product.dart';
import 'package:udemy_course/providers/cart_provider.dart';
import 'package:udemy_course/screens/product_detail.dart';

class FeedProductDialog extends StatelessWidget {
  final Product product;

  FeedProductDialog({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            constraints: BoxConstraints(
                minHeight: 100,
                maxHeight: MediaQuery.of(context).size.height * 0.5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Image.network(
              product.imageUrl,
            ),
          ),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                    child:
                        _roundedButton(Icons.favorite, 'Add to Wish', () {})),
                Flexible(
                    child: _roundedButton(
                        FeatherIcons.eye,
                        'View Product',
                        () => Navigator.pushNamed(
                                context, ProductDetail.routeName,
                                arguments: product.id)
                            .then((value) => Navigator.canPop(context)
                                ? Navigator.pop(context)
                                : null))),
                Flexible(
                  child: _roundedButton(AppIcons.cart, 'Add to Cart',
                      () => _cartProvider.addProductToCart(product)),
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.3),
                  shape: BoxShape.circle),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  splashColor: Colors.grey,
                  onTap: () =>
                      Navigator.canPop(context) ? Navigator.pop(context) : null,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close, size: 28, color: Colors.white),
                  ),
                ),
              )),
        ]),
      ),
    );
  }

  Widget _roundedButton(IconData icon, String text, VoidCallback fnc) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: fnc,
            splashColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: const Offset(0.0, 10.0),
                      ),
                    ]),
                child: Padding(
                    padding: const EdgeInsets.all(8.0), child: Icon(icon)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(text),
        )
      ],
    );
  }
}
