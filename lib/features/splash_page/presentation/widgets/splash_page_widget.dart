import 'package:flutter/material.dart';

class SplashPageWidget extends StatelessWidget {
  const SplashPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('SplashPage Widget'),),
      body: const Placeholder(),
    );
  }
}