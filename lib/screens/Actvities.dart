import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/ActivitiesResponseModel.dart';
import 'package:ihms/screens/ActivitiesDetails.dart';

class ImageDetail {
  final String path;
  final String name;

  ImageDetail({this.path, this.name});
}

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key key}) : super(key: key);

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  ScrollController controller = ScrollController();
  ActivitiesResponseModel activitesResponseModel;
  List<Result> activitiesList;
  Future _loadevents;

  loadevents() {
    setState(() {
      _loadevents = getActivities();
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
            child: InkWell(
              child: new IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  size: 20,
                ),
                color: Color(0xFF203040),
                onPressed: () {
                  Navigator.pop(context);
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
                    "ACTIVITIES AND INTERESTS",
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
              MediaQuery.of(context).size.height * 0.00,
            ),
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.fromLTRB(
                  //   MediaQuery.of(context).size.height * 0.000,
                  //   MediaQuery.of(context).size.height * 0.018,
                  //   MediaQuery.of(context).size.height * 0.000,
                  //   MediaQuery.of(context).size.height * 0.018,
                  // ),
                  // decoration: BoxDecoration(shape: BoxShape.rectangle),
                  child: Container(
                    // color: Colors.red,
                    margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: FutureBuilder(
                      future: _loadevents,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          print('loading');
                          return Center(child: CircularProgressIndicator());
                          // showLoader(context);
                        } else {
                          print('loaded');
                          activitesResponseModel = snapshot.data;
                          activitiesList = activitesResponseModel.data;
                          print(
                              "activities length from details ---- ${activitiesList.length}");
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
                            itemCount: activitiesList.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ActivitiesDetails(
                                            activitiesList[index].showtags,
                                            activitiesList[index].name,
                                            activitiesList[index].description,
                                            activitiesList[index].image,
                                            activitiesList[index].location,
                                            activitiesList[index].url,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: const Color(0xFF848484),
                                            width: 1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  5, 11, 2, 7),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.07,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      activitiesList[index]
                                                          .icon),
                                                  fit: BoxFit.fill,
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
                                                      activitiesList[index]
                                                          .name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                  ),
                                ],
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
    );
  }
}
