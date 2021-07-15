import 'dart:io';
import 'package:uuid/uuid.dart';

import 'product.dart';

class ProductInput extends Product {
  File? pickedImage;
  String userId = '';
  DateTime createdAt = DateTime.now();

  ProductInput()
      : super(
            id: Uuid().v4(),
            title: '',
            description: '',
            price: 0,
            imageUrl: '',
            brand: '',
            productCategoryName: '',
            quantity: 0,
            isPopular: false);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'brand': brand,
        'productCategoryName': productCategoryName,
        'quantity': quantity,
        'isPopular': isPopular,
        'userId': userId,
        'createdAt': createdAt.toUtc().millisecondsSinceEpoch
      };
}
