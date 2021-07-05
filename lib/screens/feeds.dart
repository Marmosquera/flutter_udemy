import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy_course/models/product.dart';
import 'package:udemy_course/providers/products_provider.dart';
import '/widgets/feeds_products.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = '/Feeds';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);

    List<Product> _products = productsProvider.products;

    return Scaffold(
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
