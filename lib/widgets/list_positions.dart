import 'package:flutter/material.dart';
import 'package:traccar_app/core/map_state.dart';
import 'package:traccar_app/models/position.dart';

class ListPositions extends StatelessWidget {
  const ListPositions({super.key});

  @override
  Widget build(BuildContext context) {
    final state = MapState.of(context);

    return ValueListenableBuilder(
      valueListenable: state.positions,
      builder: (_, items, __) {
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) {
            return _PositionTile(
              item: items[index],
            );
          },
        );
      },
    );
  }
}

class _PositionTile extends StatelessWidget {
  final Position item;

  const _PositionTile({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        '${item.latitude}, ${item.longitude}',
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        item.date,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (item.attributes.motion)
                  Transform.rotate(
                    angle: item.course,
                    child: const Icon(
                      Icons.navigation_rounded,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
                Icon(
                  Icons.car_crash,
                  size: 18,
                  color: item.attributes.ignition ? Colors.green : Colors.grey,
                ),
              ],
            ),
            if (item.speed != 0) Text('${item.speed.toStringAsFixed(2)} km/h'),
          ],
        ),
      ),
    );
  }
}
