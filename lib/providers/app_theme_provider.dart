import 'package:flutter/foundation.dart';
import 'package:udemy_course/repositories/app_theme_repository.dart';

class AppThemeProvider with ChangeNotifier {
  AppThemeRepository appThemeRepository = AppThemeRepository();
  bool _appTheme = false;
  bool get appTheme => _appTheme;
  set appTheme(bool value) {
    _appTheme = value;
    appThemeRepository.setTheme(value);
    notifyListeners();
  }
}
