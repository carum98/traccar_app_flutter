import 'package:flutter/material.dart';

class BottomSheetScaffold extends StatefulWidget {
  final Widget child;

  const BottomSheetScaffold({
    super.key,
    required this.child,
  });

  @override
  State<BottomSheetScaffold> createState() => _BottomSheetScaffoldState();
}

class _BottomSheetScaffoldState extends State<BottomSheetScaffold> {
  final _isOpen = ValueNotifier<bool>(false);

  @override
  void dispose() {
    super.dispose();

    _isOpen.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isOpen,
      builder: (_, value, child) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: value
            ? MediaQuery.of(context).size.height * 0.8
            : MediaQuery.of(context).size.height * 0.2,
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                _isOpen.value = !_isOpen.value;
              },
              icon: Icon(
                value ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
              ),
              iconSize: 30,
            ),
            child!
          ],
        ),
      ),
      child: Center(child: widget.child),
    );
  }
}
