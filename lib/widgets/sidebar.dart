import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final Widget child;
  const Sidebar({super.key, required this.child});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
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
    final width = MediaQuery.of(context).size.width * 0.30;

    return ValueListenableBuilder(
      valueListenable: _isOpen,
      builder: (_, value, child) {
        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: 0,
          top: 0,
          left: value ? 0 : -(width + 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              child!,
              Card(
                child: IconButton(
                  onPressed: toggle,
                  icon: Icon(
                    value
                        ? Icons.arrow_back_ios_rounded
                        : Icons.arrow_forward_ios_rounded,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Card(
        child: SizedBox(
          width: width,
          child: widget.child,
        ),
      ),
    );
  }
}
