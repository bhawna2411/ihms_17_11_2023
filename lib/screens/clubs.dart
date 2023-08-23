import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/ClubsResponseModel.dart';
import 'package:ihms/screens/dashboard_screen.dart';
import 'package:ihms/screens/tabbar.dart';
import 'club_details.dart';

class ImageDetail {
  final String path;
  final String name;

  ImageDetail({this.path, this.name});
}

class clubs_screen extends StatefulWidget {
  bool bottomTabbar;
  clubs_screen(this.bottomTabbar);

  @override
  _ClubScreenState createState() => _ClubScreenState();
}

class _ClubScreenState extends State<clubs_screen> {
  ScrollController controller = ScrollController();
  ClubsResponseModel clubsResponseModel;
  List<Datumclub> clubsList;
  Future _loadclubs;

  loadevents() {
    setState(() {
      _loadclubs = getClubs();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // print("Hellokkjj");
    loadevents();
    super.initState();
  }

  List<ImageDetail> carddetails = [
    ImageDetail(path: "assets/images/saloon.png", name: "VIP ClUB"),
    ImageDetail(path: "assets/images/swimming.png", name: "ELEVATE GOLF CLUB"),
    ImageDetail(path: "assets/images/restro.png", name: "AQUA CLUB"),
    ImageDetail(path: "assets/images/saloon.png", name: "SANDS CLUB"),
    ImageDetail(path: "assets/images/saloon.png", name: "MEZZARIA CLUB"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
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
                MediaQuery.of(context).size.height * 0.28,
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
                MediaQuery.of(context).size.height * 0.06,
                MediaQuery.of(context).size.height * 0.00,
                MediaQuery.of(context).size.height * 0.00,
              ),
              child: widget.bottomTabbar
                  ? InkWell(
                      child: new IconButton(
                        icon: new Icon(
                          Icons.arrow_back,
                          size: 20,
                        ),
                        color: Color(0xFF203040),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => DashboardScreen()));
                        },
                      ),
                    )
                  : InkWell(
                      child: new IconButton(
                        icon: new Icon(
                          Icons.arrow_back,
                          size: 20,
                        ),
                        color: Color(0xFF203040),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => Tabbar()));
                        },
                      ),
                    ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.00,
                  MediaQuery.of(context).size.height * 0.08,
                  MediaQuery.of(context).size.height * 0.00,
                  MediaQuery.of(context).size.height * 0.00,
                ),
                child: Text(
                  "CLUBS",
                  style: GoogleFonts.sourceSansPro(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF203040),
                      fontSize: 17,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
             top:   MediaQuery.of(context).size.height * 0.10,
              ),
              // color:Colors.green ,
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.84,
                    width: MediaQuery.of(context).size.width,
                    // margin: EdgeInsets.fromLTRB(
                    //   MediaQuery.of(context).size.height * 0.000,
                    //   MediaQuery.of(context).size.height * 0.018,
                    //   MediaQuery.of(context).size.height * 0.000,
                    //   MediaQuery.of(context).size.height * 0.018,
                    // ),
                    //decoration: BoxDecoration(shape: BoxShape.rectangle),
                    // color: Colors.pink,
                    child: Container(
                      // color: Colors.amber,
                      // margin: EdgeInsets.all(12),
                      margin: EdgeInsets.only(
                          top: 12, bottom: 12, right: 12, left: 12),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder(
                        future: _loadclubs,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("");
                          } else {
                            print("snapshot   ------    ${snapshot.data}");
                            clubsResponseModel = snapshot.data;
                            clubsList = clubsResponseModel.data;

                            print(
                                "clublist length    -------     ${clubsList.length}");
                            return GridView.builder(
                              controller: controller,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                crossAxisCount: 2,
                              ),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: clubsList.length,
                              itemBuilder: (context, index) {
                                return 
                                
                                
                                
                                GestureDetector(
                                  onTap: () {
                                    print(clubsList[index]
                                            .learn_more
                                            .toString() +
                                        "=========>>>");
                                    Navigator.of(context,
                                            rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                club_details(
                                                    clubsList[index])));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: const Color(0xFF848484),
                                          width: 1),
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      height: MediaQuery.of(context)
                                              .size
                                              .height *
                                          0.20,
                                      width: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.42,
                                      decoration: BoxDecoration(
                                          // color: Colors.red,
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                5,
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                2,
                                                5),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.08,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                            decoration: BoxDecoration(
                                              // color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    clubsList[index].icon),
                                                // fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    clubsList[index].name,
                                                     textAlign:
                                                        TextAlign.center,
                                                    maxLines: 3,
                                                    // softWrap: true,
                                                    style: GoogleFonts
                                                        .sourceSansPro(
                                                      textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                             
                             
                             
                              },
                            );
                          }
                        },
                      ),
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
