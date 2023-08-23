// import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/AvailableSeatsResponseModel.dart';
import 'package:ihms/models/EventsResponseModel.dart';
import 'package:ihms/screens/dashboard_screen.dart';
import 'package:ihms/screens/participate_screen.dart';
import 'package:ihms/screens/tabbar.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class EventScreen extends StatefulWidget {
  bool bottomTabbar;
  EventScreen(this.bottomTabbar);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  var _currentDate = DateTime.now();

  EventsResponseModel eventsResponseModel;
  AvailableSeatsResponseModel availableSeatsResponseModel;
  List<EventData> eventList;
  Future _loadevents;
  Future _loadammenities;
  Future _loadservices;
  Future _loadActivities;

  // getseat() {
  //   availableSeat(widget.eventData.id, context).then((value) {
  //     setState(() {
  //       availableSeatsResponseModel = value;
  //     });

  //     print(availableSeatsResponseModel.data[0].numberOfSeatsAvailable);
  //   });
  // }

  loadevents() {
    setState(() {
      _loadevents = getEvents();
      //   _loadammenities = getAmenities();
      //   _loadservices = getServices();
      //   _loadActivities = getActivities();
    });
  }

  String capitalizeAllWord(String value) {
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  String capitalize(String value) {
    var result = value[0].toUpperCase();
    bool cap = true;
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " " && cap == true) {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
        cap = false;
      }
    }
    return result;
  }

  String time24to12Format(String time) {
    int h = int.parse(time.split(":").first);
    int m = int.parse(time.split(":").last.split(" ").first);
    String send = "";
    if (h > 12) {
      var temp = h - 12;
      send =
          "${temp.toString().length > 1 ? temp : '0$temp'}:${m.toString().length == 1 ? "0" + m.toString() : m.toString()} " +
              "pm";
    } else {
      send =
          "${h.toString().length > 1 ? h : '0$h'}:${m.toString().length == 1 ? "0" + m.toString() : m.toString()}  " +
              "am";
    }

    return send;
  }

  @override
  void initState() {
    // TODO: implement initState
    loadevents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
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
              MediaQuery.of(context).size.height * 0.065,
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
          Padding(
            padding: const EdgeInsets.only(top: 101, bottom: 40),
            child: FutureBuilder(
                future: _loadevents,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    eventsResponseModel = snapshot.data;
                    eventList = eventsResponseModel.data;

                    return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: eventList.length,
                        itemBuilder: (context, index) {
                          // availableSeat(eventList[index].id, context)
                          //     .then((value) {
                          //   print('fgg${value.data[0].numberOfSeatsAvailable}');
                          //   avlSeat = value.data[0].numberOfSeatsAvailable;
                          // });
                          // print('avlSeat$avlSeat');

                          var amount1;
                          var amount2;
                          var amount = 0;
                          if (eventList[index].amount_adult == null) {
                            amount1 = 0;
                          } else {
                            amount1 = eventList[index].amount_adult;
                          }

                          if (eventList[index].amount_child == null) {
                            amount2 = 0;
                          } else {
                            amount2 = eventList[index].amount_child;
                          }
                          amount = int.parse(amount1) + int.parse(amount2);
                          return FutureBuilder(
                              //  future:
                              //    availableSeat(eventList[index].id, context),
                              builder: (context, snap) {
                            if (true) {
                              //var avlSeat =
                              //  snap.data.data[0].numberOfSeatsAvailable;
                              var avlSeat =
                                  eventList[index].number_of_seats_available;
                              print('avl SEat$avlSeat');
                              print(
                                  " eventType.............. ${eventList[index].type}");
                              return GestureDetector(
                                  onTap: () => {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Participate_Screen(
                                                        eventList[index])))
                                      },
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 10,
                                          bottom: 10),
                                      child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Container(
                                              // height: 110,
                                              // height: 140,
                                              height: 110,
                                              child: (Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // height: 80,
                                                    // width: 80,
                                                    height: 110,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    decoration: BoxDecoration(
                                                      // borderRadius:
                                                      //     BorderRadius
                                                      //         .circular(5),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(7),
                                                              bottomLeft: Radius
                                                                  .circular(7)),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: eventList[index]
                                                                    .image ==
                                                                ''
                                                            ? NetworkImage(
                                                                'https://th.bing.com/th/id/OIP._ZIjfYAE0_HpYth1f-mq2QHaE7?pid=ImgDet&rs=1',
                                                              )
                                                            : NetworkImage(
                                                                eventList[index]
                                                                    .image,
                                                              ),
                                                      ),
                                                    ),
                                                    // image: DecorationImage(
                                                    //   image:

                                                    //   NetworkImage(
                                                    //       eventList[index]
                                                    //           .image),
                                                    //   fit: BoxFit.cover,
                                                    // ),
                                                  ),
                                                  // Dash(
                                                  //     direction:
                                                  //         Axis.vertical,
                                                  //     length: 77,
                                                  //     dashLength: 1,
                                                  //     dashGap: 2,
                                                  //     dashColor:
                                                  //         const Color(
                                                  //             0xFF999999)),
                                                  Expanded(
                                                      child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  top: 10),
                                                          child: Container(
                                                              child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              // Row(
                                                              //   mainAxisAlignment:
                                                              //       MainAxisAlignment
                                                              //           .spaceBetween,
                                                              //   children: [
                                                              //     Text(
                                                              //         getDateFormat(eventList[index]
                                                              //             .date)

                                                              //         // eventList[index]
                                                              //         //     .date
                                                              //         ,
                                                              //         style: TextStyle(
                                                              //             color: const Color(0xFF333333),
                                                              //             fontSize: 13,
                                                              //             fontWeight: FontWeight.w600)),

                                                              //     eventList[index].type ==
                                                              //             "non-paid"
                                                              //         ? Container()
                                                              //         : Row(
                                                              //             children: [
                                                              //               Text(
                                                              //                 "Paid",
                                                              //                 style: TextStyle(color: Colors.green),
                                                              //               ),
                                                              //               SizedBox(width: 5),
                                                              //               Text(avlSeat == 0 ? '' : avlSeat)
                                                              //             ],
                                                              //           ),
                                                              //     // _currentDate.isAfter(
                                                              //     //         DateTime.parse(
                                                              //     //             eventList[index].date))
                                                              //     //     ? Text("")
                                                              //     //     : Container(
                                                              //     //         padding:
                                                              //     //             EdgeInsets.only(top: 1),
                                                              //     //         height:
                                                              //     //             15,
                                                              //     //         width:
                                                              //     //             70,
                                                              //     //         decoration:
                                                              //     //             BoxDecoration(
                                                              //     //           border:
                                                              //     //               Border.all(
                                                              //     //             color: Colors.amber,
                                                              //     //           ),
                                                              //     //           borderRadius:
                                                              //     //               BorderRadius.circular(10),
                                                              //     //         ),
                                                              //     //         child: Center(
                                                              //     //             child: Text(
                                                              //     //           "GET TICKET",
                                                              //     //           style:
                                                              //     //               TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                                                              //     //         )),
                                                              //     //       )
                                                              //   ],
                                                              // ),
                                                              SizedBox(
                                                                  width: double
                                                                      .infinity,
                                                                  child: eventList[index]
                                                                              .type ==
                                                                          "non-paid"
                                                                      ? Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(right: 8.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Container(
                                                                                padding: EdgeInsets.only(top: 5
                                                                                    // top: 3
                                                                                    ),
                                                                                child: Text(
                                                                                  capitalizeAllWord(eventList[index].name),
                                                                                  textAlign: TextAlign.left,
                                                                                  overflow: TextOverflow.clip,
                                                                                  style: TextStyle(color: const Color(0xFF96700f), fontSize: 14, fontWeight: FontWeight.w600),
                                                                                ),
                                                                              ),
                                                                              // SizedBox(width: 70,),
                                                                              Container(
                                                                                height: 20,
                                                                                width: 60,
                                                                                decoration: BoxDecoration(
                                                                                  gradient: LinearGradient(
                                                                                    begin: Alignment.centerLeft,
                                                                                    end: Alignment.centerRight,
                                                                                    colors: [
                                                                                      const Color(0xFFb48919),
                                                                                      const Color(0xFF9a7210),
                                                                                    ],
                                                                                  ),
                                                                                  // border: Border.all(
                                                                                  //     color: const Color(
                                                                                  //         0xFF9a7210),
                                                                                  //     width:
                                                                                  //         4),
                                                                                  borderRadius: BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                                                                                      ),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text("FREE",
                                                                                      style: GoogleFonts.sourceSansPro(
                                                                                          textStyle: TextStyle(
                                                                                              fontWeight: FontWeight.bold,
                                                                                              // letterSpacing: 3,
                                                                                              fontSize: 13,
                                                                                              color: Colors.white))),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )
                                                                      : Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(right: 8.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Container(
                                                                                padding: EdgeInsets.only(top: 5
                                                                                    // top: 3
                                                                                    ),
                                                                                child: Text(
                                                                                  eventList[index].name,
                                                                                  textAlign: TextAlign.left,
                                                                                  overflow: TextOverflow.clip,
                                                                                  style: TextStyle(color: const Color(0xFF96700f), fontSize: 14, fontWeight: FontWeight.w600),
                                                                                ),
                                                                              ),
                                                                              // SizedBox(width: 70,),
                                                                              Container(
                                                                                height: 20,
                                                                                width: 60,
                                                                                decoration: BoxDecoration(
                                                                                  gradient: LinearGradient(
                                                                                    begin: Alignment.centerLeft,
                                                                                    end: Alignment.centerRight,
                                                                                    colors: [
                                                                                      const Color(0xFFb48919),
                                                                                      const Color(0xFF9a7210),
                                                                                    ],
                                                                                  ),
                                                                                  // border: Border.all(
                                                                                  //     color: const Color(
                                                                                  //         0xFF9a7210),
                                                                                  //     width:
                                                                                  //         4),
                                                                                  borderRadius: BorderRadius.all(Radius.circular(10.0) //                 <--- border radius here
                                                                                      ),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    "PAID",
                                                                                    style: GoogleFonts.sourceSansPro(
                                                                                      textStyle: TextStyle(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          // letterSpacing: 3,
                                                                                          fontSize: 13,
                                                                                          color: Colors.white),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )),
                                                              eventList[index]
                                                                          .multislot ==
                                                                      0
                                                                  ? SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child: eventList[index].start_date !=
                                                                              eventList[index].end_date
                                                                          ? Row(
                                                                              children: [
                                                                                Container(
                                                                                  padding: EdgeInsets.only(top: 5
                                                                                      // top: 3
                                                                                      ),
                                                                                  child: Text(
                                                                                      getDateFormat(eventList[index].start_date)

                                                                                      // eventList[index]
                                                                                      //     .date
                                                                                      ,
                                                                                      style: TextStyle(color: const Color(0xFF5b6368), fontSize: 12, fontWeight: FontWeight.w600)),
                                                                                ),
                                                                                Container(
                                                                                  padding: EdgeInsets.only(top: 5
                                                                                      // top: 3
                                                                                      ),
                                                                                  child: Text(
                                                                                      '-'

                                                                                      // eventList[index]
                                                                                      //     .date
                                                                                      ,
                                                                                      style: TextStyle(color: const Color(0xFF5b6368), fontSize: 13, fontWeight: FontWeight.w600)),
                                                                                ),
                                                                                Container(
                                                                                  padding: EdgeInsets.only(top: 5
                                                                                      // top: 3
                                                                                      ),
                                                                                  child: Text(
                                                                                      getDateFormat1(eventList[index].end_date)

                                                                                      // eventList[index]
                                                                                      //     .date
                                                                                      ,
                                                                                      style: TextStyle(color: const Color(0xFF5b6368), fontSize: 12, fontWeight: FontWeight.w600)),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          : Row(
                                                                              children: [
                                                                                Container(
                                                                                  padding: EdgeInsets.only(top: 5
                                                                                      // top: 3
                                                                                      ),
                                                                                  child: Text(
                                                                                      getDateFormat(eventList[index].start_date)

                                                                                      // eventList[index]
                                                                                      //     .date
                                                                                      ,
                                                                                      style: TextStyle(color: const Color(0xFF5b6368), fontSize: 12, fontWeight: FontWeight.w600)),
                                                                                ),
                                                                                // SizedBox(width: 10),
                                                                                Container(
                                                                                  padding: EdgeInsets.only(top: 5
                                                                                      // top: 3
                                                                                      ),
                                                                                  child: Text(
                                                                                      ", "

                                                                                      // eventList[index]
                                                                                      //     .date
                                                                                      ,
                                                                                      style: TextStyle(color: const Color(0xFF5b6368), fontSize: 12, fontWeight: FontWeight.w600)),
                                                                                ),
                                                                                Container(
                                                                                  padding: EdgeInsets.only(top: 5
                                                                                      // top: 3
                                                                                      ),
                                                                                  child: Text(
                                                                                      getDateFormat2(eventList[index].start_date)

                                                                                      // eventList[index]
                                                                                      //     .date
                                                                                      ,
                                                                                      style: TextStyle(color: const Color(0xFF5b6368), fontSize: 12, fontWeight: FontWeight.w600)),
                                                                                ),
                                                                                // Container(
                                                                                //   padding: EdgeInsets.only(top: 5
                                                                                //       // top: 3
                                                                                //       ),
                                                                                //   child: Text(
                                                                                //       eventList[index].end_time

                                                                                //       // eventList[index]
                                                                                //       //     .date
                                                                                //       ,
                                                                                //       style: TextStyle(color: const Color(0xFF333333), fontSize: 12, fontWeight: FontWeight.w600)),
                                                                                // ),
                                                                              ],
                                                                            ))
                                                                  : SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Container(),
                                                                    ),
                                                              eventList[index]
                                                                          .multislot ==
                                                                      0
                                                                  ? SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                            // padding: EdgeInsets.only(top: 5
                                                                            //     // top: 3
                                                                            //     ),
                                                                            child: Text(
                                                                                time24to12Format(eventList[index].start_time)

                                                                                // eventList[index]
                                                                                //     .date
                                                                                ,
                                                                                style: TextStyle(color: const Color(0xFF5b6368), fontSize: 12, fontWeight: FontWeight.w600)),
                                                                          ),
                                                                          Container(
                                                                            // padding: EdgeInsets.only(top: 5
                                                                            //     // top: 3
                                                                            //     ),
                                                                            child: Text(
                                                                                '-'

                                                                                // eventList[index]
                                                                                //     .date
                                                                                ,
                                                                                style: TextStyle(color: const Color(0xFF5b6368), fontSize: 13, fontWeight: FontWeight.w600)),
                                                                          ),
                                                                          Container(
                                                                            // padding: EdgeInsets.only(top: 5
                                                                            //     // top: 3
                                                                            //     ),
                                                                            child: Text(
                                                                                time24to12Format(eventList[index].end_time)

                                                                                // eventList[index]
                                                                                //     .date
                                                                                ,
                                                                                style: TextStyle(color: const Color(0xFF5b6368), fontSize: 12, fontWeight: FontWeight.w600)),
                                                                          ),
                                                                        ],
                                                                      ))
                                                                  : SizedBox(
                                                                      width: double
                                                                          .infinity,
                                                                      child:
                                                                          Container(),
                                                                    ),
                                                              SizedBox(
                                                                width: double
                                                                    .infinity,
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top: 5
                                                                          // top: 3
                                                                          ),
                                                                  child: Text(
                                                                    "Description: ${capitalize(eventList[index].description)}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    maxLines: 1,
                                                                    softWrap: false,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color(
                                                                          0xFF5b6368),
                                                                      fontSize:
                                                                          11,
                                                                      // fontWeight:
                                                                      //     FontWeight.w600
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: double
                                                                    .infinity,
                                                                child: Container(
                                                                    padding: EdgeInsets.only(top: 2
                                                                        // top: 3
                                                                        ),
                                                                    // child: eventList[index].type ==
                                                                    //         "non-paid"
                                                                    //     ?
                                                                    child: Row(
                                                                      children: [
                                                                        Text(
                                                                          "Available-Seats:-",
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              color: const Color(0xFF96700f)),
                                                                        ),
                                                                        Text(
                                                                          avlSeat == 0
                                                                              ? ''
                                                                              : avlSeat,
                                                                          style: TextStyle(
                                                                              fontSize: 10,
                                                                              color: const Color(0xFF96700f)),
                                                                        ),
                                                                        // SizedBox(width: 15),
                                                                        //                  Container(
                                                                        //   height:30,
                                                                        //   width: 60,
                                                                        //   decoration:
                                                                        //       BoxDecoration(
                                                                        //     gradient:
                                                                        //         LinearGradient(
                                                                        //       begin: Alignment
                                                                        //           .centerLeft,
                                                                        //       end: Alignment
                                                                        //           .centerRight,
                                                                        //       colors: [
                                                                        //         const Color(
                                                                        //             0xFFb48919),
                                                                        //         const Color(
                                                                        //             0xFF9a7210),
                                                                        //       ],
                                                                        //     ),
                                                                        //     // border: Border.all(
                                                                        //     //     color: const Color(
                                                                        //     //         0xFF9a7210),
                                                                        //     //     width:
                                                                        //     //         4),
                                                                        //     borderRadius:
                                                                        //         BorderRadius.all(
                                                                        //             Radius.circular(10.0) //                 <--- border radius here
                                                                        //             ),
                                                                        //   ),
                                                                        //   child: Center(
                                                                        //     child: Text(
                                                                        //         "Non-Paid",
                                                                        //         style: GoogleFonts.sourceSansPro(
                                                                        //             textStyle: TextStyle(
                                                                        //                 fontWeight: FontWeight.bold,
                                                                        //                 // letterSpacing: 3,
                                                                        //                 fontSize: 10,
                                                                        //                 color: Colors.white))),
                                                                        //   ),
                                                                        // ),
                                                                        //  Text(
                                                                        //     "Non-Paid",
                                                                        //     style: TextStyle(color: Colors.green),
                                                                        //   ),
                                                                      ],
                                                                    )
                                                                    //           : Row(
                                                                    //               children: [
                                                                    //                 Text("Available-Seats:-"),
                                                                    //                 Text(avlSeat == 0 ? '' : avlSeat),
                                                                    //                 SizedBox(width: 15),
                                                                    //                 //   Text(
                                                                    //                 //   "Paid",
                                                                    //                 //   style: TextStyle(color: Colors.green),
                                                                    //                 // ),
                                                                    //                  Container(
                                                                    //   height:30,
                                                                    //   width: 60,
                                                                    //   decoration:
                                                                    //       BoxDecoration(
                                                                    //     gradient:
                                                                    //         LinearGradient(
                                                                    //       begin: Alignment
                                                                    //           .centerLeft,
                                                                    //       end: Alignment
                                                                    //           .centerRight,
                                                                    //       colors: [
                                                                    //         const Color(
                                                                    //             0xFFb48919),
                                                                    //         const Color(
                                                                    //             0xFF9a7210),
                                                                    //       ],
                                                                    //     ),
                                                                    //     // border: Border.all(
                                                                    //     //     color: const Color(
                                                                    //     //         0xFF9a7210),
                                                                    //     //     width:
                                                                    //     //         4),
                                                                    //     borderRadius:
                                                                    //         BorderRadius.all(
                                                                    //             Radius.circular(10.0) //                 <--- border radius here
                                                                    //             ),
                                                                    //   ),
                                                                    //   child: Center(
                                                                    //     child: Text(
                                                                    //         "Paid",
                                                                    //         style: GoogleFonts.sourceSansPro(
                                                                    //             textStyle: TextStyle(
                                                                    //                 fontWeight: FontWeight.bold,
                                                                    //                 // letterSpacing: 3,
                                                                    //                 fontSize: 10,
                                                                    //                 color: Colors.white))),
                                                                    //   ),
                                                                    // ),
                                                                    //               ],
                                                                    //             ),
                                                                    ),
                                                              ),
                                                            ],
                                                          ))))
                                                ],
                                              ))))));
                            }
                            return Container();
                          });
                        });
                  }
                }),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.height * 0.15,
              MediaQuery.of(context).size.height * 0.080,
              MediaQuery.of(context).size.height * 0.00,
              MediaQuery.of(context).size.height * 0.00,
            ),
            child: Text(
              "ALL EVENTS",
              style: GoogleFonts.sourceSansPro(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF203040),
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ]));
  }

  getDateFormat(String date) {
    String result2 = Jiffy(date).format('do MMMM');
    return result2;
  }

  getDateFormat2(String date) {
    String result2 = DateFormat("EEEE").format(DateTime.parse(date));
    // String result2 = Jiffy(date).day.toString();
    return result2;
  }

  getDateFormat1(String date1) {
    String result2 = Jiffy(date1).format('do MMMM');
    return result2;
  }
}
