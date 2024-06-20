import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:traccar_app/models/devices.dart';

class TraccarMap extends StatelessWidget {
  final ValueNotifier<List<Devices>> markers;

  const TraccarMap({
    super.key,
    required this.markers,
  });

  @override
  Widget build(BuildContext context) {
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
        ValueListenableBuilder(
          valueListenable: markers,
          builder: (_, List<Devices> value, __) {
            return MarkerLayer(
              markers: value
                  .map(
                    (e) => Marker(
                      width: 40,
                      height: 40,
                      point: LatLng(e.position.latitude, e.position.longitude),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Icon(
                            e.category == 'car'
                                ? Icons.directions_car
                                : Icons.location_on_sharp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        )
      ],
    );
  }
}
