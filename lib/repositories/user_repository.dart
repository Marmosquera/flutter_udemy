import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:udemy_course/models/user_login_data.dart';

class UserRepository {
  static const USERS_COLLECTION = 'users';
  static const USERS_IMAGES_COLLECTION = 'usersImages';

  saveUserData(UserLoginData userData) async => FirebaseFirestore.instance
          .collection(USERS_COLLECTION)
          .doc(userData.id)
          .set({
        'id': userData.id,
        'name': userData.fullName,
        'email': userData.email,
        'phoneNumber': userData.phoneNumber,
        'imageUrl': userData.imageUrl,
        'joinedAt': userData.joinedAt?.millisecondsSinceEpoch ?? ''
      });

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

  Future<String> saveUserImage(UserLoginData userData) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child(USERS_IMAGES_COLLECTION)
        .child(userData.id + '.jpg');
    await ref.putFile(userData.pickedImage!);
    return await ref.getDownloadURL();
  }
}
