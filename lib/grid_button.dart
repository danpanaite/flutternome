import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'grid.dart';

class GridButton extends StatelessWidget {
  final int row;
  final int column;

  const GridButton(this.row, this.column, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Grid>(
      builder: (context, grid, child) {
        return GestureDetector(
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(width: 2.0, color: Color(0xFF3e3e3e)),
            ),
            child: RaisedButton(
              elevation: 5.0,
              color: grid.isButtonSelected(column, row)
                  ? grid.isPlaying ? Color(0xFFcdedfd) : Color(0xFFffbdc0)
                  : Colors.white,
              onPressed: grid.isButtonSelected(column, row)
                  ? () => Provider.of<Grid>(context).removeButton(column, row)
                  : () => Provider.of<Grid>(context).addButton(column, row),
            ),
          ),
        );
      },
    );
  }
}
