import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:traccar_app/core/dependency_inyection.dart';
import 'package:traccar_app/utils/tile_providers.dart';
import 'package:traccar_app/models/devices.dart';
import 'package:traccar_app/models/position.dart';
import 'package:traccar_app/services/traccar_api.dart';

class MapState extends InheritedWidget {
  final TraccarService _apiService;

  final mapController = MapController();
  final scrollController = ScrollController();

  final tileLayerProvider =
      ValueNotifier(TileLayerProvider.stadiaAlidadeSmoothDark);

  final devices = ValueNotifier(List<Devices>.empty());
  final positions = ValueNotifier(List<Position>.empty());
  final activePosition = ValueNotifier<Position?>(null);

  final hasData = ValueNotifier(false);

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

    final index = positions.value.indexOf(position);

    scrollController.animateTo(
      index * 80.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> fetchDevices() async {
    devices.value = await _apiService.getDevices();
  }

  Future<void> fetchPositions() async {
    if (params.device == null) return;

    positions.value = await _apiService.getPositions(
      deviceId: params.device!.id,
      from: params.from,
      to: params.to,
    );

    hasData.value = positions.value.isNotEmpty;
  }
}

typedef DateRange = ({DateTime from, DateTime to});

class MapStateParams extends ChangeNotifier {
  Devices? _device;
  DateTime _from = DateTime.now().copyWith(hour: 0, minute: 0);
  DateTime _to = DateTime.now().copyWith(hour: 23, minute: 59);

  Devices? get device => _device;
  DateTime get from => _from;
  DateTime get to => _to;

  String get fromText =>
      DateFormat("MMM d',' h:mm a").format(_from).toLowerCase();

  String get toText => DateFormat("MMM d',' h:mm a").format(_to).toLowerCase();

  set dateRange(DateRange value) {
    _from = value.from;
    _to = value.to;
    notifyListeners();
  }

  set setDevice(Devices value) {
    _device = value;
    notifyListeners();
  }
}
