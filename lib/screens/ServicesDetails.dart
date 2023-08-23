import 'package:flutter/material.dart';
import 'package:ihms/screens/booking.dart';
import 'package:ihms/screens/tabbar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'otp_screen.dart';

class ServicesDetails extends StatefulWidget {
  String name, description, image;
  int id;
  ServicesDetails(this.name, this.description, this.image, this.id);

  @override
  _MyHomePage4State createState() => _MyHomePage4State();
}

class _MyHomePage4State extends State<ServicesDetails> {
  Future navigateToTabbar(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Tabbar()));
  }

  final space = SizedBox(height: 10);

  FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 240,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.height * 0.00,
                MediaQuery.of(context).size.height * 0.24,
                MediaQuery.of(context).size.height * 0.00,
                MediaQuery.of(context).size.height * 0.00,
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: ExactAssetImage("assets/images/bg_color.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.00,
                    MediaQuery.of(context).size.height * 0.15,
                    MediaQuery.of(context).size.height * 0.00,
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                            alignment: Alignment.center,
                            textDirection: TextDirection.rtl,
                            fit: StackFit.loose,
                            overflow: Overflow.visible,
                            clipBehavior: Clip.hardEdge,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                //elevation: 3,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40.0),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 30, right: 20),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(widget.name,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFba8e1c))),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(widget.description,
                                                style: TextStyle(
                                                    height: 1.5,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFcbb269))),
                                            SizedBox(
                                              height: 17,
                                            ),
                                            Text("",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFcbb269))),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text("",
                                                // "Drivers are available from 10 hours to 24 hours a day,and 7 days week. No panic and worry  for you because when it tourble.just call us.Whatever you need , we can arrange a driver for you!",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFcbb269))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: -25,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Booking_Screen(widget.image,
                                                    widget.id, widget.name)));
                                  },
                                  child: Center(
                                    child: Container(
                                      width: 260,
                                      margin: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFF9a7210), width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                70.0) //                 <--- border radius here
                                            ),
                                        color: Colors.brown,
                                      ),
                                      child: Container(
                                        height: 70,
                                        width: 260,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              const Color(0xFFb48919),
                                              const Color(0xFF9a7210),
                                            ],
                                          ),
                                          border: Border.all(
                                              color: Colors.white, width: 4),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  70.0) //                 <--- border radius here
                                              ),
                                        ),
                                        child: Center(
                                          child: Text("BOOK A REQUEST",
                                              style: GoogleFonts.sourceSansPro(
                                                  textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 3,
                                                      fontSize: 16,
                                                      color: Colors.white))),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(height: 70)
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
