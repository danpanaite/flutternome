import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';

// C Major pentatonic scale
final scale = [48, 50, 52, 55, 57];

class GridState extends ChangeNotifier {
  final int gridSize;
  final int playSpeed;

  StreamSubscription _subscription;
  List<int> _midiNotes;
  var _selectedColumn = 0;
  var _selectedButtons = new Map<int, Map<int, bool>>();

  GridState({this.gridSize = 6, this.playSpeed = 125}) {
    _midiNotes = List.generate(gridSize, (row) {
      return scale[row % 5] + 12 * (row / 5).floor();
    });

    rootBundle.load("assets/Perfect_Sine.sf2").then((sf2) {
      FlutterMidi.prepare(sf2: sf2, name: "Perfect_Sine.sf2");
    });
  }

  bool get isPlaying => _subscription != null && !_subscription.isPaused;

  bool isButtonTriggered(int column, int row) {
    return isButtonSelected(column, row) && column == _selectedColumn;
  }

  bool isButtonSelected(int column, int row) {
    if (!_selectedButtons.containsKey(column) ||
        !_selectedButtons[column].containsKey(row)) {
      return false;
    }

    return _selectedButtons[column][row];
  }

  void addButton(int column, int row) {
    if (!_selectedButtons.containsKey(column)) {
      _selectedButtons[column] = new Map<int, bool>();
    }

    _selectedButtons[column][row] = true;
    notifyListeners();
  }

  void removeButton(int column, int row) {
    _selectedButtons[column][row] = false;
    notifyListeners();
  }

  void reset() {
    _subscription?.pause();
    _selectedButtons = new Map<int, Map<int, bool>>();
    _selectedColumn = 0;
    notifyListeners();
  }

  void pause() {
    _subscription.pause();
    notifyListeners();
  }

  void play() {
    _subscription?.cancel();

    _subscription = Stream.periodic(
      Duration(milliseconds: playSpeed),
    ).listen((value) => playMidiNotes());
  }

  void playMidiNotes() {
    _selectedColumn = (_selectedColumn + 1) % gridSize;

    _selectedButtons[_selectedColumn]?.forEach((row, isSelected) {
      if (isSelected) {
        FlutterMidi.playMidiNote(midi: _midiNotes[row]);
      }
    });

    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
