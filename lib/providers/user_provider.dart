import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:udemy_course/models/user_login_data.dart';
import 'package:udemy_course/repositories/user_repository.dart';

class UserProvider with ChangeNotifier {
  final UserRepository _userRepository = UserRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<FirebaseApp> initializeApp() => Firebase.initializeApp();

  Stream<User?> authStateChanges() {
    final stream = FirebaseAuth.instance.authStateChanges();
    stream.listen((user) async {
      if (user != null) {
        if (user.uid != userLoggedin.id) {
          userLoggedin = await _userRepository.getUserData(user.uid);
        }
      } else {
        userLoggedin = UserLoginData();
      }
    });
    return stream;
  }

  UserLoginData userLoggedin = UserLoginData();

  Future<UserCredential> signInWithEmailAndPassword(
          String email, String password) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> createUserWithEmailAndPassword(
          UserLoginData userLoginData, String password) =>
      _auth
          .createUserWithEmailAndPassword(
              email: userLoginData.email, password: password)
          .then((value) {
        userLoginData.joinedAt = DateTime.now().toUtc();
        _userRepository.saveUserData(userLoginData);
        return value;
      });
}
