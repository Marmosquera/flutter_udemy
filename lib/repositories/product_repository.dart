import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:udemy_course/models/product.dart';

import 'package:udemy_course/models/product_input.dart';

class ProductRepository {
  static const PRODUCTS_COLLECTION = 'products';
  static const PRODUCTS_IMAGES_COLLECTION = 'productsImages';

  saveProductData(ProductInput productInput) async => FirebaseFirestore.instance
      .collection(PRODUCTS_COLLECTION)
      .doc(productInput.id)
      .set(productInput.toJson());

  Future<List<Product>> getProducts() async => await FirebaseFirestore.instance
      .collection(PRODUCTS_COLLECTION)
      .get()
      .then((productsSnapshot) =>
          productsSnapshot.docs.map((doc) => Product.fromJson(doc.data())))
      .then((value) => value.toList());

  Future<String> saveProductImage(ProductInput productInput) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child(PRODUCTS_IMAGES_COLLECTION)
        .child(productInput.id + '.jpg');
    await ref.putFile(productInput.pickedImage!);
    return await ref.getDownloadURL();
  }
}
