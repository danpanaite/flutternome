import 'package:flutter/material.dart';
import 'package:flutternome/grid.dart';
import 'package:provider/provider.dart';

import 'package:flutternome/grid_state.dart';
import 'package:flutternome/grid_control.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => GridState(gridSize: 16),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutternome',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Grid(gridSize: 16),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: GridControl(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
