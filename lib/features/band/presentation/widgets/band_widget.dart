import 'package:flutter/material.dart';

import '../../domain/entities/band_entity.dart';

class BandWidget extends StatelessWidget {
  final BandEntity entity;
  final Function clickBand;
  const BandWidget({
    super.key,
    required this.entity,
    required this.clickBand,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('band Widget'),
      ),
      body: const Placeholder(),
    );
  }
}
