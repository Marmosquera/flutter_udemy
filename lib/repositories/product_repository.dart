import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:udemy_course/models/product_input.dart';

class ProductRepository {
  static const PRODUCTS_COLLECTION = 'products';
  static const PRODUCTS_IMAGES_COLLECTION = 'productsImages';

  saveProductData(ProductInput productInput) async => FirebaseFirestore.instance
      .collection(PRODUCTS_COLLECTION)
      .doc(productInput.id)
      .set(productInput.toJson());
/*
  Future<UserLoginData> getUserData(String id) async {
    UserLoginData userData = UserLoginData();
    final doc = await FirebaseFirestore.instance
        .collection(USERS_COLLECTION)
        .doc(id)
        .get();
    if (doc.exists) {
      userData.id = doc.get('id');
      userData.fullName = doc.get('name');
      userData.email = doc.get('email');
      userData.phoneNumber = doc.get('phoneNumber');
      userData.imageUrl = doc.get('imageUrl');
      userData.joinedAt =
          DateTime.fromMillisecondsSinceEpoch(doc.get('joinedAt'));
    }
    return userData;
  }
  */

  Future<String> saveProductImage(ProductInput productInput) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child(PRODUCTS_IMAGES_COLLECTION)
        .child(productInput.id + '.jpg');
    await ref.putFile(productInput.pickedImage!);
    return await ref.getDownloadURL();
  }
}
