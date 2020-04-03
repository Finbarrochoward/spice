import 'package:flutter/material.dart';
import '../models/globalthemes.dart';
import 'dart:math';

// Overall layout of challenge page
class ChallengePage extends StatefulWidget {

  final String challengeText;
  ChallengePage(this.challengeText);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      ChallengeCard(widget.challengeText),
      Padding(
        padding: EdgeInsets.only(bottom: 70),
      ),
      ChallengeButtonsLayout()
    ]));
  }
}

// Challenge Card itself

class ChallengeCard extends StatefulWidget {

  final String challengeText;
  ChallengeCard(this.challengeText);

  @override
  _ChallengeCardState createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard>
    with SingleTickerProviderStateMixin {

  double pos;
  AnimationController _controller;
  final Alignment defaultFrontCardAlign = Alignment(0.0, 0.0);
  Alignment frontCardAlign = Alignment(0.0, 0.0);
  double frontCardRot = 0.0;

  Widget challengeCard(challengeText) {
    return Container(
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
                    challengeText,
                    style: TextStyle(fontSize: 20)),
              )
            ]))
      ]),
    );
  }

  @override
  void initState() {
    super.initState();

    // Init animation controller
    _controller =
        AnimationController(duration: Duration(milliseconds: 700), vsync: this);
    _controller.addListener(() => setState(() {}));
    _controller.addStatusListener((status) {
      // Implement reload of new challenge
    });
  }

  Widget challengeCardWidget(challengeText) {
    return Align(
      alignment: _controller.status == AnimationStatus.forward
          ? CardsAnimation.frontCardDisappearAlignmentAnim(
                  _controller, frontCardAlign)
              .value
          : frontCardAlign,
      child: Transform.rotate(
          angle: (pi / 180.0) * frontCardRot, child: challengeCard(challengeText)),
    );
  }

  void animateCards() {
    _controller.stop();
    _controller.value = 0.0;
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    String challenge = widget.challengeText;

    return GestureDetector(
      onPanUpdate: (position) {
        setState(() {
          frontCardAlign = Alignment(
              frontCardAlign.x +
                  20 * position.delta.dx / MediaQuery.of(context).size.width,
              frontCardAlign.y +
                  40 * position.delta.dy / MediaQuery.of(context).size.height);

          frontCardRot = frontCardAlign.x;
        });
        pos = position.delta.dx;
        print(pos);
      },
      onPanEnd: (_) {
        // If the front card was swiped far enough to count as swiped
        if (frontCardAlign.x > 3.0 || frontCardAlign.x < -3.0) {
          animateCards();
        } else {
          // Return to the initial rotation and alignment
          setState(() {
            frontCardAlign = defaultFrontCardAlign;
            frontCardRot = 0.0;
          });
        }
      },
      child: Card(
        color: Colors.transparent,
        elevation: 0.0,
        child: challengeCardWidget(challenge),
      ),
    );
  }
}

// Class that combines buttons into layout

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

// Individual challenge buttons

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

class CardsAnimation {
  static Animation<Alignment> frontCardDisappearAlignmentAnim(
      AnimationController parent, Alignment beginAlign) {
    return AlignmentTween(
            begin: beginAlign,
            end: Alignment(
                beginAlign.x > 0 ? beginAlign.x + 30.0 : beginAlign.x - 30.0,
                0.0) // Has swiped to the left or right?
            )
        .animate(CurvedAnimation(
            parent: parent, curve: Interval(0.0, 0.5, curve: Curves.easeIn)));
  }
}

// Prevent swiping if the cards are animating
// _controller.status != AnimationStatus.forward
//     ? SizedBox.expand(
//         child: GestureDetector(
  
