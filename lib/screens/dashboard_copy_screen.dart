import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/EventsResponseModel.dart';
import 'package:ihms/models/AmenitiesResponseModel.dart';
import 'package:ihms/models/ActivitiesResponseModel.dart';
import 'package:ihms/models/ServicesResponseModel.dart';
import 'package:ihms/screens/Actvities.dart';
import 'package:ihms/screens/Services.dart';
import 'package:ihms/screens/amenities.dart';
import 'package:ihms/screens/amenitiesdetails.dart';
import 'package:ihms/screens/ServicesDetails.dart';
import 'package:ihms/screens/ActivitiesDetails.dart';
import 'package:ihms/screens/participate_screen.dart';
import 'package:ihms/screens/tabbar.dart';
import 'package:intl/intl.dart';

class ImageDetail {
  final String path;
  final String name;

  ImageDetail({this.path, this.name});
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController searchEventController = TextEditingController();
  ScrollController controller = ScrollController();
  EventsResponseModel eventsResponseModel;
  AmenitiesResponseModel amenitiesResponseModel;
  ServicesResponseModel servicesResponseModel;
  ActivitiesResponseModel activitiesResponseModel;
  List<EventData> eventList = [];
  List<EventData> futureEvents = [];
  List<EventData> initialeventList = [];
  List<EventData> searchEventList;
  List<Datumm> amenitiesList = [];
  List<Data> servicesList = [];
  List<Result> activitiesList = [];
  Future _loadevents;
  Future _loadamenities;
  Future _loadservices;
  Future _loadactivities;
  var _currentDate = DateTime.now();

