import 'dart:convert';

import 'package:http/http.dart' as http;
import 'global_state.dart';

class _Client extends http.BaseClient {
  final http.Client _client = http.Client();
  final GlobalState _state;

  _Client({
    required GlobalState state,
  }) : _state = state;

  Uri get _baseUrl => Uri.parse(_state.apiUrl);

  Map<String, String> get _headers => {
        'Cookie': _state.cookies,
      };

  Uri _path(Uri url) {
    return url.replace(
      scheme: _baseUrl.scheme,
      host: _baseUrl.host,
      path: _baseUrl.path + url.path,
    );
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    return super.get(_path(url), headers: _headers);
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return super.post(_path(url), headers: _headers, body: body);
  }

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return super.delete(_path(url), headers: _headers);
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}

class HttpClient {
  final _Client _client;

  HttpClient({
    required GlobalState state,
  }) : _client = _Client(state: state);

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final response = await _client.get(
      Uri(path: path).replace(queryParameters: query),
    );

    return jsonDecode(response.body) as T;
  }

  Future<T> post<T>(
    String path, {
    Map<String, String>? body,
    Map<String, dynamic>? query,
  }) async {
    final response = await _client.post(
      Uri(path: path).replace(queryParameters: query),
      body: body,
    );

    return jsonDecode(response.body) as T;
  }

  Future<void> delete(String path) {
    return _client.delete(Uri(path: path));
  }
}
