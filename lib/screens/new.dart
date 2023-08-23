import 'dart:core';
import 'package:flutter/material.dart';

class ParticipantsDetailScreen extends StatefulWidget {
  @override
  ParticipantsDetailScreen();
  _ParticipantsDetailScreenState createState() =>
      _ParticipantsDetailScreenState();
}

class _ParticipantsDetailScreenState extends State<ParticipantsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFfbf0d4),
        body: SingleChildScrollView(
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * .50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage("assets/images/dashboard_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.29,
              ),
              height: MediaQuery.of(context).size.height * .7,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: ExactAssetImage("assets/images/bg_color.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
              ),
              child: InkWell(
                child: new IconButton(
                    icon: new Icon(
                      Icons.arrow_back,
                      size: 20,
                    ),
                    color: Color(0xFF203040),
                    onPressed: () => {Navigator.pop(context)}),
              ),
            ),
            Column(
              children: [],
            ),
          ]),
        ));
  }
}
