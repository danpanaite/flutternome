import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';

import 'grid_button.dart';

final scale = [60, 63, 65, 67, 70];

class Grid extends ChangeNotifier {
  final int gridSize;
  final int playSpeed;
  final selectedButtons = new Map<int, List<int>>();

  int selectedColumn = 0;
  StreamSubscription subscription;
  List<int> midiNotes;
  Stopwatch stopwatch = new Stopwatch();

  Grid({this.gridSize = 6, this.playSpeed = 150}) {
    midiNotes = List.generate(gridSize, (row) {
      return scale[row % 5] + 12 * (row / 5).floor();
    });
  }

  void addButton(GridButton button) {
    selectedButtons.containsKey(button.column)
        ? selectedButtons[button.column].add(button.row)
        : selectedButtons.putIfAbsent(button.column, () => [button.row]);
  }

  void removeButton(GridButton button) {
    selectedButtons[button.column]?.removeWhere((row) => row == button.row);
  }

  void play() {
    subscription?.cancel();
    stopwatch.start();

    FlutterMidi.unmute();
    rootBundle.load("assets/Happy_Mellow.sf2").then((sf2) {
      FlutterMidi.prepare(sf2: sf2, name: "Happy_Mellow.sf2");
    });

    subscription = Stream.periodic(
      Duration(milliseconds: playSpeed),
    ).listen((value) {
      selectedColumn = (selectedColumn + 1) % gridSize;

      selectedButtons[selectedColumn]?.forEach((row) {
        FlutterMidi.playMidiNote(midi: midiNotes[row]);
      });

      print(stopwatch.elapsedMilliseconds);
      stopwatch.reset();
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}
