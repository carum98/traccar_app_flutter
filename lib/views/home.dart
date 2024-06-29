import 'package:flutter/material.dart';
import 'package:traccar_app/state/map_state.dart';
import 'package:traccar_app/widgets/date_range_picker.dart';
import 'package:traccar_app/widgets/responsive_layout.dart';
import 'package:traccar_app/widgets/appbar_home.dart';
import 'package:traccar_app/widgets/list_positions.dart';
import 'package:traccar_app/widgets/traccar_map.dart';
import 'package:traccar_app/widgets/position_player.dart';
import 'package:traccar_app/widgets/tile_provider_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = MapState.of(context);

    return Scaffold(
      appBar: const AppbarHome(),
      body: ResponsiveLayout(
        traccarMap: const TraccarMap(),
        positions: const ListPositions(),
        player: const PositionPlayer(),
        tileProvider: const TileProviderPicker(),
        dateRangePicker: const DateRangePicker(),
        hasData: state.hasData,
      ),
    );
  }
}
