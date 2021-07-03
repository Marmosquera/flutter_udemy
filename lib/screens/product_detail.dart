import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  static const routeName = '/ProductDetail';
  ProductDetail({Key? key}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProductDetail'),
      ),
      body: Container(
        child: Center(
          child: Text('ProductDetail'),
        ),
      ),
    );
  }
}
