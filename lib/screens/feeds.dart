import 'package:flutter/material.dart';
import '/widgets/feeds_products.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = '/Feeds';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 240 / 420,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            children: List.generate(8, (index) {
              return FeedsProducts();
            })));
  }
}
