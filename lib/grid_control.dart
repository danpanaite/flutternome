import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutternome/grid_state.dart';

class GridControl extends StatefulWidget {
  @override
  _GridControlState createState() => _GridControlState();
}

class _GridControlState extends State<GridControl>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GridState>(builder: (context, grid, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(
                color: Color(0xFF3e3e3e),
                width: 2.0,
              ),
            ),
            color: grid.isPlaying ? Color(0xFFa3c3d9) : Colors.white,
            onPressed: () {
              if (grid.isPlaying) {
                _animationController.reverse();
                grid.pause();
              } else {
                _animationController.forward();
                grid.play();
              }
              // grid.isPlaying ? grid.pause() : grid.play();
            },
            icon: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              color: grid.isPlaying ? Colors.white : Color(0xFF3e3e3e),
              progress: _animationController,
            ),
            label: Text(
              grid.isPlaying ? "PAUSE" : "PLAY",
              style: TextStyle(
                color: grid.isPlaying ? Colors.white : Color(0xFF3e3e3e),
              ),
            ),
          ),
          RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(
                color: Color(0xFF3e3e3e),
                width: 2.0,
              ),
            ),
            color: Colors.white,
            onPressed: () {
              _animationController.reverse();
              grid.reset();
            },
            icon: Icon(Icons.refresh),
            label: Text("RESET"),
          ),
        ],
      );
    });
  }
}
