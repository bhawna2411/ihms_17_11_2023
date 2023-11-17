import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/models/ClubsResponseModel.dart';
import 'package:ihms/screens/gallery.dart';
import 'package:ihms/screens/tabbar.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';

class club_details extends StatefulWidget {
  ClubsResponseModel clubsResponseModel;
  Datumclub clubsList;
  club_details(this.clubsList);
  @override
  _MyHomePage4State createState() => _MyHomePage4State();
}

class ImageDetail {
  final String path;
  final String height;

  ImageDetail({this.path, this.height});
}

class _MyHomePage4State extends State<club_details> {
  Future navigateToTabbar(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Tabbar()));
  }

  final space = SizedBox(height: 10);
  Future<void> _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                  image: NetworkImage(widget.clubsList.backgroundImage),
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
              child: Container(
                  child: Column(
                children: [
                  Center(
                    child: Stack(
                        alignment: Alignment.center,
                        textDirection: TextDirection.rtl,
                        fit: StackFit.loose,
                        // overflow: Overflow.visible,
                        clipBehavior: Clip.hardEdge,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.height * 0.00,
                              MediaQuery.of(context).size.height * 0.10,
                              MediaQuery.of(context).size.height * 0.00,
                              MediaQuery.of(context).size.height * 0.10,
                            ),
                            child: Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  //elevation: 3,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.85,
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
                                              Text("${widget.clubsList.name}",
                                                  style:
                                                      GoogleFonts.sourceSansPro(
                                                          textStyle: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xFFba8e1c)))),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                  "${widget.clubsList.shortDescription}",
                                                  style:
                                                      GoogleFonts.sourceSansPro(
                                                          textStyle: TextStyle(
                                                              height: 1.5,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xFFcbb269)))),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: Row(
                                                  children: [
                                                    Text("Gallery",
                                                        style: GoogleFonts.sourceSansPro(
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
                                              GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisSpacing: 5,
                                                    mainAxisSpacing: 5,
                                                    crossAxisCount: 4,
                                                  ),
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: widget
                                                      .clubsList.gallery.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.of(context,
                                                                    rootNavigator:
                                                                        true)
                                                                .push(MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        Galleryimage(widget
                                                                            .clubsList
                                                                            .gallery)));
                                                          },
                                                          child: Hero(
                                                            tag: "item",
                                                            child: Container(
                                                              height: 50,
                                                              width: 60,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: NetworkImage(widget
                                                                      .clubsList
                                                                      .gallery[index]),
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    );
                                                  }),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: Row(
                                                  children: [
                                                    Text("About",
                                                        style: GoogleFonts.sourceSansPro(
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
                                              Text("${widget.clubsList.about}",
                                                  style:
                                                      GoogleFonts.sourceSansPro(
                                                          textStyle: TextStyle(
                                                              height: 1.5,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xFFcbb269)))),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.location_on_sharp,
                                                      size: 17,
                                                      color: Color(0xFF90700b),
                                                    ),
                                                    Text("Location",
                                                        style: GoogleFonts.sourceSansPro(
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
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: Text(
                                                    "${widget.clubsList.location}",
                                                    style: GoogleFonts
                                                        .sourceSansPro(
                                                            textStyle: TextStyle(
                                                                height: 1.5,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xFFcbb269)))),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 15),
                                                child: Row(
                                                  children: [
                                                    widget.clubsList.phone ==
                                                            null
                                                        ? Container()
                                                        : Text(
                                                            "Contact Details",
                                                            style: GoogleFonts.sourceSansPro(
                                                                textStyle: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xFFba8e1c)))),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  launch(
                                                      "tel:${widget.clubsList.phone}");
                                                },
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 5),
                                                  child: widget.clubsList
                                                              .phone ==
                                                          null
                                                      ? Container()
                                                      : Row(
                                                          children: [
                                                            Icon(
                                                              Icons.phone,
                                                              color: Color(
                                                                  0xFFcbb269),
                                                              size: 15,
                                                            ),
                                                            Text(
                                                              "${widget.clubsList.phone} ",
                                                              style: GoogleFonts
                                                                  .sourceSansPro(
                                                                textStyle:
                                                                    TextStyle(
                                                                  height: 1.5,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0xFFcbb269),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  _launchURL(
                                                      widget.clubsList.url);
                                                },
                                                child: Center(
                                                  child:
                                                      widget.clubsList
                                                                  .learn_more ==
                                                              0
                                                          ? Container()
                                                          : GestureDetector(
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              2,
                                                                          horizontal:
                                                                              10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    gradient:
                                                                        LinearGradient(
                                                                      begin: Alignment
                                                                          .centerLeft,
                                                                      end: Alignment
                                                                          .centerRight,
                                                                      colors: [
                                                                        const Color(
                                                                            0xFFb48919),
                                                                        const Color(
                                                                            0xFF9a7210),
                                                                      ],
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(70.0) //                 <--- border radius here
                                                                            ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "Learn More",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          letterSpacing:
                                                                              1,
                                                                          fontSize:
                                                                              13,
                                                                          color:
                                                                              Colors.white),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              )),
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
                          onPressed: () {
                            Navigator.pop(context);
                          }),
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
