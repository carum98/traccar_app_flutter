import 'package:flutter/material.dart';

class BottomSheetPermanent extends StatefulWidget {
  final ValueNotifier<bool> isVisible;
  final List<Widget> children;

  const BottomSheetPermanent({
    super.key,
    required this.children,
    required this.isVisible,
  });

  @override
  State<BottomSheetPermanent> createState() => _BottomSheetPermanentState();
}

class _BottomSheetPermanentState extends State<BottomSheetPermanent> {
  final _isOpen = ValueNotifier<bool>(false);

  @override
  void dispose() {
    super.dispose();

    _isOpen.dispose();
  }

  void toggle() {
    _isOpen.value = !_isOpen.value;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: Listenable.merge([_isOpen, widget.isVisible]),
      builder: (_, __) {
        final double bottom =
            _isOpen.value ? 0 : -height * (widget.isVisible.value ? 0.5 : 0.8);

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: bottom,
          left: 0,
          right: 0,
          child: BottomSheet(
            enableDrag: false,
            onClosing: () => {},
            builder: (_) => SizedBox(
              height: height * 0.7,
              width: double.infinity,
              child: Column(
                children: [
                  IconButton(
                    onPressed: toggle,
                    iconSize: 30,
                    icon: Icon(
                      _isOpen.value
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_up,
                    ),
                  ),
                  ...widget.children,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
