import 'package:flutter/material.dart';
import 'package:flutter_midi/flutter_midi.dart';

class GridButton extends StatefulWidget {
  @override
  _GridButtonState createState() => _GridButtonState();
}

class _GridButtonState extends State<GridButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
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
  }

  void _toggleSelected() {
    setState(() {
      _isSelected = !_isSelected;

      if (_isSelected) {
        FlutterMidi.playMidiNote(midi: 60);
      } else {
        FlutterMidi.stopMidiNote(midi: 60);
      }
    });
  }
}
