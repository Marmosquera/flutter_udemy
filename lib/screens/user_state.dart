import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/bottom_bar.dart';
import 'landing_page.dart';

class UserState extends StatelessWidget {
  UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.connectionState == ConnectionState.active) {
            if (userSnapshot.hasData) {
              return BottomBarScreen();
            } else {
              return LandingPage();
            }
          }
          return Center(
            child: Text('error ocurred'),
          );
        });
  }
}
