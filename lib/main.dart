import 'package:flutter/material.dart';

import 'grid_button.dart';

void main() => runApp(MyApp());

const gridSize = 6;

class MyApp extends StatelessWidget {
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
