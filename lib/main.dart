import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutternome/grid_state.dart';
import 'package:flutternome/grid_control.dart';
import 'package:flutternome/grid.dart';
import 'package:flutternome/grid_size.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      builder: (context) => GridState(gridSize: GridSize.size),
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
              Grid(gridSize: GridSize.size),
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
