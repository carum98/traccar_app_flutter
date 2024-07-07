import 'dart:async';

import 'package:flutter/material.dart';
import 'package:traccar_app/models/position.dart';
import 'package:traccar_app/state/map_state.dart';

class PositionPlayer extends StatefulWidget {
  const PositionPlayer({super.key});

  @override
  State<PositionPlayer> createState() => _PositionPlayerState();
}

class _PositionPlayerState extends State<PositionPlayer> {
  late final MapState state;

  int index = 0;
  Timer? timer;
  List<Position> positions = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = MapState.of(context);

      state.positions.addListener(() {
        positions = state.positions.value
            .where((item) => item.attributes.motion)
            .toList();
      });
    });
  }

  void play() {
    if (timer != null) {
      timer!.cancel();
      timer = null;
    } else {
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (positions.isEmpty) return;

        if (index >= positions.length) {
          index = 0;
        }

        state.moveToPosition(positions.elementAt(index));
        index++;
      });
    }

    setState(() {});
  }

  void back() {
    if (index == 0) {
      index = positions.length - 1;
    } else {
      index--;
    }

    state.moveToPosition(positions.elementAt(index));
  }

  void forward() {
    if (index >= positions.length - 1) {
      index = 0;
    } else {
      index++;
    }

    state.moveToPosition(positions.elementAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 20,
          children: [
            IconButton(
              onPressed: back,
              icon: const Icon(Icons.fast_rewind),
              iconSize: 40,
            ),
            Ink(
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: const CircleBorder(),
              ),
              child: IconButton(
                onPressed: play,
                icon: timer != null
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
                iconSize: 50,
              ),
            ),
            IconButton(
              onPressed: forward,
              icon: const Icon(Icons.fast_forward),
              iconSize: 40,
            ),
          ],
        ),
      ],
    );
  }
}
