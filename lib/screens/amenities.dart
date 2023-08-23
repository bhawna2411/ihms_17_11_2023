import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/AmenitiesResponseModel.dart';
import 'package:ihms/screens/amenitiesdetails.dart';

class ImageDetail {
  final String path;
  final String name;

  ImageDetail({this.path, this.name});
}

class amenities_screen extends StatefulWidget {
  const amenities_screen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<amenities_screen> {
  ScrollController controller = ScrollController();
  AmenitiesResponseModel amenitiesResponseModel;
  List<Datumm> amenitiesList;
  Future _loadevents;

  loadevents() {
    setState(() {
      _loadevents = getAmenities();
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
                    "AMENITIES",
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
                  //decoration: BoxDecoration(shape: BoxShape.rectangle),
                  child: Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder(
                          future: _loadevents,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator());
                            } else {
                              amenitiesResponseModel = snapshot.data;
                              amenitiesList = amenitiesResponseModel.data;
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
                                  itemCount: amenitiesList.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        amenities_details(
                                                          amenitiesList[index]
                                                          // amenitiesList[index]
                                                          //     .name,
                                                          // amenitiesList[index]
                                                          //     .description,
                                                          // amenitiesList[index]
                                                          //     .image,
                                                          // amenitiesList[index]
                                                          //     .location,
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
                                                    margin:
                                                        EdgeInsets.fromLTRB(
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
                                                            amenitiesList[
                                                                    index]
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
                                                            amenitiesList[
                                                                    index]
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

// class ImagePath extends StatelessWidget {
//   ImageDetail carddetail;
//   ImagePath(this.carddetail);
//   //ignore: must_be_immutable
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => {},
//       child:FutureBuilder(builder: builder),

//        Row(
//         children: [
//           GestureDetector(
//             onTap: () => {},
//             child: Card(
//               shape: RoundedRectangleBorder(
//                 side: BorderSide(color: const Color(0xFF848484), width: 1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.13,
//                 width: MediaQuery.of(context).size.height * 0.13,
//                 decoration: BoxDecoration(
//                 shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.fromLTRB(5, 11, 2, 7),
//                       height: MediaQuery.of(context).size.height * 0.07,
//                       width: MediaQuery.of(context).size.width * 0.15,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(130),
//                         ),
//                         image: DecorationImage(
//                           image: AssetImage("${carddetail.path}"),
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "${carddetail.name}",
//                             style: GoogleFonts.sourceSansPro(
//                               textStyle: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 1,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),

//     );
//   }
// }
