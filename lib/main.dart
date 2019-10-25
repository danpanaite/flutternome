import 'dart:async';

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
  StreamSubscription<int> _gameSubscription;
  int _column;
  Stopwatch _stopwatch = Stopwatch();

  @override
  initState() {
    FlutterMidi.unmute();
    rootBundle.load("assets/Happy_Mellow.sf2").then((sf2) {
      FlutterMidi.prepare(sf2: sf2, name: "Happy_Mellow.sf2");
    });

    _gameSubscription = Stream.periodic(Duration(milliseconds: 300),
            (value) => value = (value + 1) % gridSize)
        .listen((value) => setState(() {
              _column = value;
            }));

    _stopwatch.start();

    super.initState();
  }

  @override
  void dispose() {
    _gameSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var buttonGrid = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(gridSize, (columnIndex) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(gridSize, (rowIndex) {
            return GridButton(rowIndex, columnIndex == _column,
                stopwatch: _stopwatch);
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
