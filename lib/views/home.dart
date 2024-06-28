import 'package:flutter/material.dart';
import 'package:traccar_app/widgets/adaptative_layout.dart';
import 'package:traccar_app/widgets/appbar_home.dart';
import 'package:traccar_app/widgets/list_positions.dart';
import 'package:traccar_app/widgets/traccar_map.dart';
import 'package:traccar_app/widgets/position_player.dart';
import 'package:traccar_app/widgets/tile_provider_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarHome(),
      body: AddaptativeLayout(
        traccarMap: TraccarMap(),
        positions: ListPositions(),
        player: PositionPlayer(),
        tileProvider: TileProviderPicker(),
      ),
    );
  }
}
