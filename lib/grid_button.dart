import 'package:flutter/material.dart';
import 'package:flutternome/grid_size.dart';
import 'package:provider/provider.dart';

import 'package:flutternome/grid_state.dart';

class GridButton extends StatelessWidget {

  final int row;
  final int column;

  final Function onTapDown;
  final Function onPanUpdate;

  const GridButton(this.row, this.column, {key, this.onTapDown, this.onPanUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GridState>(
      builder: (context, grid, child) {

        final isTriggered = grid.isButtonTriggered(column, row);

        final color = isTriggered
            ? Color(0xFFa3c3d9).withOpacity(0.5)
            : grid.isButtonSelected(column, row)
                ? Color(0xFFa3c3d9)
                : Colors.white;

        return GestureDetector(
          onTapDown: this.onTapDown,
          onPanUpdate: this.onPanUpdate,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 125),
            width: GridSize.buttonWidth,
            height: GridSize.buttonHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: !isTriggered
                  ? Border.all(width: 2.0, color: Color(0xFF3e3e3e))
                  : null,
              boxShadow: isTriggered
                  ? [
                      BoxShadow(
                        blurRadius: 12.0,
                        spreadRadius: 2.0,
                        color: Colors.white,
                      ),
                    ]
                  : [],
              color: color,
            ),
          ),
        );
      },
    );
  }
}
