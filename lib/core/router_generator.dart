import 'package:flutter/material.dart';
import 'package:traccar_app/views/home.dart';
import 'package:traccar_app/views/login.dart';

const TEMP_VIEW = '/';
const HOME_VIEW = '/home';
const LOGIN_VIEW = '/login';

class RouterGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case HOME_VIEW:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case LOGIN_VIEW:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case TEMP_VIEW:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}
