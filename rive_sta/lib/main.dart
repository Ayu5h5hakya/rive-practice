import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

import 'example_state_machine.dart';
import 'one_shot_animation.dart';
import 'simple_animation.dart';
import 'simple_playpause_animation.dart';


const _appBarColor = Color(0xFF323232);
const _backgroundColor = Color(0xFF1D1D1D);
const _primaryColor = Color(0xFF57A5E0);

void main() => runApp(MaterialApp(
  title: 'Rive Example',
  home: LiquidDownload(),
  darkTheme: ThemeData.dark().copyWith(
    scaffoldBackgroundColor: _backgroundColor,
    appBarTheme: const AppBarTheme(backgroundColor: _appBarColor),
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: _primaryColor)
  ),
  themeMode: ThemeMode.dark,
));

class LiquidDownload extends StatefulWidget {
  const LiquidDownload({Key? key}) : super(key: key);

  @override
  State<LiquidDownload> createState() => _LiquidDownloadState();
}

class _LiquidDownloadState extends State<LiquidDownload> {
  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<double>? _progress;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/coffee.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller =
            StateMachineController.fromArtboard(artboard, 'State Machine 1');
        if (controller != null) {
          artboard.addController(controller);
          _progress = controller.findInput('scrollpercent');
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liquid Download'),
      ),
      body: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : GestureDetector(
              onTap: () {
                print('object');
              },
                onVerticalDragUpdate: (details) {
                              if (details.delta.dy > 0) {
              // Down Swipe
              print(details.delta.dy);
              _progress!.value += 1;
            } else if (details.delta.dy < 0) {
              // Up Swipe
             _progress!.value -= 1;
             print(details.delta.dy);
            }
                },
                child :Rive(
                          artboard: _riveArtboard!,
                        ),
              ),
      ),
    );
  }
}