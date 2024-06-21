// Singleton class to handle the HTTP requests
import 'package:http/http.dart' as http;

import 'global_state.dart';

class HttpClient {
  final http.Client _client = http.Client();
  final GlobalState _state;

  HttpClient({
    required GlobalState state,
  }) : _state = state;

  Map<String, String> get _headers => {
        'Cookie': _state.cookies,
      };

  Future<http.Response> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final response = await _client.get(
      Uri.parse('${_state.apiUrl}$path').replace(queryParameters: query),
      headers: _headers,
    );

    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      throw Exception("Error while fetching data");
    }

    return response;
  }

  Future<http.Response> post(
    String path, {
    Map<String, String>? body,
    Map<String, dynamic>? query,
  }) async {
    final response = await _client.post(
      Uri.parse('${_state.apiUrl}$path').replace(queryParameters: query),
      body: body,
      headers: _headers,
    );

    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      throw Exception("Error while fetching data");
    }

    return response;
  }

  Future<http.Response> delete(String path) async {
    final response = await _client.delete(
      Uri.parse('${_state.apiUrl}$path'),
      headers: _headers,
    );

    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      throw Exception("Error while fetching data");
    }

    return response;
  }
}
