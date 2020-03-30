import 'package:flutter/material.dart';
import 'package:spice/models/globalthemes.dart';
import './models/homepage.dart';
import './models/my_flutter_app_icons.dart';

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
                  children: <Widget>[Center(
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
                  MaterialPageRoute(builder: (context) => ChallengePage()));
              },
            ),
            Icon(Icons.keyboard_arrow_up, size: 150),
          ])),]
        ));
  }
}

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
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
    );
  }
}
