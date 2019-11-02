import 'package:flutter/material.dart';

class GridControlButton extends StatelessWidget {
  final String label;
  final Color color;

  final Function() onPressed;

  const GridControlButton({
    Key key,
    this.label,
    this.color = Colors.white,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(this.label),
        Container(
          width: 50,
          height: 25,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(width: 2.0, color: Color(0xFF3e3e3e)),
          ),
          child: RaisedButton(
            elevation: 5.0,
            color: this.color,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
