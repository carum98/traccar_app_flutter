import 'package:flutter/material.dart';
import 'package:traccar_app/core/dependency_inyection.dart';
import 'package:traccar_app/models/devices.dart';
import 'package:traccar_app/models/position.dart';
import 'package:traccar_app/services/api.dart';

class MapState extends InheritedWidget {
  final ApiService _apiService;

  final ValueNotifier<List<Devices>> devices = ValueNotifier([]);
  final ValueNotifier<List<Position>> positions = ValueNotifier([]);
  final params = MapStateParams();

  MapState({
    super.key,
    required BuildContext context,
    required super.child,
  }) : _apiService = DI.of(context).apiService {
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
  DateTime _from = DateTime.now().subtract(const Duration(days: 3));
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