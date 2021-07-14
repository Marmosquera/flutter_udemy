import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/bottom_bar.dart';
import 'landing_page.dart';
import '/providers/user_provider.dart';

class UserState extends StatelessWidget {
  UserState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userProvider = Provider.of<UserProvider>(context);
    return StreamBuilder(
        stream: _userProvider.authStateChanges(),
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
