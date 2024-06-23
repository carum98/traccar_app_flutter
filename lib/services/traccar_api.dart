import 'package:traccar_app/core/http_client.dart';
import 'package:traccar_app/models/devices.dart';
import 'package:traccar_app/models/position.dart';

class TraccarService {
  final HttpClient _client;

  TraccarService({
    required HttpClient client,
  }) : _client = client;

  Future<List<Devices>> getDevices() async {
    final [responseDevices, responsePositions] = await Future.wait([
      _client.get<List>('/devices'),
      _client.get<List>('/positions'),
    ]);

    final devices = responseDevices.map((device) {
      final position = responsePositions.firstWhere(
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

  Future<List<Position>> getPositions({
    required int deviceId,
    required DateTime from,
    required DateTime to,
  }) async {
    final positions = await _client.get<List>('/positions', query: {
      'deviceId': deviceId.toString(),
      'from': from.toUtc().toIso8601String(),
      'to': to.toUtc().toIso8601String(),
    });

    return positions.map((position) => Position.fromJson(position)).toList();
  }
}
