import 'package:flutter/material.dart';
import 'package:traccar_app/state/map_state.dart';
import 'package:traccar_app/utils/tile_providers.dart';

import 'common/popover.dart';

class TileProviderPicker extends StatelessWidget {
  const TileProviderPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Popover(
      target: (open) {
        return Container(
          decoration: ShapeDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: const CircleBorder(),
          ),
          padding: const EdgeInsets.all(5),
          child: IconButton(
            onPressed: open,
            icon: const Icon(Icons.layers_rounded),
            iconSize: 30,
          ),
        );
      },
      builder: (close) {
        return SingleChildScrollView(
          child: Column(
            children: TileLayerProvider.values
                .map(
                  (value) => ListTile(
                    title: Text(value.name),
                    onTap: () {
                      close();
                      MapState.of(context).setTileLayerProvider(value);
                    },
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
