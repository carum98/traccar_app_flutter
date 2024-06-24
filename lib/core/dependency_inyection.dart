import 'dart:async';

import 'package:flutter/material.dart';
import 'package:traccar_app/state/global_state.dart';
import 'package:traccar_app/core/http_client.dart';
import 'package:traccar_app/core/router_generator.dart';
import 'package:traccar_app/core/storage.dart';
import 'package:traccar_app/services/traccar_api.dart';
import 'package:traccar_app/services/auth.dart';

class DI extends InheritedWidget {
  final GlobalState state = GlobalState();

  late final Storage storage;
  late final HttpClient httpClient;

  late final AuthService authService;
  late final TraccarService traccarService;

  DI({
    super.key,
    required super.child,
  }) {
    storage = Storage();

    final httpBaseClient = HttpBaseClient(state: state);

    httpClient = HttpClient(
      httpBaseClient: httpBaseClient,
    );

    authService = AuthService(
      httpBaseClient: httpBaseClient,
      storage: storage,
      state: state,
    );

    traccarService = TraccarService(
      client: httpClient,
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
    final [serverUrl, cookies, token] = await Future.wait([
      storage.read(StorageKey.serverUrl),
      storage.read(StorageKey.cookies),
      storage.read(StorageKey.token),
    ]);

    if (serverUrl != null) state.setApiUrl(serverUrl);
    if (cookies != null) state.setAuthenticate(cookies);
    if (token != null) state.setAuthenticate(token);
  }

  static DI of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DI>() as DI;
  }

  @override
  bool updateShouldNotify(DI oldWidget) => false;
}
