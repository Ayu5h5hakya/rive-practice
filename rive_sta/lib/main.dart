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
  home: RiveExampleApp(),
  darkTheme: ThemeData.dark().copyWith(
    scaffoldBackgroundColor: _backgroundColor,
    appBarTheme: const AppBarTheme(backgroundColor: _appBarColor),
    colorScheme: ColorScheme.fromSwatch().copyWith(primary: _primaryColor)
  ),
  themeMode: ThemeMode.dark,
));

class RiveExampleApp extends StatefulWidget {
  const RiveExampleApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RiveExampleAppState();
}

class _RiveExampleAppState extends State<RiveExampleApp> {
  final _pages = [
     _Page('Simple Asset Animation', BasicAnim()),
     _Page('Simple Toggle Animation', PlayPauseAnimation()),
     _Page('Simple One Shot Animation', PlayOneShotAnimation()),
     _Page('Simple One Shot Animation', ExampleStateMachine()),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Rive Examples'),),
    body: Center(
      child: ListView.separated(itemBuilder: (context, index) => _NavButton(page: _pages[3]), separatorBuilder: (context, index) => const SizedBox(height: 16), itemCount: 2,),
    ),
  );
}

class _Page {
  final String name;
  final Widget page;

  const _Page(this.name, this.page);
}
 
class _NavButton extends StatelessWidget {
  const _NavButton({required this.page});

  final _Page page;

  @override
  Widget build(BuildContext context) => Center(
    child: ElevatedButton(
      child: SizedBox(
        width: 250,
        child: Center(
          child: Text(
            page.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute<void>(
          builder: (_) => page.page
        ),);
      },
    ),
  );
}