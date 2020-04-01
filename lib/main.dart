import 'package:flutter/material.dart';
import 'package:spice/models/globalthemes.dart';
import './pages/homepage.dart';
import './pages/storepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spice',
      theme: ThemeData(
          primarySwatch: Colors.red, iconTheme: IconThemeData(size: 40)),
      home: MyHomePage(title: 'Spice'),
    );
  }
}
