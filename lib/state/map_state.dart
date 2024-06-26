import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:traccar_app/core/dependency_inyection.dart';
import 'package:traccar_app/utils/tile_providers.dart';
import 'package:traccar_app/models/devices.dart';
import 'package:traccar_app/models/position.dart';
import 'package:traccar_app/services/traccar_api.dart';

class MapState extends InheritedWidget {
  final MapController mapController = MapController();
  final TraccarService _apiService;

  final tileLayerProvider = ValueNotifier(TileLayerProvider.openStreetMap);

  final devices = ValueNotifier(List<Devices>.empty());
  final positions = ValueNotifier(List<Position>.empty());
  final activePosition = ValueNotifier<Position?>(null);

  final params = MapStateParams();

  MapState({
    super.key,
    required BuildContext context,
    required super.child,
  }) : _apiService = DI.of(context).traccarService {
    fetchDevices();

    params.addListener(() => fetchPositions());
  }

  @override
  bool updateShouldNotify(MapState oldWidget) => false;

  static MapState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MapState>()!;
  }

  void setDevice(Devices device) {
    params.setDevice = device;
  }

  void setTileLayerProvider(TileLayerProvider provider) {
    tileLayerProvider.value = provider;
  }

  void moveToPosition(Position position) {
    activePosition.value = position;

    mapController.move(
      LatLng(position.latitude, position.longitude),
      17,
    );
  }

  Future<void> fetchDevices() async {
    devices.value = await _apiService.getDevices();
  }

  Future<void> fetchPositions() async {
    positions.value = await _apiService.getPositions(
      deviceId: params.device!.id,
      from: params.from,
      to: params.to,
    );
  }
}

class MapStateParams extends ChangeNotifier {
  Devices? _device;
  DateTime _from = DateTime.now().subtract(const Duration(days: 1));
  DateTime _to = DateTime.now();

  Devices? get device => _device;
  DateTime get from => _from;
  DateTime get to => _to;

  set dateRange(({DateTime from, DateTime to}) value) {
    _from = value.from;
    _to = value.to;
    notifyListeners();
  }

  set setDevice(Devices value) {
    _device = value;
    notifyListeners();
  }
}
