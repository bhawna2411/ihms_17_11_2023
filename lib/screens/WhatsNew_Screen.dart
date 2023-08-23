import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/WhatsNewResponseModel.dart';
import 'package:ihms/screens/dashboard_screen.dart';
import 'package:ihms/screens/whatsnew_detail_screen.dart';
import 'package:link_text/link_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WhatsNewScreen extends StatefulWidget {
  @override
  _WhatsNewScreenState createState() => _WhatsNewScreenState();
}

ValueNotifier<bool> reloadData = ValueNotifier(false);
ValueNotifier<String> updatedSociety = ValueNotifier("");

class _WhatsNewScreenState extends State<WhatsNewScreen> {
  WhatsNewResponseModel whatsNewResponseModel = new WhatsNewResponseModel();
  List<Datumwhatsnew> whatsnewList = [];
  List<Datumwhatsnew> filteredwhatsnew = [];
  // ignore: non_constant_identifier_names
  String user_society = '';
  Future _loadwhatsnew;

  loadwhatsnew() {
    filteredwhatsnew.clear();
    print("load whats new ----------------------");
    _loadwhatsnew = whatspdf();
  }

  loadsociety() async {
    print("load society -----------------------");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_society = prefs.getString('updatedsociety');
      print("what'snew user_society ======= $user_society");
      updatedSociety.value = user_society;
    });
  }

  @override
  void initState() {
    super.initState();
    loaddata();
  }

  loaddata() async {
    await loadwhatsnew();
    await loadsociety();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.90,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/dashboard_bg.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.height * 0.00,
              MediaQuery.of(context).size.height * 0.32,
              MediaQuery.of(context).size.height * 0.00,
              MediaQuery.of(context).size.height * 0.00,
            ),
            height: MediaQuery.of(context).size.height * 0.76,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_color.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.height * 0.01,
                MediaQuery.of(context).size.height * 0.02,
                MediaQuery.of(context).size.height * 0.00,
                MediaQuery.of(context).size.height * 0.00,
              ),
              child: InkWell(
                child: new IconButton(
                  icon: new Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  color: Color(0xFF203040),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()),
                    );
                  },
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // "DIGITAL NOTICE BOARD",
                  "WHAT'S NEW",
                  style: GoogleFonts.sourceSansPro(
                    textStyle: TextStyle(
                      // fontWeight: FontWeight.w500,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF203040),
                      fontSize: 18,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.only(top: 90, left: 20, right: 20, bottom: 20),
            child:
                // ListView.builder(
                //     itemCount: 4,
                //     itemBuilder: (context, i) {
                //       return Container(
                //         height: MediaQuery.of(context).size.height * 0.20,
                //         padding: EdgeInsets.only(bottom: 10),
                //         child: ClipRRect(
                //           borderRadius: BorderRadius.circular(20.0),
                //           child: Image.network(
                //               'https://googleflutter.com/sample_image.jpg',
                //               fit: BoxFit.cover),
                //         ),
                //       );
                //     }),
                ValueListenableBuilder(
              valueListenable: reloadData,
              builder: (BuildContext context, bool value, Widget child) =>
                  value == true || value == false
                      ? ValueListenableBuilder(
                          valueListenable: updatedSociety,
                          builder: (BuildContext context, String society,
                                  Widget child) =>
                              FutureBuilder(
                                  future: whatspdf(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                     
                                      return Center(
                                          child: CircularProgressIndicator());
                                    } else {
                                      whatsNewResponseModel = snapshot.data;
                                      whatsnewList = whatsNewResponseModel.data;
                                      filteredwhatsnew = [];
                                      for (int i = 0;
                                          i < whatsnewList.length;
                                          i++) {

                                        if (whatsnewList[i].society ==
                                            society) {
                                          filteredwhatsnew.add(whatsnewList[i]);
                                        }
                                      }

                                      return ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: whatsnewList.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              WhatsNewDetailScreen(
                                                                  whatsnewList[
                                                                      index])));
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Card(
                                                    elevation: 4,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0), //add border radius
                                                      child: Image.network(
                                                        whatsnewList[index]
                                                            .posterImage,
                                                        height: 120.0,
                                                        width: 100.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                //  Container(
                                                //   height:
                                                //       MediaQuery.of(context).size.height * 0.20,
                                                //   child: Card(
                                                //     elevation: 5,

                                                //     shape: RoundedRectangleBorder(

                                                //         borderRadius:
                                                //             BorderRadius.circular(20)),
                                                //     child: Image.network(
                                                //       filteredwhatsnew[index].posterImage,
                                                //       fit: BoxFit.fitHeight,
                                                //     ),
                                                //   ),
                                                // ),
                                                );
                                          });
                                    }
                                  }),
                        )
                      : Container(
                          child: Text("else"),
                        ),
            ),
          )

          // Padding(
          //   padding:
          //       const EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 20),
          //   child:
          //    FutureBuilder(
          //       future: _loadwhatsnew,
          //       builder: (context, snapshot) {
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return Center(child: CircularProgressIndicator());
          //         } else {
          //           whatsNewResponseModel = snapshot.data;
          //           whatsnewList = whatsNewResponseModel.data;
          //           for (int i = 0; i < whatsnewList.length; i++) {
          //             if (whatsnewList[i].society == user_society) {
          //               filteredwhatsnew.add(whatsnewList[i]);
          //             }
          //           }
          //           return ListView.builder(
          //               shrinkWrap: true,
          //               scrollDirection: Axis.vertical,
          //               itemCount: filteredwhatsnew.length,
          //               itemBuilder: (context, index) {
          //                 String _text = filteredwhatsnew[index].url;
          //                 return Padding(
          //                   padding: const EdgeInsets.only(bottom: 30),
          //                   child: Card(
          //                       elevation: 5,
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(10),
          //                       ),
          //                       child: Container(
          //                         // height: 100,
          //                         padding: EdgeInsets.all(10),
          //                         decoration: BoxDecoration(
          //                             borderRadius: BorderRadius.circular(10),
          //                             color: Colors.white),
          //                         child: Row(
          //                           children: [
          //                             Column(
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               children: [
          //                                 Row(children: [
          //                                   Text(
          //                                     "Title :-",
          //                                     style: GoogleFonts.sourceSansPro(
          //                                       textStyle: TextStyle(
          //                                         fontWeight: FontWeight.w600,
          //                                         color: Color(0xFF96700f),
          //                                         fontSize: 16,
          //                                       ),
          //                                     ),
          //                                   ),
          //                                 ]),
          //                                 SizedBox(
          //                                   height: 10,
          //                                 ),
          //                                 Row(children: [
          //                                   Text(
          //                                     "Society :-",
          //                                     style: GoogleFonts.sourceSansPro(
          //                                       textStyle: TextStyle(
          //                                         fontWeight: FontWeight.w600,
          //                                         color: Color(0xFF96700f),
          //                                         fontSize: 16,
          //                                       ),
          //                                     ),
          //                                   ),
          //                                 ]),
          //                                 SizedBox(
          //                                   height: 10,
          //                                 ),
          //                                 Row(children: [
          //                                   Text("Description :-",
          //                                       style:
          //                                           GoogleFonts.sourceSansPro(
          //                                         textStyle: TextStyle(
          //                                           fontWeight: FontWeight.w600,
          //                                           color: Color(0xFF96700f),
          //                                           fontSize: 16,
          //                                         ),
          //                                       )),
          //                                 ]),
          //                                 SizedBox(
          //                                   height: 10,
          //                                 ),
          //                                 Row(children: [
          //                                   Text("Link :-",
          //                                       style:
          //                                           GoogleFonts.sourceSansPro(
          //                                         textStyle: TextStyle(
          //                                           fontWeight: FontWeight.w600,
          //                                           color: Color(0xFF96700f),
          //                                           fontSize: 16,
          //                                         ),
          //                                       )),
          //                                 ]),
          //                               ],
          //                             ),
          //                             SizedBox(
          //                               width: 5,
          //                             ),
          //                             Column(
          //                               crossAxisAlignment:
          //                                   CrossAxisAlignment.start,
          //                               children: [
          //                                 Container(
          //                                   width: MediaQuery.of(context)
          //                                           .size
          //                                           .height *
          //                                       .26,
          //                                   child: Row(children: [
          //                                     Expanded(
          //                                       child: Text(
          //                                         filteredwhatsnew[index]
          //                                             ?.title,
          //                                         maxLines: 2,
          //                                         style:
          //                                             GoogleFonts.sourceSansPro(
          //                                           textStyle: TextStyle(
          //                                             fontWeight:
          //                                                 FontWeight.w600,
          //                                             color: Color(0xFF203040),
          //                                             fontSize: 14,
          //                                           ),
          //                                         ),
          //                                       ),
          //                                     ),
          //                                   ]),
          //                                 ),
          //                                 SizedBox(
          //                                   height: 10,
          //                                 ),
          //                                 Container(
          //                                   width: MediaQuery.of(context)
          //                                           .size
          //                                           .height *
          //                                       .26,
          //                                   child: Row(children: [
          //                                     Expanded(
          //                                       child: Text(
          //                                         filteredwhatsnew[index]
          //                                             ?.society
          //                                             .toString(),
          //                                         maxLines: 2,
          //                                         style:
          //                                             GoogleFonts.sourceSansPro(
          //                                           textStyle: TextStyle(
          //                                             fontWeight:
          //                                                 FontWeight.w600,
          //                                             color: Color(0xFF203040),
          //                                             fontSize: 14,
          //                                           ),
          //                                         ),
          //                                       ),
          //                                     ),
          //                                   ]),
          //                                 ),
          //                                 SizedBox(
          //                                   height: 10,
          //                                 ),
          //                                 Container(
          //                                   width: MediaQuery.of(context)
          //                                           .size
          //                                           .height *
          //                                       .26,
          //                                   child: Row(children: [
          //                                     Expanded(
          //                                       child: Text(
          //                                           filteredwhatsnew[index]
          //                                               .description,
          //                                           maxLines: 2,
          //                                           overflow:
          //                                               TextOverflow.ellipsis,
          //                                           style: GoogleFonts
          //                                               .sourceSansPro(
          //                                             textStyle: TextStyle(
          //                                               fontWeight:
          //                                                   FontWeight.w600,
          //                                               color:
          //                                                   Color(0xFF203040),
          //                                               fontSize: 14,
          //                                             ),
          //                                           )),
          //                                     ),
          //                                   ]),
          //                                 ),
          //                                 SizedBox(
          //                                   height: 10,
          //                                 ),
          //                                 Container(
          //                                   width: MediaQuery.of(context)
          //                                           .size
          //                                           .height *
          //                                       .26,
          //                                   child: FittedBox(
          //                                     child: Row(children: [
          //                                       LinkText(
          //                                         _text,
          //                                         textStyle: TextStyle(
          //                                           fontSize: 5,
          //                                         ),
          //                                       ),
          //                                     ]),
          //                                   ),
          //                                 ),
          //                               ],
          //                             ),
          //                           ],
          //                         ),
          //                       )),
          //                 );
          //               });
          //         }
          //       }
          //       ),

          // ),
        ],
      ),
    ));
  }
}
