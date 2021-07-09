import 'package:flutter/material.dart';
import 'package:udemy_course/models/product.dart';

class FavoriteItem with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  FavoriteItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.imageUrl});

  static FavoriteItem fromProduct(Product product) => FavoriteItem(
      id: product.id,
      title: product.title,
      price: product.price,
      imageUrl: product.imageUrl);
}
