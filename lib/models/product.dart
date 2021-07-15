import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  String id;
  String title;
  String description;
  double price;
  String imageUrl;
  String productCategoryName;
  String brand;
  int quantity;
  bool isPopular;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.productCategoryName,
      required this.brand,
      required this.quantity,
      required this.isPopular});

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        price = json['price'],
        imageUrl = json['imageUrl'],
        productCategoryName = json['productCategoryName'],
        brand = json['brand'],
        quantity = json['quantity'],
        isPopular = json['isPopular'];
}
