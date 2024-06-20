import 'package:flutter/material.dart';

class GlobalState extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  bool _showBottomBar = true;
  bool get showBottomBar => _showBottomBar;

  String _apiUrl = '';
  String get apiUrl => _apiUrl;

  String _cookies = '';
  String get cookies => _cookies;

  void setThemeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  void setShowBottomBar(bool value) {
    _showBottomBar = value;
    notifyListeners();
  }

  void setApiUrl(String value) {
    _apiUrl = value;
  }

  void setCookies(String value) {
    _cookies = value;
  }
}
