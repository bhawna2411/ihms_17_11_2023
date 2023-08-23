import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivitiesDetails extends StatefulWidget {
  String name, description, image, location, url;
  List<String> showtags;
  ActivitiesDetails(this.showtags, this.name, this.description, this.image,
      this.location, this.url);

  @override
  _MyHomePage4State createState() => _MyHomePage4State();
}

class _MyHomePage4State extends State<ActivitiesDetails> {
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                        // overflow: Overflow.visible,
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            //elevation: 3,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
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
                                            style: GoogleFonts.sourceSansPro(
                                                textStyle: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFba8e1c)))),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Wrap(
                                          spacing: 5.0,
                                          children: widget.showtags.length < 1
                                              ? Container()
                                              : List.generate(
                                                  widget.showtags.length,
                                                  (index) {
                                                    return FittedBox(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Color(
                                                                  0xFFe2dcca),
                                                              width: 1.0),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                20.0),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 15,
                                                                    right: 15,
                                                                    top: 5,
                                                                    bottom: 5),
                                                            child: Text(
                                                              widget.showtags[
                                                                      index]
                                                                  .toLowerCase(),
                                                              style: GoogleFonts.sourceSansPro(
                                                                  textStyle: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          10,
                                                                      color: Color(
                                                                          0xFF455a64))),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),

                                          // children: [
                                          //   FittedBox(
                                          //     child: Container(
                                          //       margin:
                                          //           EdgeInsets.only(top: 10),
                                          //       decoration: BoxDecoration(
                                          //         border: Border.all(
                                          //             color: Color(0xFFe2dcca),
                                          //             width: 1.0),
                                          //         borderRadius:
                                          //             BorderRadius.all(
                                          //           Radius.circular(20.0),
                                          //         ),
                                          //       ),
                                          //       child: Center(
                                          //         child: Padding(
                                          //           padding: EdgeInsets.only(
                                          //               left: 15,
                                          //               right: 15,
                                          //               top: 5,
                                          //               bottom: 5),
                                          //           child: Text(
                                          //             "Dance Love"
                                          //                 .toUpperCase(),
                                          //             style: GoogleFonts.sourceSansPro(
                                          //                 textStyle: TextStyle(
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w600,
                                          //                     fontSize: 10,
                                          //                     color: Color(
                                          //                         0xFF455a64))),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ),
                                          //   ),
                                          //   FittedBox(
                                          //     child: Container(
                                          //       margin:
                                          //           EdgeInsets.only(top: 10),
                                          //       decoration: BoxDecoration(
                                          //         border: Border.all(
                                          //             color: Color(0xFFe2dcca),
                                          //             width: 1.0),
                                          //         borderRadius:
                                          //             BorderRadius.all(
                                          //           Radius.circular(20.0),
                                          //         ),
                                          //       ),
                                          //       child: Center(
                                          //           child: Padding(
                                          //         padding: EdgeInsets.only(
                                          //             left: 15,
                                          //             right: 15,
                                          //             top: 5,
                                          //             bottom: 5),
                                          //         child: Text(
                                          //             "Hipp Hopp".toUpperCase(),
                                          //             style: GoogleFonts.sourceSansPro(
                                          //                 textStyle: TextStyle(
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w600,
                                          //                     fontSize: 10,
                                          //                     color: Color(
                                          //                         0xFF455a64)))),
                                          //       )),
                                          //     ),
                                          //   ),
                                          //   FittedBox(
                                          //     child: Container(
                                          //       margin:
                                          //           EdgeInsets.only(top: 10),
                                          //       decoration: BoxDecoration(
                                          //         border: Border.all(
                                          //             color: Color(0xFFe2dcca),
                                          //             width: 1.0),
                                          //         borderRadius:
                                          //             BorderRadius.all(
                                          //           Radius.circular(20.0),
                                          //         ),
                                          //       ),
                                          //       child: Center(
                                          //           child: Padding(
                                          //         padding: EdgeInsets.only(
                                          //             left: 15,
                                          //             right: 15,
                                          //             top: 5,
                                          //             bottom: 5),
                                          //         child: Text(
                                          //             "Folk".toUpperCase(),
                                          //             style: GoogleFonts.sourceSansPro(
                                          //                 textStyle: TextStyle(
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w600,
                                          //                     fontSize: 10,
                                          //                     color: Color(
                                          //                         0xFF455a64)))),
                                          //       )),
                                          //     ),
                                          //   ),
                                          //   FittedBox(
                                          //     child: Container(
                                          //       margin:
                                          //           EdgeInsets.only(top: 10),
                                          //       decoration: BoxDecoration(
                                          //         border: Border.all(
                                          //             color: Color(0xFFe2dcca),
                                          //             width: 1.0),
                                          //         borderRadius:
                                          //             BorderRadius.all(
                                          //           Radius.circular(20.0),
                                          //         ),
                                          //       ),
                                          //       child: Center(
                                          //           child: Padding(
                                          //         padding: EdgeInsets.only(
                                          //             left: 15,
                                          //             right: 15,
                                          //             top: 5,
                                          //             bottom: 5),
                                          //         child: Text(
                                          //             "jazz".toUpperCase(),
                                          //             style: GoogleFonts.sourceSansPro(
                                          //                 textStyle: TextStyle(
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w600,
                                          //                     fontSize: 10,
                                          //                     color: Color(
                                          //                         0xFF455a64)))),
                                          //       )),
                                          //     ),
                                          //   ),
                                          //   FittedBox(
                                          //     child: Container(
                                          //       margin:
                                          //           EdgeInsets.only(top: 10),
                                          //       decoration: BoxDecoration(
                                          //         border: Border.all(
                                          //             color: Color(0xFFe2dcca),
                                          //             width: 1.0),
                                          //         borderRadius:
                                          //             BorderRadius.all(
                                          //           Radius.circular(20.0),
                                          //         ),
                                          //       ),
                                          //       child: Center(
                                          //           child: Padding(
                                          //               padding:
                                          //                   EdgeInsets.only(
                                          //                       left: 15,
                                          //                       right: 15,
                                          //                       top: 5,
                                          //                       bottom: 5),
                                          //               child: Text(
                                          //                   "Salsa Dance"
                                          //                       .toUpperCase(),
                                          //                   style: GoogleFonts.sourceSansPro(
                                          //                       textStyle: TextStyle(
                                          //                           fontWeight:
                                          //                               FontWeight
                                          //                                   .w600,
                                          //                           fontSize:
                                          //                               10,
                                          //                           color: Color(
                                          //                               0xFF455a64)))))),
                                          //     ),
                                          //   ),
                                          //   FittedBox(
                                          //     child: Container(
                                          //       margin:
                                          //           EdgeInsets.only(top: 10),
                                          //       decoration: BoxDecoration(
                                          //         border: Border.all(
                                          //             color: Color(0xFFe2dcca),
                                          //             width: 1.0),
                                          //         borderRadius:
                                          //             BorderRadius.all(
                                          //           Radius.circular(20.0),
                                          //         ),
                                          //       ),
                                          //       child: Center(
                                          //           child: Padding(
                                          //         padding: EdgeInsets.only(
                                          //             left: 15,
                                          //             right: 15,
                                          //             top: 5,
                                          //             bottom: 5),
                                          //         child: Text(
                                          //             "Folk".toUpperCase(),
                                          //             style: GoogleFonts.sourceSansPro(
                                          //                 textStyle: TextStyle(
                                          //                     fontWeight:
                                          //                         FontWeight
                                          //                             .w600,
                                          //                     fontSize: 10,
                                          //                     color: Color(
                                          //                         0xFF455a64)))),
                                          //       )),
                                          //     ),
                                          //   ),
                                          // ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Row(
                                            children: [
                                              Text("About ${widget.name}",
                                                  style:
                                                      GoogleFonts.sourceSansPro(
                                                          textStyle: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xFFba8e1c)))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(widget.description,
                                              style: GoogleFonts.sourceSansPro(
                                                  textStyle: TextStyle(
                                                      height: 1.5,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          Color(0xFFcbb269)))),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_sharp,
                                                size: 17,
                                                color: Color(0xFF90700b),
                                              ),
                                              Text("Location",
                                                  style:
                                                      GoogleFonts.sourceSansPro(
                                                          textStyle: TextStyle(
                                                              fontSize: 17,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xFFba8e1c)))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(widget.location,
                                              style: GoogleFonts.sourceSansPro(
                                                  textStyle: TextStyle(
                                                      height: 1.5,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          Color(0xFFcbb269)))),
                                        ),
                                        SizedBox(
                                          height: 60,
                                        ),
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
                                print(widget.url);
                                _launchURL(widget.url);
                              },
                              child: Center(
                                child: Container(
                                  width: 260,
                                  margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
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
                                      child: Text("JOIN GROUP NOW !",
                                          style: GoogleFonts.sourceSansPro(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 3,
                                                  fontSize: 16,
                                                  color: Colors.white))),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
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

  _launchURL(String newUrl) async {
    await launch(newUrl);

    // if (await canLaunch(newUrl)) {
    //   await launch(newUrl);
    // } else {
    //   throw 'Could not launch $newUrl';
    // }
  }
}
