import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class Grid extends ChangeNotifier {
  final gridSize;
  final playSpeed;

  int selectedColumn = 0;
  StreamSubscription subscription;

  Grid({this.gridSize = 6, this.playSpeed = 1000});

  void play() {
    subscription?.cancel();

    subscription = Metronome.periodic(
      Duration(milliseconds: playSpeed),
    ).listen((value) {
      selectedColumn = (selectedColumn + 1) % gridSize;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }
}
