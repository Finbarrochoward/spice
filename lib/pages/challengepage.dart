import 'package:flutter/material.dart';
import '../models/globalthemes.dart';

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      ChallengeCard(),
      Padding(
        padding: EdgeInsets.only(bottom: 70),
      ),
      ChallengeButtonsLayout()
    ]));
  }
}

class ChallengePageLayout extends StatefulWidget {
  @override
  _ChallengePageLayoutState createState() => _ChallengePageLayoutState();
}

class _ChallengePageLayoutState extends State<ChallengePageLayout> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        margin: EdgeInsets.only(bottom: 150, left: 10, right: 10, top: 25),
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(39),
            // color: Colors.red,
            gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 15.0,
                  spreadRadius: 8.0)
            ]),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20)),
            Text("Daily Spice",
                style: TextStyle(
                  fontSize: 30,
                )),
          ],
        ));
  }
}

// One try at making cards

class ChallengeBoxCard extends StatelessWidget {
  const ChallengeBoxCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            child: Card(
                child: AnimatedContainer(
                    margin: EdgeInsets.only(
                        bottom: 150, left: 10, right: 10, top: 25),
                    duration: Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(39),
                        gradient:
                            LinearGradient(colors: [Colors.red, Colors.orange]),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 0.0),
                              blurRadius: 15.0,
                              spreadRadius: 8.0)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Text("Daily Spice",
                            style: TextStyle(
                              fontSize: 30,
                            )),
                      ],
                    ))))
      ],
    );
  }
}

// Current attempt

class ChallengeCard extends StatefulWidget {
  @override
  _ChallengeCardState createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard>
    with TickerProviderStateMixin {
  AnimationController _buttonController;
  Animation<double> rotate;
  Animation<double> right;
  Animation<double> bottom;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    // Rotate
    rotate = Tween<double>(begin: -0.0, end: -40.0).animate(
        CurvedAnimation(parent: _buttonController, curve: Curves.ease));
    rotate.addListener(() {});

    // Right
    right = Tween<double>(begin: 0.0, end: 400.0).animate(
        CurvedAnimation(parent: _buttonController, curve: Curves.ease));

    // Bottom
    bottom = Tween<double>(begin: 15.0, end: 100.0).animate(
        CurvedAnimation(parent: _buttonController, curve: Curves.ease));

    Future<Null> _swipeAnimation() async {
      try {
        await _buttonController.forward();
      } on TickerCanceled {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0.0,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.only(top: 20.0),
          width: MediaQuery.of(context).size.width / 1.1,
          height: MediaQuery.of(context).size.height / 1.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(39),
              color: Colors.green,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 15.0,
                    spreadRadius: 8.0)
              ]),
          child: Column(children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 14,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(39),
                        topRight: Radius.circular(39)),
                    color: Colors.green),
                child: Text("Daily Spice", style: TextStyle(fontSize: 30))),
            Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 1.7 -
                    MediaQuery.of(context).size.height / 14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(39),
                  gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
                ),
                child: Column(children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text("Challenge", style: TextStyle(fontSize: 20))),
                  Container(
                    margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                    child: Text(
                        "Take a photo with you holding a spoon on your nose while reading todays newspaper",
                        style: TextStyle(fontSize: 20)),
                  )
                ]))
          ]),
        ),
      ),
    );
  }
}

class ChallengeButtonsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ChallengeButton(),
            Padding(padding: EdgeInsets.only(left: 40.0, right: 40.0)),
            ChallengeButton()
          ],
        ));
  }
}

class ChallengeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 0.0),
                blurRadius: 15.0,
                spreadRadius: 8.0)
          ]),
      child: IconButton(onPressed: () {}, icon: Icon(Icons.attach_money)),
    );
  }
}
