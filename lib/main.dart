import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';

import 'grid_button.dart';

void main() => runApp(MyApp());

const gridSize = 6;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    FlutterMidi.unmute();
    rootBundle.load("assets/Piano.sf2").then((sf2) {
      FlutterMidi.prepare(sf2: sf2, name: "Piano.SF2");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var buttonGrid = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(gridSize, (index) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(gridSize, (index) {
            return GridButton();
          }),
        );
      }),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(width: 2.0, color: Color(0xFF3e3e3e))),
            child: buttonGrid,
          ),
        ),
      ),
    );
  }
}
