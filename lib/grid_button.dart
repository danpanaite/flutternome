import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'grid.dart';

class GridButton extends StatefulWidget {
  final int row;
  final int column;

  const GridButton(this.row, this.column, {key}) : super(key: key);

  @override
  _GridButtonState createState() => _GridButtonState();
}

class _GridButtonState extends State<GridButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<Grid>(
      builder: (context, grid, child) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(width: 2.0, color: Color(0xFF3e3e3e)),
          ),
          child: RaisedButton(
            elevation: 5.0,
            color: _isSelected ? Color(0xFFffbdc0) : Colors.white,
            onPressed: _toggleSelected,
          ),
        );
      },
    );
  }

  void _toggleSelected() {
    if (!_isSelected) {
      Provider.of<Grid>(context, listen: false).addButton(widget);
    } else {
      Provider.of<Grid>(context, listen: false).removeButton(widget);
    }

    setState(() {
      _isSelected = !_isSelected;
    });
  }
}
