import 'package:flutter/material.dart';

class DisableWrapper extends StatelessWidget {
  final Widget child;
  final bool absorbing;
  const DisableWrapper({
    super.key,
    required this.child,
    required this.absorbing,
  });

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing,
      child: absorbing
          ? ImageFiltered(
              imageFilter: const ColorFilter.mode(
                Colors.black45,
                BlendMode.srcIn,
              ),
              child: child,
            )
          : child,
    );
  }
}
