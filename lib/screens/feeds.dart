import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/models/product.dart';
import 'package:udemy_course/providers/products_provider.dart';
import '/widgets/feeds_products.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = '/Feeds';

  final bool showTitle;

  FeedsScreen({required this.showTitle});

  @override
  Widget build(BuildContext context) {
    final _productsProvider = Provider.of<ProductsProvider>(context);
    final _products = _productsProvider.products.toList();
    final onlyPopular =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';
    if (onlyPopular == 'popular') {
      _products.clear();
      final _productsCopy = _productsProvider.popularProducts;
      _products.addAll(_productsCopy);
    }

    return Scaffold(
        appBar: showTitle
            ? AppBar(
                title: Text('Feeds'),
              )
            : null,
        body: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 420,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: List.generate(_products.length, (index) {
              return ChangeNotifierProvider.value(
                  value: _products[index], child: FeedsProducts());
            })));
  }
}
