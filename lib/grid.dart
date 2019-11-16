import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';

final scale = [60, 63, 65, 67, 70];

class Grid extends ChangeNotifier {
  final int gridSize;
  final int playSpeed;

  StreamSubscription _subscription;
  List<int> _midiNotes;
  var _stopwatch = new Stopwatch();
  var _selectedColumn = 0;
  var _selectedButtons = new Map<int, Map<int, bool>>();

  Grid({this.gridSize = 6, this.playSpeed = 125}) {
    _midiNotes = List.generate(gridSize, (row) {
      return scale[row % 5] + 12 * (row / 5).floor();
    });

    FlutterMidi.unmute();
    rootBundle.load("assets/Perfect Sine.sf2").then((sf2) {
      FlutterMidi.prepare(sf2: sf2, name: "Perfect Sine.sf2");
    });
  }

  bool get isPlaying => _subscription != null && !_subscription.isPaused;

  bool isButtonTrigerred(int column, int row) {
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
    notifyListeners();
  }

  void pause() {
    _subscription.pause();
    notifyListeners();
  }

  void play() {
    _subscription?.cancel();
    _stopwatch.start();

    _subscription = Stream.periodic(
      Duration(milliseconds: playSpeed),
    ).listen((value) => playMidiNotes());

    notifyListeners();
  }

  void playMidiNotes() {
    _selectedColumn = (_selectedColumn + 1) % gridSize;

    _selectedButtons[_selectedColumn]?.forEach((row, isSelected) async{
      if (isSelected) {
        FlutterMidi.playMidiNote(midi: _midiNotes[row]);

        Future.delayed(Duration(milliseconds: 100),
            () => FlutterMidi.stopMidiNote(midi: _midiNotes[row]));
      }
    });

    // if (_selectedButtons.containsKey(_selectedColumn)) {
    //   var column = _selectedButtons[_selectedColumn];

    //   for (var row in column.keys) {
    //     if (column[row]) {
    //       var test = await FlutterMidi.playMidiNote(midi: _midiNotes[row]);

    //       print(test);

    //       Future.delayed(Duration(milliseconds: 100),
    //           () => FlutterMidi.stopMidiNote(midi: _midiNotes[row]));
    //     }
    //   }
    // }

    notifyListeners();

    print(_stopwatch.elapsedMilliseconds);
    _stopwatch.reset();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
