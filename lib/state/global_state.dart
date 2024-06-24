import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum AuthenticationType {
  cookies,
  token,
}

class GlobalState extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  bool _showBottomBar = true;
  bool get showBottomBar => _showBottomBar;

  final _authenticationType =
      kIsWeb ? AuthenticationType.token : AuthenticationType.cookies;
  AuthenticationType get authenticationType => _authenticationType;

  String _apiUrl = '';
  String get apiUrl => _apiUrl;

  String _authenticate = '';
  String get authenticate => _authenticate;

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

  void setAuthenticate(String value) {
    _authenticate = value;
  }
}
