import 'dart:async';

import 'package:flutter/material.dart';
import 'package:traccar_app/core/global_state.dart';
import 'package:traccar_app/core/http_client.dart';
import 'package:traccar_app/core/router_generator.dart';
import 'package:traccar_app/core/storage.dart';
import 'package:traccar_app/services/auth.dart';

class DI extends InheritedWidget {
  final GlobalState state = GlobalState();

  late final Storage storage;
  late final HttpClient httpClient;

  late final AuthService authService;

  DI({
    super.key,
    required super.child,
  }) {
    storage = Storage();
    httpClient = HttpClient(state: state);

    authService = AuthService(
      httpClient: httpClient,
      storage: storage,
    );

    initialize();
  }

  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));

    await syncStateStorage();

    authService.isAuthenticated().then((value) {
      state.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        value ? HOME_VIEW : LOGIN_VIEW,
        (route) => false,
      );
    });
  }

  Future<void> syncStateStorage() async {
    final [serverUrl, cookies] = await Future.wait([
      storage.read(StorageKey.serverUrl),
      storage.read(StorageKey.cookies),
    ]);

    if (serverUrl != null) state.setApiUrl(serverUrl);
    if (cookies != null) state.setCookies(cookies);
  }

  static DI of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DI>() as DI;
  }

  @override
  bool updateShouldNotify(DI oldWidget) => false;
}
