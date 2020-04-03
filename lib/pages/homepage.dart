import 'package:flutter/material.dart';
import '../models/homepage_assets.dart';
import '../models/globalthemes.dart';
import './challengepage.dart';
import './storepage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.store),
            iconSize: 40,
            // padding: EdgeInsets.only(right: 30,),
            color: Colors.black,
            padding: EdgeInsets.only(left: 20),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              iconSize: 40,
              // padding: EdgeInsets.only(right: 30,),
              color: Colors.black,
              onPressed: () {},
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
            ),
          ],
          backgroundColor: mainBackgroundColor,
          elevation: 0,
        ),
        backgroundColor: mainBackgroundColor,
        body: PageView(
          children: <Widget>[
            MainPageLayout(),
            ChallengePage("Poopoo"),
            // CardsSectionAlignment(context)  
          ],
          scrollDirection: Axis.vertical,
        ));
  }
}

class MainPageLayout extends StatelessWidget {
  const MainPageLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
      Padding(padding: EdgeInsets.only(top: 60)),
      PhotoCircle(diam: 200.0),
      Padding(padding: EdgeInsets.only(top: 60)),
      StreakCounter(),
      Padding(padding: EdgeInsets.only(top: 90)),
      IconButton(
        icon: Icon(Icons.keyboard_arrow_up),
        iconSize: 150,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => StorePage()));
        },
      ),
      Icon(Icons.keyboard_arrow_up, size: 150),
    ]));
  }
}

