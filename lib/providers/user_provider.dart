import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
          print('authStateChanges');
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

  Future<UserCredential> signInAnonymously() => _auth.signInAnonymously();

  Future<UserCredential?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        return await _auth
            .signInWithCredential(GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken))
            .then((value) {
          UserLoginData userLoginData = UserLoginData();
          userLoginData.id = value.user!.uid;
          userLoginData.fullName = value.user?.displayName ?? '';
          userLoginData.email = value.user?.email ?? '';
          userLoginData.phoneNumber = value.user?.phoneNumber ?? '';
          userLoginData.imageUrl = value.user!.photoURL ?? '';
          userLoginData.joinedAt = DateTime.now().toUtc();
          _userRepository.saveUserData(userLoginData);
          return value;
        });
      }
    }
    return null;
  }
}
