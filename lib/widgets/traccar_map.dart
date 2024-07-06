import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:traccar_app/state/map_state.dart';
import 'package:traccar_app/utils/tile_providers.dart';
import 'package:traccar_app/models/devices.dart';
import 'package:traccar_app/models/position.dart';

import 'dart:math' as math;

class TraccarMap extends StatelessWidget {
  const TraccarMap({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final state = MapState.of(context);

    return FlutterMap(
      mapController: state.mapController,
      options: const MapOptions(
        initialCenter: LatLng(9.950685409604112, -84.12032421989458),
        initialZoom: 17,
      ),
      children: [
        ValueListenableBuilder<TileLayerProvider>(
          valueListenable: state.tileLayerProvider,
          builder: (_, value, __) => TileLayer(
            urlTemplate: value.urlTemplate,
            retinaMode: true,
          ),
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
                color: Colors.blue,
                strokeWidth: 4,
              ),
            ],
          ),
        ),
        ValueListenableBuilder<List<Position>>(
          valueListenable: state.positions,
          builder: (_, items, __) => MarkerLayer(
            markers: items
                .where((item) => item.attributes.motion)
                .map((item) => MarkerCourse(
                      position: item,
                      onTap: () => state.moveToPosition(item),
                    ))
                .toList(),
          ),
        ),
        ValueListenableBuilder<Position?>(
          valueListenable: state.activePosition,
          builder: (_, item, __) => MarkerLayer(markers: [
            if (item != null)
              MarkerCourse(
                position: item,
                active: true,
                onTap: () => state.moveToPosition(item),
              ),
          ]),
        ),
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

class MarkerCourse extends Marker {
  MarkerCourse({
    super.key,
    required Position position,
    required VoidCallback onTap,
    bool? active,
  }) : super(
          width: 20,
          height: 20,
          point: LatLng(position.latitude, position.longitude),
          child: Transform.rotate(
            angle: position.course * math.pi / 180,
            child: GestureDetector(
              onTap: onTap,
              child: Icon(
                Icons.navigation_rounded,
                color: active == true
                    ? Colors.red
                    : const Color.fromARGB(255, 0, 64, 175),
                size: 20,
              ),
            ),
          ),
        );
}
