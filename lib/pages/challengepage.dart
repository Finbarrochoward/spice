import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/globalthemes.dart';
import 'dart:math';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
      ImageCapture()
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
  // Variables
  double pos;
  AnimationController _controller;
  final Alignment defaultFrontCardAlign = Alignment(0.0, 0.0);
  Alignment frontCardAlign = Alignment(0.0, 0.0);
  double frontCardRot = 0.0;
  File _imageFile;

  // Methods

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: "Crop it"));

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  // Widgets

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
                child: Text(challengeText, style: TextStyle(fontSize: 20)),
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
          angle: (pi / 180.0) * frontCardRot,
          child: challengeCard(challengeText)),
    );
  }

  void reloadCard(newChallenge) {
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
        // pos = position.delta.dx;
        // print(pos);
      },
      onPanEnd: (_) {
        // If the front card was swiped far enough to count as swiped
        if (frontCardAlign.x > 3.0) {
          print("right");
          _pickImage(ImageSource.gallery);
        } else if (frontCardAlign.x < -3.0) {
          print("left");
          reloadCard("cash");
          frontCardAlign = defaultFrontCardAlign;
          frontCardRot = 0.0;
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

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            toolbarTitle: "Crop it"));

    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  Widget cameraButton() {
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
      child: IconButton(
          onPressed: () => _pickImage(ImageSource.gallery),
          icon: Icon(Icons.camera)),
    );
  }

  Widget skipButton() {
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
        child: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            skipButton(),
            Padding(padding: EdgeInsets.only(left: 40.0, right: 40.0)),
            cameraButton(),
          ],
        ));
  }
}
