import 'package:flutter/foundation.dart';
import 'package:udemy_course/repositories/dark_theme_repository.dart';

class DarkThemeProvider with ChangeNotifier {
  DarkThemeRepository darkThemeRepository = DarkThemeRepository();
  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemeRepository.setDarkTheme(value);
    notifyListeners();
  }
}
