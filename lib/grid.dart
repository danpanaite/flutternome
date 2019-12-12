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
        (rowIndex) => GridButton(rowIndex, columnIndex),
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

    return GestureDetector(
      onTapDown: (details) {
        int column = (details.localPosition.dx / GridSize.divisionWidth).floor();
        int row = (details.localPosition.dy / GridSize.divisionHeight).floor();

        Provider.of<GridState>(context).isButtonSelected(column, row)
            ? Provider.of<GridState>(context).removeButton(column, row)
            : Provider.of<GridState>(context).addButton(column, row);
      },
      onPanUpdate: (details) {
        int column = (details.localPosition.dx / GridSize.divisionWidth).floor();
        int row = (details.localPosition.dy / GridSize.divisionHeight).floor();

        Provider.of<GridState>(context).addButton(column, row);
      },
      child: Container(
        width: GridSize.width,
        height: GridSize.height,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(width: 2.0, color: Color(0xFF3e3e3e))),
        child: buttonGrid,
      ),
    );
  }
}