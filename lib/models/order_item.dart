import 'package:flutter/material.dart';

class OrderItem with ChangeNotifier {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  OrderItem(
      {required this.id,
      required this.title,
      required this.quantity,
      required this.price,
      required this.imageUrl});

  double get subTotal => quantity * price;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'quantity': quantity.toString(),
        'price': price.toStringAsFixed(2),
        'imageUrl': imageUrl,
      };

  OrderItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        imageUrl = json['imageUrl'],
        quantity = json['quantity'];
}
