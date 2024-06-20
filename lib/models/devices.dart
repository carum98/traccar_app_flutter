import 'position.dart';

class Devices {
  final int id;
  final String name;
  final int positionId;
  final String? category;
  final String status;
  final String? lastUpdate;
  final Position position;

  Devices({
    required this.id,
    required this.name,
    required this.positionId,
    required this.category,
    required this.status,
    required this.lastUpdate,
    required this.position,
  });

  factory Devices.fromJson(Map<String, dynamic> json) {
    return Devices(
      id: json['id'],
      name: json['name'],
      positionId: json['positionId'],
      category: json['category'],
      status: json['status'],
      lastUpdate: json['lastUpdate'],
      position: Position.fromJson(json['position']),
    );
  }
}
