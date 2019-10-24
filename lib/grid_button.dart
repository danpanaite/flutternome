import 'package:flutter/material.dart';
import 'package:flutter_midi/flutter_midi.dart';

final scale = [60, 63, 65, 67, 70];

class GridButton extends StatefulWidget {
  final int row;

  const GridButton(this.row, {Key key}) : super(key: key);

  @override
  _GridButtonState createState() => _GridButtonState();
}

class _GridButtonState extends State<GridButton> {
  bool _isSelected = false;
  int _midiNote;

  @override
  void initState() {
    _midiNote = scale[widget.row % 5] + 12 * (widget.row / 5).floor();

    super.initState();
  }

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
        FlutterMidi.playMidiNote(midi: _midiNote);
      } else {
        FlutterMidi.stopMidiNote(midi: _midiNote);
      }
    });
  }
}
