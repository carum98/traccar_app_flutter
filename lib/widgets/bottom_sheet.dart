import 'package:flutter/material.dart';

class BottomSheetPermanent extends StatefulWidget {
  final List<Widget> children;
  const BottomSheetPermanent({super.key, required this.children});

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

    return ValueListenableBuilder(
      valueListenable: _isOpen,
      builder: (_, value, __) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: value ? 0 : -height * 0.5,
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
                      value
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
