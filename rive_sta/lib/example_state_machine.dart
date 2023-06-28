import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class ExampleStateMachine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExampleStateMachineState();
}

class _ExampleStateMachineState extends State<ExampleStateMachine> {

  Artboard? _artboard;
  StateMachineController? _controller;
  SMIInput<bool>? _hoverInput;
  SMIInput<bool>? _pressInput;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.load('assets/rocket.riv').then((data) async {
      final _riveFile = RiveFile.import(data);
      final artboard = _riveFile.mainArtboard;
      var controller = StateMachineController.fromArtboard(artboard, 'Button');
      if(controller!=null) {
        artboard.addController(controller);
        _hoverInput = controller.findInput('Hover');
        _pressInput = controller.findInput('Press');
      }
      setState(() => _artboard = artboard);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Button State Machine'),),
      body: _artboard == null 
        ? const SizedBox()
        : MouseRegion(
          onEnter: (_) => _hoverInput?.value= true,
          onExit: (_) => _hoverInput?.value = false,
          child: GestureDetector(
                onTapDown: (_) => _pressInput?.value = true,
                onTapCancel: () => _pressInput?.value = false,
                onTapUp: (_) => _pressInput?.value = false,
                child: Stack(
                  children: [
                    Rive(
                      fit: BoxFit.cover,
                      artboard: _artboard!,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                          'Try pressing the button...',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
          ),
        ),
  );
}