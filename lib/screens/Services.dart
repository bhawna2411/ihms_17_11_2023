import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/ServicesResponseModel.dart';
import 'package:ihms/screens/ServicesDetails.dart';
import 'package:ihms/screens/dashboard_screen.dart';
import 'package:ihms/screens/tabbar.dart';

class ImageDetail {
  final String path;
  final String name;

  ImageDetail({this.path, this.name});
}

class ServicesScreen extends StatefulWidget {
  bool bottomTabbar;
  ServicesScreen(this.bottomTabbar);

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  ScrollController controller = ScrollController();
  ServicesResponseModel servicesResponseModel;
  List<Data> servicesList;
  Future _loadevents;

  loadevents() {
    setState(() {
      _loadevents = getServices();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadevents();
    super.initState();
  }

  List<ImageDetail> carddetails = [
    ImageDetail(path: "assets/images/saloon.png", name: "SALON & SPA"),
    ImageDetail(path: "assets/images/swimming.png", name: "SWIMMMING"),
    ImageDetail(path: "assets/images/restro.png", name: "RESTAURANT"),
    ImageDetail(path: "assets/images/saloon.png", name: "SALON & SPA"),
    ImageDetail(path: "assets/images/saloon.png", name: "SALON & SPA"),
    ImageDetail(path: "assets/images/swimming.png", name: "SWIMMMING"),
    ImageDetail(path: "assets/images/restro.png", name: "RESTAURANT"),
    ImageDetail(path: "assets/images/saloon.png", name: "SALON & SPA"),
    ImageDetail(path: "assets/images/saloon.png", name: "SALON & SPA"),
    ImageDetail(path: "assets/images/swimming.png", name: "SWIMMMING"),
    ImageDetail(path: "assets/images/restro.png", name: "RESTAURANT"),
    ImageDetail(path: "assets/images/saloon.png", name: "SALON & SPA"),
    ImageDetail(path: "assets/images/saloon.png", name: "SALON & SPA"),
    ImageDetail(path: "assets/images/swimming.png", name: "SWIMMMING"),
    ImageDetail(path: "assets/images/restro.png", name: "RESTAURANT"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              MediaQuery.of(context).size.height * 0.28,
              MediaQuery.of(context).size.height * 0.00,
              MediaQuery.of(context).size.height * 0.00,
            ),
            height: MediaQuery.of(context).size.height, //* 0.76,
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
              MediaQuery.of(context).size.height * 0.04,
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
                        Navigator.push(
                            context,
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Tabbar()));
                      },
                    ),
                  ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.00,
                    MediaQuery.of(context).size.height * 0.06,
                    MediaQuery.of(context).size.height * 0.00,
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Text(
                    "CONCIERGE SERVICES",
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
              ],
            ),
          ),
          Container(
            // color: Colors.amber,
            margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.height * 0.00,
              MediaQuery.of(context).size.height * 0.10,
              MediaQuery.of(context).size.height * 0.00,
              MediaQuery.of(context).size.height * 0.05,
            ),
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder(
                          future: _loadevents,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              servicesResponseModel = snapshot.data;
                              servicesList = servicesResponseModel.data;
                              return GridView.builder(
                                  controller: controller,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5,
                                    crossAxisCount: 3,
                                  ),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: servicesList.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context,
                                                    rootNavigator: true)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        ServicesDetails(
                                                          servicesList[index]
                                                              .name,
                                                          servicesList[index]
                                                              .description,
                                                          servicesList[index]
                                                              .image,
                                                          servicesList[index]
                                                              .id,
                                                        )));
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  color:
                                                      const Color(0xFF848484),
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.13,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.13,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.fromLTRB(
                                                        5, 11, 2, 7),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.07,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(5),
                                                      ),
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            servicesList[index]
                                                                .icon),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            servicesList[index]
                                                                .name,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .sourceSansPro(
                                                              textStyle:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    1,
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
                                        ),
                                      ],
                                    );
                                  });
                            }
                          })),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
