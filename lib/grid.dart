import 'package:flutter/material.dart';
import 'package:flutternome/grid_size.dart';
import 'package:provider/provider.dart';

import 'package:flutternome/grid_state.dart';
import 'package:flutternome/grid_button.dart';

class Grid extends StatelessWidget {

  final int gridSize;

  const Grid({Key key, this.gridSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttons = List.generate(
      gridSize,
      (columnIndex) => List.generate(
        gridSize,
        (rowIndex) => GridButton(
          rowIndex,
          columnIndex,
          onTapDown: (details) {
            Provider.of<GridState>(context).isButtonSelected(columnIndex, rowIndex)
              ? Provider.of<GridState>(context).removeButton(columnIndex, rowIndex)
              : Provider.of<GridState>(context).addButton(columnIndex, rowIndex);
          },
          onPanUpdate: (details) {
            Provider.of<GridState>(context).addButton(columnIndex, rowIndex);
          }
        ),
      ),
    );

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

    return Container(
      width: GridSize.width,
      height: GridSize.height,
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(width: 2.0, color: Color(0xFF3e3e3e))),
      child: buttonGrid,
    );
  }
}