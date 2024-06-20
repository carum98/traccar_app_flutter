import 'package:traccar_app/core/http_client.dart';
import 'package:traccar_app/core/storage.dart';

class AuthService {
  final Storage _storage;
  final HttpClient _httpClient;

  AuthService({
    required HttpClient httpClient,
    required Storage storage,
  })  : _httpClient = httpClient,
        _storage = storage;

  Future<bool> isAuthenticated() async {
    try {
      if (await _storage.contains(StorageKey.cookies) == false) {
        throw Exception('No cookies');
      }

      await _httpClient.get('/session');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final response = await _httpClient.post(
      '/session',
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      await _storage.write(
        key: StorageKey.cookies,
        value: response.headers['set-cookie'] ?? '',
      );
    }

    return response.statusCode == 200;
  }

  Future<bool> logout() async {
    try {
      await _httpClient.delete('/session');
      await _storage.delete(StorageKey.cookies);

      return true;
    } catch (e) {
      return false;
    }
  }
}
