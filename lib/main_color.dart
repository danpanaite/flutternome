import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            width: 350,
            height: 350,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            decoration: BoxDecoration(
                // gradient: LinearGradient(
                //   colors: [
                //     Color(0xFF9da1ad),
                //     Color(0xFFbfc8d7),
                //   ],
                // ),
                color: Color(0xFFcbc8cf),
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(width: 5.0, color: Color(0xFF4b3c32))),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 2.0, color: Color(0xFF3e3e3e)),
                  ),
                  child: RaisedButton(
                    elevation: 5.0,
                    color: Color(0xFFffbdc0),
                    onPressed: () {},
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 2.0, color: Color(0xFF3e3e3e)),
                  ),
                  child: RaisedButton(
                    elevation: 5.0,
                    color: Color(0xFFb5b5c1),
                    onPressed: () {},
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(width: 2.0, color: Color(0xFF3e3e3e)),
                  ),
                  child: RaisedButton(
                    elevation: 5.0,
                    color: Color(0xFFffbdc0),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
