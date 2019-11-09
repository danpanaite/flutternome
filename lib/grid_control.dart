import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'grid.dart';
import 'grid_control_button.dart';

class GridControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Grid>(builder: (context, grid, child) {
      var columnIndicators = List.generate(
          grid.gridSize,
          (value) => Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(width: 2.0, color: Color(0xFF3e3e3e)))));

      return Container(
        width: 350,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(width: 2.0, color: Color(0xFF3e3e3e))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: columnIndicators,
              ),
              Row(
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
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
