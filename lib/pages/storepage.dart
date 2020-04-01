import 'package:flutter/material.dart';
import '../models/globalthemes.dart';


class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
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
      body: Text("Store")
    );
  }
}