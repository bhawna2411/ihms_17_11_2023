import 'dart:async';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/EventsResponseModel.dart';
import 'package:ihms/models/AmenitiesResponseModel.dart';
import 'package:ihms/models/BannerResponseModel.dart';
import 'package:ihms/models/ActivitiesResponseModel.dart';
import 'package:ihms/models/ServicesResponseModel.dart';
import 'package:ihms/screens/Actvities.dart';
import 'package:ihms/screens/Services.dart';
import 'package:ihms/screens/WhatsNew_Screen.dart';
import 'package:ihms/screens/amenities.dart';
import 'package:ihms/screens/amenitiesdetails.dart';
import 'package:ihms/screens/ServicesDetails.dart';
import 'package:ihms/screens/ActivitiesDetails.dart';
import 'package:ihms/screens/participate_screen.dart';
import 'package:ihms/screens/tabbar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  AmenitiesResponseModel amenitiesResponseModel;
  ServicesResponseModel servicesResponseModel;
  ActivitiesResponseModel activitiesResponseModel;
  BannerResponseModel bannerResponseModel;

  List<EventData> futureEvents = [];
  List<EventData> filterdate = [];
  List<EventData> initialeventList = [];
  List<EventData> searchEventList;
  List<Datumm> amenitiesList = [];
  List<Data> servicesList = [];
  List<Result> activitiesList = [];
  List<BannerData> bannersList = [];
  bool isSwitched = false;

  Future _loadevents;
  Future _loadamenities;
  Future _loadservices;
  Future _loadactivities;
  Future _loadbanners;
  List<int> persons = [];
  var fdate;
  var fdatee;
  var finalDate;
  var datetime;
  // List<int> eventlist = [];
  var _currentDate = DateTime.now();
  // var _currentDate1 = DateTime.now();
  final List<String> images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];

  _launchURL(url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  loadevents() async {
    setState(() async {
      // ignore: missing_return
      _loadevents = getEvents();
      _loadamenities = getAmenities();
      _loadservices = getServices();
      _loadactivities = getActivities();
      _loadbanners = getBanners();
    });
  }

  society() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var societyyy = prefs.getString('tempsociety');
    print("societyyy =================== $societyyy");
  }

  @override
  void initState() {
    super.initState();
    society();
    viewCountApi();
    // TODO: implement initState
    loadevents();
    print('----_loadbanners-------$_loadbanners');

    // getBanners().then(
    //   (value) {
    //     bannersList = value.result;
    //     print("getBannersvalue.... ${value.result[0].image}");
    //   },
    // );

    getfutureEvents();
    print("isSwitch value from init ------  $isSwitched");
  }

  getfutureEvents() {
    getEvents().then((value) {
      // searchEventList.clear();

      // searchEventList = value.data;
      print('-------------------value.data------------${value.data}');

      // for (var each in value.data) {
      //   if (each.start_date == '') {
      //     for (var eachh in each.multislotTime.stratTime) {
      //       persons.add(DateTime.parse(eachh).millisecondsSinceEpoch);
      //     }
      //     var _fDate =
      //         persons.reduce((curr, next) => curr > next ? curr : next);
      //     var dt = DateTime.fromMillisecondsSinceEpoch(_fDate);
      //     finalDate = DateFormat('yyyy-MM-dd hh:mm').format(dt);
      //     fdate = DateTime.parse(finalDate);
      //   } else {
      //     datetime = each.start_date + ' ' + each.start_time;
      //     fdate = DateTime.parse(datetime);
      //   }
      //   if (_currentDate.isBefore(fdate)) {
      //     futureEvents.add(each);
      //   }
      // }
      isSwitched = value.switchVal == 1 ? true : false;

      futureEvents.clear();
      for (int i = 0; i < value.data.length; i++) {
        print("------Hello------");
        if (value?.data[i].end_date == '') {
          persons.clear();
          print("multislot  ${value.data[i].multislotTime}");
          print("multislot length ${value.data.length}");
          if (value.data[i].multislotTime.length > 0) {
            print("multislot length ${value.data[i].multislotTime.length}");

            for (var eachh in value.data[i].multislotTime) {
              persons.add(DateTime.parse(eachh.endDate.toString())
                  .millisecondsSinceEpoch);
            }
            var _fDate =
                persons.reduce((curr, next) => curr > next ? curr : next);
            var dt = DateTime.fromMillisecondsSinceEpoch(_fDate);
            print("--------check----" + dt.toString());
            finalDate = DateFormat('yyyy-MM-dd hh:mm:ss').format(dt);
            fdate = DateTime.parse(dt.toString());
          }
        } else {
          datetime = value.data[i].end_date + " " + value.data[i].end_time;
          // datetime = value.data[i].start_date != null
          //     ? value.data[i].start_date
          //     : "" + ' ' + value.data[i].start_time != null
          //         ? value.data[i].start_time
          //         : "";
          print("--------single----" + datetime.toString());

          // if (datetime != ""){
          fdate = DateTime.parse(datetime);

          // }
        }
        print('------------fdate------------$fdate');
        print('------------fdate time------------$_currentDate');
        // if (fdate != null) {
        if (_currentDate.isBefore(fdate)) {
          futureEvents.add(value.data[i]);
        }
        // }

        // else {
        print("Heyyyyyyyyyyy ${futureEvents.length}");
        //   futureEvents.removeAt(i);
        // }
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var index;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
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
                // height: MediaQuery.of(context).size.height * 0.95, //1.1,
                height: MediaQuery.of(context).size.height * 1.15,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/bg_color.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.02,
                      width: MediaQuery.of(context).size.width * 0.05,
                      // margin: EdgeInsets.fromLTRB(
                      //   MediaQuery.of(context).size.height * 0.02,
                      //   MediaQuery.of(context).size.height * 0.04,
                      //   MediaQuery.of(context).size.height * 0.00,
                      //   MediaQuery.of(context).size.height * 0.00,
                      // ),
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.02),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/menu.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  // Spacer(),
                  SizedBox(
                    width: 13,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.037,
                      width: MediaQuery.of(context).size.width * 0.30,
                      // margin: EdgeInsets.fromLTRB(
                      //   MediaQuery.of(context).size.height * 0.100,
                      //   MediaQuery.of(context).size.height * 0.04,
                      //   MediaQuery.of(context).size.height * 0.03,
                      //   MediaQuery.of(context).size.height * 0.00,
                      // ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo copy 3.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10, top: 5),
                            // color: Colors.blue,
                            child: Image.asset(
                              'assets/images/meraki_blue.png',
                              // height: 60,
                              // width: 60,
                              height: 50,
                              width: 80,
                            ),
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(
                          //       right:
                          //           MediaQuery.of(context).size.height * 0.02),
                          //   child: Image.asset(
                          //     'assets/images/social_club_logo.png',
                          //     height: 50,
                          //     width: 50,
                          //   ),
                          // ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        // color: Colors.pink,
                        height: 35,
                        // width: 75,
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Row(
                              children: [
                                // Text(isSwitched ? "Off" : "On",
                                //     style: TextStyle(
                                //         fontSize: 25,
                                //         fontWeight: FontWeight.w400)),
                                Container(
                                  // margin: EdgeInsets.only(
                                  //     right:
                                  //         MediaQuery.of(context).size.height *
                                  //             0.02),
                                  child: Image.asset(
                                    'assets/images/social_club_logo.png',
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                SizedBox(width: 5),
                                CupertinoSwitch(
                                  // materialTapTargetSize :MaterialTapTargetSize.shrinkWrap,
                                  activeColor: Color(0xFFcbb269),
                                  trackColor: Colors.grey,
                                  value: isSwitched,
                                  onChanged: (value) {
                                    isSwitched = value;
                                    reloadData.value = !reloadData.value;
                                    print("isSwitched ======== $isSwitched");

                                    switchUserSociety(isSwitched, context)
                                        .then((value) {
                                      getfutureEvents();
                                      _loadbanners = getBanners();
                                      _loadamenities = getAmenities();
                                      _loadservices = getServices();
                                      _loadactivities = getActivities();
                                    });
                                  },
                                ),
                              ],
                            )),
                      ),
                    ],
                  )
                ],
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
                                  // color: Color.fromARGB(255, 64, 32, 32),
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
                        future: getEvents(),
                        builder: (context, snapshot) {
                          print(snapshot.connectionState);
                          print(
                              "calling events future builder ---------------------------");
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            print("wait state");
                            return CircularProgressIndicator();
                          } else {
                            var eventsResponseModel = snapshot.data;
                            var eventList = [];
                            initialeventList = [];
                            initialeventList = eventsResponseModel != null
                                ? eventsResponseModel.data
                                : [];
                            eventList = initialeventList
                                .where((element) => element.name
                                    .toLowerCase()
                                    .contains(searchEventController.text
                                        .toLowerCase()))
                                .toList();
                            print(
                                " eventList event list length ==== ${eventList.length}");
                            eventList.forEach((element) {
                              print(element.name);
                            });
                            return Row(
                              children: [
                                eventList.length == 0
                                    ? Container()
                                    : Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.268,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child:
                                            // eventList.length != 0 ||
                                            searchEventController
                                                    .text.isNotEmpty
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
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          margin: index ==
                                                                  eventList
                                                                          .length -
                                                                      1
                                                              ? EdgeInsets
                                                                  .fromLTRB(20,
                                                                      0, 20, 0)
                                                              : EdgeInsets
                                                                  .fromLTRB(20,
                                                                      0, 0, 0),
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
                                                                      topRight:
                                                                          Radius.circular(
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
                                                                      eventList[index].multislot ==
                                                                              0
                                                                          ? Container(
                                                                              margin: EdgeInsets.fromLTRB(
                                                                                15,
                                                                                0,
                                                                                0,
                                                                                0,
                                                                              ),
                                                                              height: 40,
                                                                              width: 40,
                                                                              decoration: BoxDecoration(
                                                                                color: const Color(0xFFfbf0d4),
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Text(
                                                                                    DateFormat("MMM").format(DateTime.parse(eventList[index]?.start_date)),

                                                                                    // eventList[index]
                                                                                    //     .date,
                                                                                    style: GoogleFonts.sourceSansPro(
                                                                                      textStyle: TextStyle(
                                                                                        color: const Color(0xFF96700f),
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Text(
                                                                                    DateFormat("d").format(DateTime.parse(eventList[index]?.start_date)),
                                                                                    style: GoogleFonts.sourceSansPro(
                                                                                      textStyle: TextStyle(
                                                                                        color: const Color(0xFF333333),
                                                                                        fontWeight: FontWeight.w700,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          : Container(
                                                                              child: Text("demo1"),
                                                                            ),
                                                                      Container(
                                                                        //width: 210,
                                                                        padding:
                                                                            EdgeInsets.all(5),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              "eventList[index].name",
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: GoogleFonts.sourceSansPro(
                                                                                textStyle: TextStyle(
                                                                                  color: const Color(0xFF96700f),
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 16,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
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
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          margin: index ==
                                                                  futureEvents
                                                                          .length -
                                                                      1
                                                              ? EdgeInsets
                                                                  .fromLTRB(20,
                                                                      0, 20, 0)
                                                              : EdgeInsets
                                                                  .fromLTRB(20,
                                                                      0, 0, 0),
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
                                                                      topRight:
                                                                          Radius.circular(
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
                                                                      futureEvents[index].multislot ==
                                                                              0
                                                                          ? Row(
                                                                              children: [
                                                                                Container(
                                                                                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                                                                    height: 40,
                                                                                    width: 40,
                                                                                    // padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                                                                    decoration: BoxDecoration(
                                                                                      color: const Color(0xFFfbf0d4),
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          DateFormat("MMM").format(DateTime.parse(futureEvents[index]?.start_date)),
                                                                                          style: GoogleFonts.sourceSansPro(
                                                                                            textStyle: TextStyle(
                                                                                              color: const Color(0xFF96700f),
                                                                                              fontWeight: FontWeight.w600,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Text(
                                                                                          DateFormat("d").format(DateTime.parse(futureEvents[index]?.start_date)),
                                                                                          style: GoogleFonts.sourceSansPro(
                                                                                            textStyle: TextStyle(
                                                                                              color: const Color(0xFF333333),
                                                                                              fontWeight: FontWeight.w700,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    )),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      ' - ',
                                                                                      style: GoogleFonts.sourceSansPro(
                                                                                        textStyle: TextStyle(
                                                                                          color: const Color(0xFF96700f),
                                                                                          fontWeight: FontWeight.w600,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                        height: 40,
                                                                                        width: 40,
                                                                                        // padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                                                                        decoration: BoxDecoration(
                                                                                          color: const Color(0xFFfbf0d4),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                        child: Column(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Text(
                                                                                              DateFormat("MMM").format(DateTime.parse(futureEvents[index]?.end_date)),
                                                                                              style: GoogleFonts.sourceSansPro(
                                                                                                textStyle: TextStyle(
                                                                                                  color: const Color(0xFF96700f),
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              DateFormat("d").format(DateTime.parse(futureEvents[index]?.end_date)),
                                                                                              style: GoogleFonts.sourceSansPro(
                                                                                                textStyle: TextStyle(
                                                                                                  color: const Color(0xFF333333),
                                                                                                  fontWeight: FontWeight.w700,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ))
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            )
                                                                          : Row(
                                                                              children: [
                                                                                Container(
                                                                                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                                                                    height: 40,
                                                                                    width: 40,
                                                                                    // padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                                                                    decoration: BoxDecoration(
                                                                                      color: const Color(0xFFfbf0d4),
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(
                                                                                          DateFormat("MMM").format(DateTime.parse(futureEvents[index]?.multislotTime[0].startDate)),
                                                                                          style: GoogleFonts.sourceSansPro(
                                                                                            textStyle: TextStyle(
                                                                                              color: const Color(0xFF96700f),
                                                                                              fontWeight: FontWeight.w600,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Text(
                                                                                          DateFormat("d").format(DateTime.parse(futureEvents[index]?.multislotTime[0].startDate)),
                                                                                          style: GoogleFonts.sourceSansPro(
                                                                                            textStyle: TextStyle(
                                                                                              color: const Color(0xFF333333),
                                                                                              fontWeight: FontWeight.w700,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    )),
                                                                                Row(
                                                                                  children: [
                                                                                    Text(
                                                                                      ' - ',
                                                                                      style: GoogleFonts.sourceSansPro(
                                                                                        textStyle: TextStyle(
                                                                                          color: const Color(0xFF96700f),
                                                                                          fontWeight: FontWeight.w600,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                        height: 40,
                                                                                        width: 40,
                                                                                        // padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                                                                        decoration: BoxDecoration(
                                                                                          color: const Color(0xFFfbf0d4),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                        child: Column(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Text(
                                                                                              DateFormat("MMM").format(DateTime.parse(futureEvents[index]?.multislotTime[futureEvents[index].multislotTime.length - 1].endDate)),
                                                                                              style: GoogleFonts.sourceSansPro(
                                                                                                textStyle: TextStyle(
                                                                                                  color: const Color(0xFF96700f),
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Text(
                                                                                              DateFormat("d").format(DateTime.parse(futureEvents[index]?.multislotTime[futureEvents[index].multislotTime.length - 1].endDate)),
                                                                                              style: GoogleFonts.sourceSansPro(
                                                                                                textStyle: TextStyle(
                                                                                                  color: const Color(0xFF333333),
                                                                                                  fontWeight: FontWeight.w700,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ))
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                      Container(
                                                                        //width: 210,
                                                                        padding:
                                                                            EdgeInsets.all(5),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              futureEvents[index].name,
                                                                              overflow: TextOverflow.ellipsis, //celebrations...",
                                                                              style: GoogleFonts.sourceSansPro(
                                                                                textStyle: TextStyle(
                                                                                  color: const Color(0xFF96700f),
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 16,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
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
                            // Text(
                            //   "BANNERS",
                            //   style: GoogleFonts.sourceSansPro(
                            //     textStyle: TextStyle(
                            //       color: const Color(0xFFfbf0d4),
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 16,
                            //       letterSpacing: 1,
                            //     ),
                            //   ),
                            // ),
                            // Column(
                            //   children: [
                            //     GestureDetector(
                            //       onTap: () {
                            //         Navigator.of(context, rootNavigator: true)
                            //             .push(MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     amenities_screen()));
                            //       },
                            //       child: Padding(
                            //         padding:
                            //             const EdgeInsets.only(top: 10, right: 20),
                            //         child: Container(
                            //           height: MediaQuery.of(context).size.height *
                            //               0.030,
                            //           width: MediaQuery.of(context).size.width *
                            //               0.15,
                            //           decoration: BoxDecoration(
                            //             color: const Color(0xFFffffff),
                            //             borderRadius: BorderRadius.circular(20),
                            //             border: Border.all(
                            //               color: const Color(0xFF96700f),
                            //             ),
                            //           ),
                            //           child: Center(
                            //             child: Text(
                            //               "VIEW ALL",
                            //               style: GoogleFonts.sourceSansPro(
                            //                 textStyle: TextStyle(
                            //                     color: const Color(0xFFc0a155),
                            //                     fontWeight: FontWeight.w400,
                            //                     fontSize: 10),
                            //               ),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
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
                      child: FutureBuilder(
                          future: _loadbanners,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("");
                            } else {
                              bannerResponseModel = snapshot.data;
                              bannersList = bannerResponseModel.data;
                              return Container(
                                  // color: Colors.amber,
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Carousel(
                                    boxFit: BoxFit.fitWidth,
                                    autoplay: true,
                                    animationCurve: Curves.fastOutSlowIn,
                                    // animationDuration:
                                    //     Duration(milliseconds: 1000),
                                    animationDuration:
                                        Duration(milliseconds: 2000),
                                    dotSize: 3.0,
                                    // dotIncreaseSize: 4.0,
                                    dotBgColor: Colors.transparent,
                                    dotColor: Colors.white,
                                    dotPosition: DotPosition.bottomCenter,
                                    dotSpacing: 10,
                                    showIndicator: true,
                                    indicatorBgPadding: 9.0,
                                    images: imageList(),
                                    onImageTap: (val) {
                                      clickCountApi(bannersList[val].id);
                                      _launchURL(bannersList[val].url);
                                    },
                                  ));
                            }
                          }),
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
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 20),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                      amenitiesList =
                                          amenitiesResponseModel.data;
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
                                                            Navigator.of(
                                                                    context,
                                                                    rootNavigator:
                                                                        true)
                                                                .push(MaterialPageRoute(
                                                                    builder: (context) => amenities_details(amenitiesList[index]
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
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.05,
                                                                    width: MediaQuery.of(context)
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
                                                                            amenitiesList[index].icon),
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
                                                                              textStyle: TextStyle(
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
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 20),
                                    child: Container(
                                      // margin: EdgeInsets.fromLTRB(
                                      //   MediaQuery.of(context).size.height * 0.37,
                                      //   MediaQuery.of(context).size.height * 0.825,
                                      //   MediaQuery.of(context).size.height * 0.02,
                                      //   MediaQuery.of(context).size.height * 0.00,
                                      // ),
                                      height:
                                          MediaQuery.of(context).size.height *
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
                                                  itemCount:
                                                      servicesList.length,
                                                  itemBuilder:
                                                      (context, index) {
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
                                                                        servicesList[index]
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
                                                                        "${servicesList[index].name}",
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
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
                                  // color: Color(0xFF203040),
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
                                  height: MediaQuery.of(context).size.height *
                                      0.030,
                                  width:
                                      MediaQuery.of(context).size.width * 0.15,
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
                                            // color: const Color(0xFFc0a155),
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
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
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
                                                    activitiesList.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () => {
                                                      Navigator.of(context,
                                                              rootNavigator:
                                                                  true)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ActivitiesDetails(
                                                            activitiesList[
                                                                    index]
                                                                .showtags,
                                                            activitiesList[
                                                                    index]
                                                                .name,
                                                            activitiesList[
                                                                    index]
                                                                .description,
                                                            activitiesList[
                                                                    index]
                                                                .image,
                                                            activitiesList[
                                                                    index]
                                                                .location,
                                                            activitiesList[
                                                                    index]
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
                                                                      activitiesList[
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

  List<Widget> imageList() {
    var list = bannersList.map(
      (data) {
        var widgetList = <Widget>[];
        widgetList.add(Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: NetworkImage(data.image),
              fit: BoxFit.cover,
            ),
          ),
        ));

        return widgetList;
      },
    );
    return list.expand((i) => i).toList();
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
