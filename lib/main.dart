import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutternome/grid.dart';
import 'package:flutternome/grid_button.dart';
import 'package:flutternome/grid_control.dart';

final gridSize = 16;
final buttons = List.generate(
  gridSize,
  (columnIndex) => List.generate(
    gridSize,
    (rowIndex) => GridButton(rowIndex, columnIndex),
  ),
);

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
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var buttonGrid = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons
          .map(
            (buttonColumn) => Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttonColumn,
            ),
          )
          .toList(),
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTapDown: (details) {
                  int column = (details.localPosition.dx / 25).floor();
                  int row = (details.localPosition.dy / 25).floor();

                  Provider.of<Grid>(context).isButtonSelected(column, row)
                      ? Provider.of<Grid>(context).removeButton(column, row)
                      : Provider.of<Grid>(context).addButton(column, row);

                  print(details.localPosition);
                },
                onPanUpdate: (details) {
                  int column = (details.localPosition.dx / 25).floor();
                  int row = (details.localPosition.dy / 25).floor();

                  Provider.of<Grid>(context).addButton(column, row);

                  print(details.localPosition);
                },
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(width: 2.0, color: Color(0xFF3e3e3e))),
                  child: buttonGrid,
                ),
              ),
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
