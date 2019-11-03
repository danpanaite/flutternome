import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutternome/grid.dart';

import 'grid_button.dart';
import 'grid_control_button.dart';

final gridSize = 10;
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
    // Provider.of<Grid>(context, listen: false).play();

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
              Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 2.0, color: Color(0xFF3e3e3e))),
                child: buttonGrid,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Consumer<Grid>(builder: (context, grid, child) {
                  return Container(
                    width: 350,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5.0),
                        border:
                            Border.all(width: 2.0, color: Color(0xFF3e3e3e))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GridControlButton(
                              label: 'PLAY',
                              color: grid.isPlaying
                                  ? Color(0xFFcdedfd)
                                  : Color(0xFFffbdc0),
                              onPressed: () =>
                                  grid.isPlaying ? grid.pause() : grid.play(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: GridControlButton(
                              label: 'RESET',
                              onPressed: () => grid.reset(),
                            ),
                          ),
                          GridControlButton(
                            label: 'TURBO',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
