import 'package:flutter/material.dart';

class PositionPlayer extends StatelessWidget {
  const PositionPlayer({super.key});

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
              onPressed: () {},
              icon: const Icon(Icons.fast_rewind),
              iconSize: 40,
            ),
            Ink(
              decoration: ShapeDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: const CircleBorder(),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.play_arrow),
                iconSize: 50,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.fast_forward),
              iconSize: 40,
            ),
          ],
        ),
      ],
    );
  }
}
