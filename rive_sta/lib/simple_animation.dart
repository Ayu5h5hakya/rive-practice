import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class BasicAnim extends StatelessWidget {
   @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('SimpleAnimation'),),
    body: const Center(
      child: RiveAnimation.network(
          'https://cdn.rive.app/animations/vehicles.riv',
          fit: BoxFit.cover,
          placeHolder: Center(child: CircularProgressIndicator()),
        ),
    ),
  );
}