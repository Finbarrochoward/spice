import 'package:flutter/material.dart';

class PhotoCircle extends StatelessWidget {
  double diam;

  PhotoCircle({this.diam});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            width: diam,
            height: diam,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 15.0,
                      spreadRadius: 8.0)
                ])),
        CircleAvatar(
          backgroundColor: Colors.black,
          maxRadius: (diam - 20) / 2,
          minRadius: (diam - 20) / 2,
        )
      ],
      alignment: Alignment(0, 0),
    );
  }
}

class StreakCounter extends StatefulWidget {
  @override
  _StreakCounterState createState() => _StreakCounterState();
}

class _StreakCounterState extends State<StreakCounter> {
  int _streak = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: <Widget>[
      Icon(Icons.flash_on),
      Padding(padding: EdgeInsets.only(left: 10, right: 10)),
      Text(_streak.toString(), style: TextStyle(fontSize: 30))
    ], mainAxisAlignment: MainAxisAlignment.center));
  }
}

class UpArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Icon(Icons.keyboard_arrow_up, size: 150),
        Icon(Icons.keyboard_arrow_up, size: 150)
      ],
      alignment: Alignment.bottomCenter
    );
  }
}
