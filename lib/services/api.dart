import 'dart:convert';

import 'package:traccar_app/core/http_client.dart';
import 'package:traccar_app/models/devices.dart';

class ApiService {
  final HttpClient _client;

  ApiService({
    required HttpClient client,
  }) : _client = client;

  Future<List<Devices>> getDevices() async {
    final [responseDevices, responsePositions] = await Future.wait([
      _client.get('/devices'),
      _client.get('/positions'),
    ]);

    final devicesJson = jsonDecode(responseDevices.body) as List;
    final positionsJson = jsonDecode(responsePositions.body) as List;

    final devices = devicesJson.map((device) {
      final position = positionsJson.firstWhere(
        (position) => position['deviceId'] == device['id'],
        orElse: () => {},
      );

      return Devices.fromJson({
        ...device,
        'position': position,
      });
    }).toList();

    return devices;
  }
}
