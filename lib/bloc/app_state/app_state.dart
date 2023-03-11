import 'package:flutter/cupertino.dart';

class AppState with ChangeNotifier{
  String languageCode = 'en';
  bool isDarkMode = false;
  String fonts = 'Roboto';

  AppState() {}

  void changeTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
  void changeLanguageCode(String languageCode) {
    this.languageCode = languageCode;
    notifyListeners();
  }
}
