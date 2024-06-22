import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:traccar_app/core/map_state.dart';
import 'package:traccar_app/models/devices.dart';
import 'package:traccar_app/models/position.dart';

class TraccarMap extends StatelessWidget {
  const TraccarMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = MapState.of(context);

    return FlutterMap(
      options: const MapOptions(
        initialCenter: LatLng(9.950685409604112, -84.12032421989458),
        initialZoom: 17,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        ValueListenableBuilder<List<Devices>>(
          valueListenable: state.devices,
          builder: (_, items, __) => MarkerLayer(
            markers: items
                .map((item) => MarkerDevice(
                      device: item,
                      onTap: () => state.setDevice(item),
                    ))
                .toList(),
          ),
        ),
        ValueListenableBuilder<List<Position>>(
          valueListenable: state.positions,
          builder: (_, items, __) => PolylineLayer(
            polylines: [
              Polyline(
                points: items
                    .map((item) => LatLng(item.latitude, item.longitude))
                    .toList(),
                color: Colors.red,
                strokeWidth: 4,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class MarkerDevice extends Marker {
  MarkerDevice({
    super.key,
    required Devices device,
    required VoidCallback onTap,
  }) : super(
          width: 40,
          height: 40,
          point: LatLng(device.position.latitude, device.position.longitude),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(
                  device.category == 'car'
                      ? Icons.directions_car
                      : Icons.location_on_sharp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
}
