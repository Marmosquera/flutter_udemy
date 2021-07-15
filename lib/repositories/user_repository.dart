import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:udemy_course/models/user_login_data.dart';

class UserRepository {
  static const THEME_STATUS = 'THEMESSTATUS';

  int run = 0;

  saveUserData(UserLoginData userData) async =>
      FirebaseFirestore.instance.collection('users').doc(userData.id).set({
        'id': userData.id,
        'name': userData.fullName,
        'email': userData.email,
        'phoneNumber': userData.phoneNumber,
        'imageUrl': userData.imageUrl,
        'joinedAt': userData.joinedAt?.millisecondsSinceEpoch ?? ''
      });

  Future<UserLoginData> getUserData(String id) async {
    print('$run');
    run++;
    UserLoginData userData = UserLoginData();
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
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
}
