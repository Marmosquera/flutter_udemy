import 'dart:io';

import 'package:flutter/material.dart';

class UserLoginData with ChangeNotifier {
  String id = '';
  String email = '';
  String fullName = '';
  String phoneNumber = '';
  String imageUrl = '';
  DateTime? joinedAt;

  String? password;
  File? pickedImage;
}
