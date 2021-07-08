import 'package:flutter/material.dart';
import 'package:udemy_course/models/product.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      required this.imageUrl});

  double get subTotal => quantity * price;

  static CartItem fromProduct(Product product) => CartItem(
      id: product.id,
      title: product.title,
      price: product.price,
      quantity: 1,
      imageUrl: product.imageUrl);
}
