import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rive/rive.dart';

class PlayPauseAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlayPauseAnimationState();
}

class _PlayPauseAnimationState extends State<PlayPauseAnimation> {

  late RiveAnimationController _controller;

  void _togglePlay() => setState(() => _controller.isActive = !_controller.isActive);

  bool get isPlaying => _controller.isActive;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = SimpleAnimation('idle');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Example'),
      ),
      body: RiveAnimation.asset(
        'assets/off_road_car.riv',
        fit: BoxFit.cover,
        controllers: [_controller],
        onInit: (_) => setState(() {}),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _togglePlay,),
    );
  }
}