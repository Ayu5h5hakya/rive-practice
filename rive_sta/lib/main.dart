import 'package:flutter/material.dart';
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
  home: RiveCalendarExample(),
  darkTheme: ThemeData.dark().copyWith(
    scaffoldBackgroundColor: _backgroundColor,
    appBarTheme: const AppBarTheme(backgroundColor: _appBarColor),
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: _primaryColor)
  ),
  themeMode: ThemeMode.dark,
));

class RiveCalendarExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RiveCalendarExampleState();
}

class _RiveCalendarExampleState extends State<RiveCalendarExample> {

  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Calendar'),),
    body: PageView.builder(
      controller: _controller,
      scrollDirection: Axis.vertical,
      itemBuilder: (_,index) {
        return Text(index.toString());
      }),
  );
}