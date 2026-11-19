import 'package:flutter/material.dart';

class BibleWidget extends StatelessWidget {
  const BibleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Bible Widget'),),
      body: const Placeholder(),
    );
  }
}