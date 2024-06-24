import 'dart:convert';

import 'package:traccar_app/core/http_client.dart';
import 'package:traccar_app/core/storage.dart';
import 'package:traccar_app/state/global_state.dart';

class AuthService {
  final GlobalState _state;
  final Storage _storage;
  final HttpBaseClient _http;

  AuthService({
    required GlobalState state,
    required HttpBaseClient httpBaseClient,
    required Storage storage,
  })  : _http = httpBaseClient,
        _storage = storage,
        _state = state;

  Future<bool> isAuthenticated() async {
    try {
      final response = await Future.wait([
        _storage.read(StorageKey.token),
        _storage.read(StorageKey.cookies),
      ]);

      if (response.every((element) => element == null)) {
        throw Exception('No token or cookies');
      }

      await _http.get(Uri.parse('/session'));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      if (_state.authenticationType == AuthenticationType.cookies) {
        final response = await _http.post(
          Uri(path: '/session'),
          body: {
            'email': email,
            'password': password,
          },
        );

        if (response.statusCode != 200) {
          throw Exception('Invalid credentials');
        }

        await _storage.write(
          key: StorageKey.cookies,
          value: response.headers['set-cookie'] ?? '',
        );
      } else {
        final response = await _http.post(
          Uri(path: '/session/token'),
          body: {
            'expiration': DateTime.now()
                .toUtc()
                .add(const Duration(days: 1))
                .toIso8601String(),
          },
          headers: {
            'content-type': 'application/x-www-form-urlencoded',
            'authorization':
                'Basic ${base64Encode(utf8.encode('$email:$password'))}',
          },
        );

        if (response.statusCode != 200) {
          throw Exception('Invalid credentials');
        }

        await _storage.write(
          key: StorageKey.token,
          value: response.body,
        );
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await _http.delete(Uri.parse('/session'));
      await _storage.delete(StorageKey.cookies);

      return true;
    } catch (e) {
      return false;
    }
  }
}
