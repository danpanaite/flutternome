import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';

import 'grid_button.dart';

final scale = [60, 63, 65, 67, 70];

class Grid extends ChangeNotifier {
  final int gridSize;
  final int playSpeed;
  Map<int, Map<int, bool>> _selectedButtons = new Map<int, Map<int, bool>>();

  int selectedColumn = 0;

  StreamSubscription _subscription;
  List<int> _midiNotes;
  Stopwatch _stopwatch = new Stopwatch();

  Grid({this.gridSize = 6, this.playSpeed = 150}) {
    _midiNotes = List.generate(gridSize, (row) {
      return scale[row % 5] + 12 * (row / 5).floor();
    });
  }

  bool get isPlaying => _subscription != null && !_subscription.isPaused;

  bool isButtonSelected(int column, int row) {
    if (!_selectedButtons.containsKey(column) ||
        !_selectedButtons[column].containsKey(row)) {
      return false;
    }

    return _selectedButtons[column][row];
  }

  void addButton(GridButton button) {
    if (!_selectedButtons.containsKey(button.column)) {
      _selectedButtons[button.column] = new Map<int, bool>();
    }

    _selectedButtons[button.column][button.row] = true;
    notifyListeners();
  }

  void removeButton(GridButton button) {
    _selectedButtons[button.column][button.row] = false;
    notifyListeners();
  }

  void reset() {
    _subscription.pause();
    _selectedButtons = new Map<int, Map<int, bool>>();
    notifyListeners();
  }

  void pause() {
    _subscription.pause();
    notifyListeners();
  }

  void play() {
    _subscription?.cancel();
    _stopwatch.start();

    FlutterMidi.unmute();
    rootBundle.load("assets/Happy_Mellow.sf2").then((sf2) {
      FlutterMidi.prepare(sf2: sf2, name: "Happy_Mellow.sf2");
    });

    _subscription = Stream.periodic(
      Duration(milliseconds: playSpeed),
    ).listen((value) {
      selectedColumn = (selectedColumn + 1) % gridSize;

      _selectedButtons[selectedColumn]?.forEach((row, isSelected) {
        if (isSelected) {
          FlutterMidi.playMidiNote(midi: _midiNotes[row]);
        }
      });

      print(_stopwatch.elapsedMilliseconds);
      _stopwatch.reset();
    });

    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
