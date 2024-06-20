class Position {
  final int id;
  final double latitude;
  final double longitude;
  final String fixTime;
  final double speed;
  final double course;
  final ({bool ignition, bool motion}) attributes;

  Position({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.fixTime,
    required this.speed,
    required this.course,
    required this.attributes,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      fixTime: json['fixTime'],
      speed: json['speed'],
      course: json['course'],
      attributes: (
        ignition: json['attributes']['ignition'] ?? false,
        motion: json['attributes']['motion'] ?? false,
      ),
    );
  }
}