  loadevents() async {
    setState(() {
      _loadevents = getEvents();
      _loadamenities = getAmenities();
      _loadservices = getServices();
      _loadactivities = getActivities();
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    loadevents();
    getEvents().then((value) {
      searchEventList = value.data;
      print('-------------------value.data------------${value.data}');
      for (var each in value.data) {
        var datetime = each.date + ' ' + each.time;
        if (_currentDate.isBefore(DateTime.parse(datetime))) {
          futureEvents.add(each);
        }
      }
      setState(() {});
      print("future event list from init =======  ${futureEvents.length}");
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var index;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.9,
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
              height: MediaQuery.of(context).size.height * 0.95, //1.1,
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
                MediaQuery.of(context).size.height * 0.00,
                MediaQuery.of(context).size.height * 0.02,
                MediaQuery.of(context).size.height * 0.00,
                MediaQuery.of(context).size.height * 0.00,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.02,
                      width: MediaQuery.of(context).size.width * 0.05,
                      margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.height * 0.02,
                        MediaQuery.of(context).size.height * 0.04,
                        MediaQuery.of(context).size.height * 0.00,
                        MediaQuery.of(context).size.height * 0.00,
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/menu.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.037,
                    width: MediaQuery.of(context).size.width * 0.30,
                    margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.height * 0.135,
                      MediaQuery.of(context).size.height * 0.04,
                      MediaQuery.of(context).size.height * 0.00,
                      MediaQuery.of(context).size.height * 0.00,
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo copy 3.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.height * 0.02,
                MediaQuery.of(context).size.height * 0.13,
                MediaQuery.of(context).size.height * 0.02,
                MediaQuery.of(context).size.height * 0.00,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 3,
                    blurRadius: 5,
                    // offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.78,
                    child: TextField(
                      onChanged: filterEvents,
                      controller: searchEventController,
                      cursorColor: const Color(0xFF455a64),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: const Color(0xFF455a64),
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: 'Search By Events...',
                        hintStyle: TextStyle(
                          color: Color(0xff455a64),
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          // fontFamily: "SourceSansPro",
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      searchEventController.clear();
                      FocusScope.of(context).requestFocus(new FocusNode());
                      Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute(builder: (context) => Tabbar()));
                    },
                    icon: searchEventController.text.length > 0
                        ? Icon(Icons.cancel_outlined)
                        : new Container(
                            height: 0.0,
                          ),
                    color: const Color(0xFF455a64),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.height * 0.00,
                top: MediaQuery.of(context).size.height * 0.21,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "POPULAR EVENTS",
                            style: GoogleFonts.sourceSansPro(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF203040),
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 15),
                  //   child: Container(
                  //     // margin: EdgeInsets.only(
                  //     //   left: MediaQuery.of(context).size.height * 0.02,
                  //     //   top: MediaQuery.of(context).size.height * 0.24,
                  //     // ),
                  //     child: Row(
                  //       children: [
                  //         Text("",
                  //           // "Explore these interesting finds!",
                  //           style: GoogleFonts.sourceSansPro(
                  //             textStyle: TextStyle(
                  //                 color: Color(0xff203040),
                  //                 fontWeight: FontWeight.w400,
                  //                 fontSize: 13),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: FutureBuilder(
                      future: _loadevents,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else {
                          eventsResponseModel = snapshot.data;
                          initialeventList = eventsResponseModel.data;
                          eventList = initialeventList
                              .where((element) => element.name
                                  .toLowerCase()
                                  .startsWith(searchEventController.text))
                              .toList();
                          print(
                              " future event list length ==== ${futureEvents.length}");
                          return Row(
                            children: [
                              eventList.length == 0
                                  ? Container()
                                  : Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.268,
                                      width: MediaQuery.of(context).size.width,
                                      child:
                                          // eventList.length != 0 ||
                                          searchEventController.text.isNotEmpty
                                              ? ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: eventList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .push(MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Participate_Screen(
                                                                        eventList[
                                                                            index])));
                                                      },
                                                      child: Card(
                                                        color: Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: const Color(
                                                                  0xFF848484),
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        margin: index ==
                                                                eventList
                                                                        .length -
                                                                    1
                                                            ? EdgeInsets
                                                                .fromLTRB(20, 0,
                                                                    20, 0)
                                                            : EdgeInsets
                                                                .fromLTRB(20, 0,
                                                                    0, 0),
                                                        child: Container(
                                                          // height: MediaQuery.of(context)
                                                          //         .size
                                                          //         .height *
                                                          //     0.50,
                                                          // width: MediaQuery.of(context).size.width * 0.50,
                                                          // height: 200,
                                                          width: 300,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.18,

                                                                // height: 180,
                                                                width: 300,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                  image:
                                                                      DecorationImage(
                                                                    image: eventList[index].splitImage[0] ==
                                                                            ''
                                                                        ? NetworkImage(
                                                                            'https://th.bing.com/th/id/OIP._ZIjfYAE0_HpYth1f-mq2QHaE7?pid=ImgDet&rs=1',
                                                                          )
                                                                        : NetworkImage(
                                                                            eventList[index].splitImage[0],
                                                                          ),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                              FittedBox(
                                                                //height: 67,
                                                                // decoration: BoxDecoration(
                                                                //   borderRadius:
                                                                //       BorderRadius.only(
                                                                //           bottomLeft:
                                                                //               Radius.circular(
                                                                //                   10),
                                                                //           bottomRight:
                                                                //               Radius.circular(
                                                                //                   10)),
                                                                // ),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .fromLTRB(
                                                                        15,
                                                                        0,
                                                                        0,
                                                                        0,
                                                                      ),
                                                                      height:
                                                                          40,
                                                                      width: 40,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: const Color(
                                                                            0xFFfbf0d4),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            DateFormat("MMM").format(DateTime.parse(eventList[index].date)),

                                                                            // eventList[index]
                                                                            //     .date,
                                                                            style:
                                                                                GoogleFonts.sourceSansPro(
                                                                              textStyle: TextStyle(
                                                                                color: const Color(0xFF96700f),
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            DateFormat("d").format(DateTime.parse(eventList[index].date)),
                                                                            style:
                                                                                GoogleFonts.sourceSansPro(
                                                                              textStyle: TextStyle(
                                                                                color: const Color(0xFF333333),
                                                                                fontWeight: FontWeight.w700,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      //width: 210,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            eventList[index].name,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                GoogleFonts.sourceSansPro(
                                                                              textStyle: TextStyle(
                                                                                color: const Color(0xFF96700f),
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 16,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.location_on,
                                                                                size: 15,
                                                                                color: const Color(0xFFc0a155),
                                                                              ),
                                                                              FittedBox(
                                                                                fit: BoxFit.cover,
                                                                                child: SizedBox(
                                                                                  width: 200,
                                                                                  child: eventList[index].location == null
                                                                                      ? Text("location")
                                                                                      : Text(
                                                                                          eventList[index].location,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          maxLines: 2,
                                                                                          style: GoogleFonts.sourceSansPro(
                                                                                            textStyle: TextStyle(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              color: const Color(0xFF333333),
                                                                                              fontSize: 13,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
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
                                                  })
                                              : ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      futureEvents.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        // String date =
                                                        //     "2019-07-19 8:40:23";
                                                        // String time = "8:40:23";
                                                        // DateTime datetime =
                                                        //     DateFormat("hh:mm").parse(
                                                        //         "2019-07-19 8:40:23");
                                                        // print("time date");
                                                        // print(datetime);
                                                        // print(DateTime.parse(
                                                        //     time));
                                                        // print(DateTime.parse(
                                                        //     eventList[index]
                                                        //         .time));
                                                        // print(eventList[index]
                                                        //     .date);
                                                        Navigator.of(context,
                                                                rootNavigator:
                                                                    true)
                                                            .push(MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Participate_Screen(
                                                                        futureEvents[
                                                                            index])));
                                                      },
                                                      child: Card(
                                                        color: Colors.white,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: const Color(
                                                                  0xFF848484),
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        margin: index ==
                                                                futureEvents
                                                                        .length -
                                                                    1
                                                            ? EdgeInsets
                                                                .fromLTRB(20, 0,
                                                                    20, 0)
                                                            : EdgeInsets
                                                                .fromLTRB(20, 0,
                                                                    0, 0),
                                                        child: Container(
                                                          // height: MediaQuery.of(context)
                                                          //         .size
                                                          //         .height *
                                                          //     0.50,
                                                          // width: MediaQuery.of(context).size.width * 0.50,
                                                          // height: 200,
                                                          width: 300,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.18,

                                                                // height: 180,
                                                                width: 300,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                  image:
                                                                      DecorationImage(
                                                                    image: futureEvents[index].splitImage[0] ==
                                                                            null
                                                                        ? NetworkImage(
                                                                            "https://th.bing.com/th/id/OIP._ZIjfYAE0_HpYth1f-mq2QHaE7?pid=ImgDet&rs=1")
                                                                        : NetworkImage(
                                                                            futureEvents[index].splitImage[0],
                                                                          ),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                              FittedBox(
                                                                //height: 67,
                                                                // decoration: BoxDecoration(
                                                                //   borderRadius:
                                                                //       BorderRadius.only(
                                                                //           bottomLeft:
                                                                //               Radius.circular(
                                                                //                   10),
                                                                //           bottomRight:
                                                                //               Radius.circular(
                                                                //                   10)),
                                                                // ),
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .fromLTRB(
                                                                              15,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                      height:
                                                                          40,
                                                                      width: 40,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: const Color(
                                                                            0xFFfbf0d4),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            DateFormat("MMM").format(DateTime.parse(futureEvents[index].date)),
                                                                            style:
                                                                                GoogleFonts.sourceSansPro(
                                                                              textStyle: TextStyle(
                                                                                color: const Color(0xFF96700f),
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            DateFormat("d").format(DateTime.parse(futureEvents[index].date)),
                                                                            style:
                                                                                GoogleFonts.sourceSansPro(
                                                                              textStyle: TextStyle(
                                                                                color: const Color(0xFF333333),
                                                                                fontWeight: FontWeight.w700,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      //width: 210,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            futureEvents[index].name,
                                                                            overflow:
                                                                                TextOverflow.ellipsis, //celebrations...",
                                                                            style:
                                                                                GoogleFonts.sourceSansPro(
                                                                              textStyle: TextStyle(
                                                                                color: const Color(0xFF96700f),
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 16,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.location_on,
                                                                                size: 15,
                                                                                color: const Color(0xFFc0a155),
                                                                              ),
                                                                              FittedBox(
                                                                                fit: BoxFit.cover,
                                                                                child: SizedBox(
                                                                                  width: 200,
                                                                                  child: futureEvents[index].location == null
                                                                                      ? Text("location")
                                                                                      : Text(
                                                                                          futureEvents[index].location,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          maxLines: 2,
                                                                                          style: GoogleFonts.sourceSansPro(
                                                                                            textStyle: TextStyle(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              color: const Color(0xFF333333),
                                                                                              fontSize: 13,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ],
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
                                                ),
                                    ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15),
                    child: Container(
                      // margin: EdgeInsets.only(
                      //   left: MediaQuery.of(context).size.height * 0.02,
                      //   top: MediaQuery.of(context).size.height * 0.58,
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "AMENITIES",
                            style: GoogleFonts.sourceSansPro(
                              textStyle: TextStyle(
                                color: const Color(0xFFfbf0d4),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              amenities_screen()));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 20),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.030,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFffffff),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color(0xFF96700f),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "VIEW ALL",
                                        style: GoogleFonts.sourceSansPro(
                                          textStyle: TextStyle(
                                              color: const Color(0xFFc0a155),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 0),
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "",
                            // "Explore these interesting finds!",
                            style: GoogleFonts.sourceSansPro(
                              textStyle: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, top: 10),
                    child:

                        // amenitiesList.length == 0
                        //     ? Container()
                        //     :
                        // amenitiesList.length == 0
                        //     ? Container()
                        Container(
                            // margin: EdgeInsets.fromLTRB(
                            //   MediaQuery.of(context).size.width * 0.00,
                            //   MediaQuery.of(context).size.height * 0.65,
                            //   MediaQuery.of(context).size.height * 0.00,
                            //   MediaQuery.of(context).size.height * 0.00,
                            // ),
                            child: FutureBuilder(
                                future: _loadamenities,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text("");
                                  } else {
                                    amenitiesResponseModel = snapshot.data;
                                    amenitiesList = amenitiesResponseModel.data;
                                    return Row(
                                      children: [
                                        amenitiesList.length == 0
                                            ? Container()
                                            : Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 0, 0, 0),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.12,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        amenitiesList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () => {
                                                          Navigator.of(context,
                                                                  rootNavigator:
                                                                      true)
                                                              .push(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          amenities_details(
                                                                             amenitiesList[index]
                                                                            // amenitiesList[index].name,
                                                                            // amenitiesList[index].description,
                                                                            // amenitiesList[index].image,
                                                                            // amenitiesList[index].location,
                                                                          )))
                                                        },
                                                        child: Card(
                                                          // margin: EdgeInsets.only(
                                                          //   left: MediaQuery.of(context).size.height * 0.023,
                                                          //),
                                                          color: Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: const Color(
                                                                    0xFF848484),
                                                                width: 1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  7, 0, 0, 0),
                                                          child: Container(
                                                            width: 105,
                                                            height: 70,
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          10,
                                                                          15,
                                                                          10,
                                                                          10),
                                                                  height: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .height *
                                                                      0.05,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.10,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .all(
                                                                      Radius
                                                                          .circular(
                                                                              5),
                                                                    ),
                                                                    image:
                                                                        DecorationImage(
                                                                      image: NetworkImage(
                                                                          amenitiesList[index]
                                                                              .icon),
                                                                      fit: BoxFit
                                                                          .fill,
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
                                                                        child:
                                                                            Text(
                                                                          "${amenitiesList[index].name}",
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style:
                                                                              GoogleFonts.sourceSansPro(
                                                                            textStyle:
                                                                                TextStyle(
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: const Color(0xFF333333),
                                                                              // fontWeight: FontWeight.w400,
                                                                              letterSpacing: 0,
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
                                                    }),
                                              )
                                      ],
                                    );
                                  }
                                })),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: Container(
                      // margin: EdgeInsets.only(
                      //   left: MediaQuery.of(context).size.height * 0.02,
                      //   top: MediaQuery.of(context).size.height * 0.82,
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "CONCIERGE SERVICES",
                            style: GoogleFonts.sourceSansPro(
                              textStyle: TextStyle(
                                color: const Color(0xFFfbf0d4),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print("conciergesdfds");
                                  Navigator.of(context, rootNavigator: true)
                                      .push(MaterialPageRoute(
                                          builder: (context) =>
                                              ServicesScreen(false)));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 20),
                                  child: Container(
                                    // margin: EdgeInsets.fromLTRB(
                                    //   MediaQuery.of(context).size.height * 0.37,
                                    //   MediaQuery.of(context).size.height * 0.825,
                                    //   MediaQuery.of(context).size.height * 0.02,
                                    //   MediaQuery.of(context).size.height * 0.00,
                                    // ),
                                    height: MediaQuery.of(context).size.height *
                                        0.030,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFffffff),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: const Color(0xFF96700f),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "VIEW ALL",
                                        style: GoogleFonts.sourceSansPro(
                                          textStyle: TextStyle(
                                              color: const Color(0xFFc0a155),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Container(
                      // margin: EdgeInsets.only(
                      //   left: MediaQuery.of(context).size.height * 0.021,
                      //   top: MediaQuery.of(context).size.height * 0.85,
                      // ),
                      child: Row(
                        children: [
                          Text(
                            "",
                            // "Explore these interesting finds!",
                            style: GoogleFonts.sourceSansPro(
                              textStyle: TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, left: 0),
                      child: Container(
                        // margin: EdgeInsets.fromLTRB(
                        //   MediaQuery.of(context).size.height * 0.00,
                        //   MediaQuery.of(context).size.height * 0.89,
                        //   MediaQuery.of(context).size.height * 0.00,
                        //   MediaQuery.of(context).size.height * 0.00,
                        // ),
                        child: FutureBuilder(
                            future: _loadservices,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("");
                              } else {
                                servicesResponseModel = snapshot.data;
                                servicesList = servicesResponseModel.data;

                                return Row(
                                  children: [
                                    servicesList.length == 0
                                        ? Container()
                                        : Container(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.12,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: servicesList.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () => {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ServicesDetails(
                                                                            servicesList[index].name,
                                                                            servicesList[index].description,
                                                                            servicesList[index].image,
                                                                            servicesList[index].id,
                                                                          )))
                                                    },
                                                    child: Card(
                                                      // margin: EdgeInsets.only(
                                                      //   left: MediaQuery.of(context).size.height * 0.023,
                                                      //),
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color: const Color(
                                                                0xFF848484),
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              7, 0, 0, 0),
                                                      child: Container(
                                                        width: 105,
                                                        height: 70,
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape
                                                                .rectangle,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .fromLTRB(
                                                                      10,
                                                                      15,
                                                                      10,
                                                                      10),
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.05,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.10,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          5),
                                                                ),
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      servicesList[
                                                                              index]
                                                                          .icon),
                                                                  fit: BoxFit
                                                                      .fill,
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
                                                                      "${servicesList[index].name}",
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: GoogleFonts
                                                                          .sourceSansPro(
                                                                        textStyle:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color:
                                                                              const Color(0xFF333333),
                                                                          letterSpacing:
                                                                              0,
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
                                                }),
                                          )
                                  ],
                                );
                              }
                            }),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 15),
                    child: Container(
                      // margin: EdgeInsets.only(
                      //   left: MediaQuery.of(context).size.height * 0.023,
                      //   top: MediaQuery.of(context).size.height * 1.06,
                      // ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "ACTIVITIES & INTERESTS",
                            style: GoogleFonts.sourceSansPro(
                              textStyle: TextStyle(
                                color: const Color(0xFFfbf0d4),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context, rootNavigator: true).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ActivitiesScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                                top: 10,
                              ),
                              child: Container(
                                // margin: EdgeInsets.fromLTRB(
                                //   MediaQuery.of(context).size.height * 0.37,
                                //   MediaQuery.of(context).size.height * 1.069,
                                //   MediaQuery.of(context).size.height * 0.02,
                                //   MediaQuery.of(context).size.height * 0.00,
                                // ),
                                height:
                                    MediaQuery.of(context).size.height * 0.030,
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFffffff),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(0xFF96700f),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "VIEW ALL",
                                    style: GoogleFonts.sourceSansPro(
                                      textStyle: TextStyle(
                                          color: const Color(0xFFc0a155),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //     left: 15,
                  //   ),
                  //   child: Container(
                  //     // margin: EdgeInsets.only(
                  //     //   left: MediaQuery.of(context).size.height * 0.023,
                  //     //   top: MediaQuery.of(context).size.height * 1.09,
                  //     // ),
                  //     child: Row(
                  //       children: [
                  //         Text("",
                  //           // "Explore these interesting finds!",
                  //           style: GoogleFonts.sourceSansPro(
                  //             textStyle: TextStyle(
                  //                 color: const Color(0xFFFFFFFF),
                  //                 fontWeight: FontWeight.w400,
                  //                 fontSize: 13),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      // margin: EdgeInsets.fromLTRB(
                      //   MediaQuery.of(context).size.height * 0.00,
                      //   MediaQuery.of(context).size.height * 1.125,
                      //   MediaQuery.of(context).size.height * 0.00,
                      //   MediaQuery.of(context).size.height * 0.00,
                      // ),
                      child: FutureBuilder(
                          future: _loadactivities,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("");
                            } else {
                              activitiesResponseModel = snapshot.data;
                              activitiesList = activitiesResponseModel.data;
                              return Row(
                                children: [
                                  activitiesList.length == 0
                                      ? Container()
                                      : Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 0, 0, 0),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.12,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: activitiesList.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () => {
                                                    Navigator.of(context,
                                                            rootNavigator: true)
                                                        .push(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ActivitiesDetails(
                                                          activitiesList[index]
                                                              .showtags,
                                                          activitiesList[index]
                                                              .name,
                                                          activitiesList[index]
                                                              .description,
                                                          activitiesList[index]
                                                              .image,
                                                          activitiesList[index]
                                                              .location,
                                                          activitiesList[index]
                                                              .url,
                                                        ),
                                                      ),
                                                    ),
                                                  },
                                                  child: Card(
                                                    color: Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: const Color(
                                                              0xFF848484),
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    margin: EdgeInsets.fromLTRB(
                                                        7, 0, 0, 0),
                                                    child: Container(
                                                      width: 105,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                          shape: BoxShape
                                                              .rectangle,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            margin: EdgeInsets
                                                                .fromLTRB(10,
                                                                    15, 10, 10),
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.10,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5),
                                                              ),
                                                              image:
                                                                  DecorationImage(
                                                                image: NetworkImage(
                                                                    activitiesList[
                                                                            index]
                                                                        .icon),
                                                                fit:
                                                                    BoxFit.fill,
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
                                                                    "${activitiesList[index].name}",
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: GoogleFonts
                                                                        .sourceSansPro(
                                                                      textStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color: const Color(
                                                                            0xFF333333),
                                                                        letterSpacing:
                                                                            0,
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
                                              }),
                                        )
                                ],
                              );
                            }
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

  filterEvents(String val) {
    setState(() {});
    // if (val == "") {
    // } else {
    //   setState(() {
    //     eventList.clear();
    //     for (var each in searchEventList) {
    //       if (each.name.toLowerCase().contains(val)) {
    //         eventList.add(each);
    //       }
    //     }
    //   });

    //   //setState(() {});

    // }
  }

  onSearchTextChanged(String text) async {
    searchEventList.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    // filterEvents(String val) {
    //   if (val == "") {
    //   } else {
    //     print(searchEventList.length);
    //     searchEventList = [];
    //     print(searchEventList.length);
    //     print(eventList.length);
    //     print(val);
    //     for (var each in eventList) {
    //       if (each.name.contains(val)) {
    //         searchEventList.add(each);
    //       }
    //     }
    //     setState(() {});
    //     print(eventList[0].name);
    //   }
    // }
  }
}
