import 'package:flutter/material.dart';

class MBuilder extends StatelessWidget {
  final Widget child;
  const MBuilder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
