import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:traccar_app/state/global_state.dart';

class HttpBaseClient extends http.BaseClient {
  final http.Client _client = http.Client();
  final GlobalState _state;

  HttpBaseClient({
    required GlobalState state,
  }) : _state = state;

  Uri get _baseUrl => Uri.parse(_state.apiUrl);

  Map<String, String> get _headers => {
        if (_state.authenticationType == AuthenticationType.token &&
            _state.authenticate.isNotEmpty)
          'Authorization': 'Bearer ${_state.authenticate}',
        if (_state.authenticationType == AuthenticationType.cookies &&
            _state.authenticate.isNotEmpty)
          'Cookie': _state.authenticate,
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
    return super.get(
      _path(url),
      headers: {
        ..._headers,
        ...?headers,
      },
    );
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return super.post(
      _path(url),
      body: body,
      headers: {
        ..._headers,
        ...?headers,
      },
    );
  }

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    return super.delete(
      _path(url),
      headers: {
        ..._headers,
        ...?headers,
      },
    );
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}

class HttpClient {
  final HttpBaseClient _http;

  HttpClient({
    required HttpBaseClient httpBaseClient,
  }) : _http = httpBaseClient;

  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    final response = await _http.get(
      Uri(path: path).replace(queryParameters: query),
    );

    return jsonDecode(response.body) as T;
  }

  Future<T> post<T>(
    String path, {
    Map<String, String>? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final response = await _http.post(
      Uri(path: path).replace(queryParameters: query),
      body: body,
      headers: headers,
    );

    return jsonDecode(response.body) as T;
  }

  Future<void> delete(String path) {
    return _http.delete(Uri(path: path));
  }
}
