import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:flutternome/grid.dart';

import 'grid_button.dart';

const gridSize = 6;

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => Grid(gridSize: gridSize),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stopwatch _stopwatch = Stopwatch();

  @override
  initState() {
    FlutterMidi.unmute();
    rootBundle.load("assets/Happy_Mellow.sf2").then((sf2) {
      FlutterMidi.prepare(sf2: sf2, name: "Happy_Mellow.sf2");
    });

    _stopwatch.start();

    Provider.of<Grid>(context, listen:false).play();

    super.initState();
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
            return GridButton(rowIndex, columnIndex,
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
