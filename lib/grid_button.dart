import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutternome/grid_state.dart';

class GridButton extends StatelessWidget {
  final int row;
  final int column;

  const GridButton(this.row, this.column, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GridState>(
      builder: (context, grid, child) {
        final isTriggered = grid.isButtonTrigerred(column, row);

        // blue Color(0xFFcdedfd)
        // light red Color(0xFFffbdc0)

        final color = isTriggered
            ? Color(0xFFa3c3d9).withOpacity(0.5)
            : grid.isButtonSelected(column, row)
                ? Color(0xFFa3c3d9)
                : Colors.white;

        return GestureDetector(
          child: Container(
            width: 24,
            height: 24,
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
            //   child: RaisedButton(
            //     elevation: 5.0,
            //     color: grid.isButtonSelected(column, row)
            //         ? grid.isPlaying ? Color(0xFFcdedfd) : Color(0xFFffbdc0)
            //         : Colors.white,
            //     onPressed: grid.isButtonSelected(column, row)
            //         ? () => Provider.of<Grid>(context).removeButton(column, row)
            //         : () => Provider.of<Grid>(context).addButton(column, row),
            //   ),
          ),
        );
      },
    );
  }
}
