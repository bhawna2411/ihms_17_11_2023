import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/AmenitiesHistoryResponse.dart';
import 'package:ihms/models/EventHistoryResponseModel.dart';
import 'package:ihms/models/ServiceHistoryResponseModel.dart';
import 'package:ihms/screens/tabbar.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class EventHistoryScreen extends StatefulWidget {
  @override
  _EventHistoryScreenState createState() => _EventHistoryScreenState();
}

class _EventHistoryScreenState extends State<EventHistoryScreen>
    with SingleTickerProviderStateMixin {
  ScrollController controller = ScrollController();
  TextEditingController _startdateController = TextEditingController();
  TextEditingController _enddateController = TextEditingController();
  EventHistoryResponseModel eventHistoryResponseModel;
  List<EventHistory> eventHistoryList;
  ServiceHistoryResponseModel serviceHistoryResponseModel;
  List<ServiceHistory> serviceHistoryList;
  AmenitiesHistoryResponse amenitiesHistoryResponse;
  List<AmenitiesHistory> amenitiesHistoryList;
  List<EventHistory> filteredList = [];
  Future _loadevents;
  Future _loadservice;
  Future _loadamenities;
  TabController _tabController;

  loadevents() {
    setState(() {
      _loadevents = getEventHistory();
      _loadservice = getServiceHistory();
      _loadamenities = getAmenitiesHistory();
    });
  }

  @override
  void initState() {
    _startdateController.text = "";
    _enddateController.text = "";
    _tabController = TabController(length: 3, vsync: this);
    loadevents();
    super.initState();
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
          "0$temp:${m.toString().length == 1 ? "0" + m.toString() : m.toString()} " +
              "pm";
    } else {
      send =
          "$h:${m.toString().length == 1 ? "0" + m.toString() : m.toString()}  " +
              "am";
    }

    return send;
  }

  getDateFormat(String date) {
    String result2 = Jiffy(date).format('do MMMM');
    return result2;
  }

  multislot_getDateFormat(String date) {
    String result2 = Jiffy(date).format('do MMMM');
    return result2;
  }

  multislottime_getDateFormat(String date) {
    String result2 = Jiffy(date).format('h:mm a');
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
                    "MY BOOKINGS",
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
              MediaQuery.of(context).size.height * 0.05,
            ),
            child: Column(
              children: [
                TabBar(
                  indicatorColor: const Color(0xFF96700f),
                  tabs: const [
                    Tab(
                        child: Text(
                      "Event",
                      style: TextStyle(
                          color: const Color(0xFF96700f),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                    Tab(
                        child: Text(
                      "Concierge",
                      style: TextStyle(
                          color: const Color(0xFF96700f),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                    Tab(
                        child: Text(
                      "Amenities",
                      style: TextStyle(
                          color: const Color(0xFF96700f),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ))
                  ],
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
                Expanded(
                    child: TabBarView(controller: _tabController, children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.78,
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
                            if (snapshot.data == null) {
                              eventHistoryList = [];
                              filteredList = [];
                            } else {
                              eventHistoryResponseModel = snapshot.data;
                              eventHistoryList = eventHistoryResponseModel.data;
                              filteredList = [];
                            }

                            if (_startdateController.text == "" &&
                                _enddateController.text == "") {
                              filteredList.addAll(eventHistoryList);
                            } else {
                              for (var i = 0;
                                  i < eventHistoryList.length;
                                  i++) {
                                if (eventHistoryList[i].multislot == 1) {
                                  for (var j = 0;
                                      j <
                                          eventHistoryList[i]
                                              .multislotTime
                                              .length;
                                      j++) {
                                    if (eventHistoryList[i]
                                            .multislotTime[j]
                                            .startDate !=
                                        null) {
                                      if (DateFormat('yyyy-MM-dd').format(
                                                  eventHistoryList[i]
                                                      .multislotTime[j]
                                                      .startDate) ==
                                              _startdateController.text
                                          ) {
                                        filteredList.add(eventHistoryList[i]);
                                      }
                                    }
                                  }
                                } else {
                                  if (eventHistoryList[i].startDate != null) {
                                    if (DateFormat('yyyy-MM-dd').format(
                                                eventHistoryList[i]
                                                    .startDate) ==
                                            _startdateController.text
                                        ) {
                                      filteredList.add(eventHistoryList[i]);
                                    }
                                  }
                                }
                              }
                            }
                            return eventHistoryList.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "No History Available",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    controller: controller,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: eventHistoryList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(7),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: eventHistoryList[
                                                                        index]
                                                                    .type ==
                                                                "non-paid"
                                                            ? Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                      capitalizeAllWord(
                                                                          eventHistoryList[index]
                                                                              .name),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      style:
                                                                          TextStyle(
                                                                        color: const Color(
                                                                            0xFF96700f),
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 20,
                                                                    width: 60,
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
                                                                              Radius.circular(10.0) //                 <--- border radius here
                                                                              ),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "FREE",
                                                                        style: GoogleFonts
                                                                            .sourceSansPro(
                                                                          textStyle:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                      capitalizeAllWord(
                                                                          eventHistoryList[index]
                                                                              .name),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .clip,
                                                                      style:
                                                                          TextStyle(
                                                                        color: const Color(
                                                                            0xFF96700f),
                                                                        fontSize:
                                                                            15,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: 20,
                                                                    width: 60,
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
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            10.0),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "PAID",
                                                                        style: GoogleFonts
                                                                            .sourceSansPro(
                                                                          textStyle:
                                                                              TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                13,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                      ),
                                                      SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              'Date of Booking - ',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              getDateFormat(
                                                                  eventHistoryList[
                                                                          index]
                                                                      .eventJoinDate
                                                                      .toString()),
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 5),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              'Booking Id - ',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              eventHistoryList[
                                                                      index]
                                                                  .booking_id
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 2),
                                                      eventHistoryList[index]
                                                                  .multislot ==
                                                              1
                                                          ? Row(
                                                              children: [
                                                                Container(
                                                                  child: Text(
                                                                    'Slot booked - ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color(
                                                                          0xFF5b6368),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    multislot_getDateFormat(eventHistoryList[
                                                                            index]
                                                                        .event_start_date
                                                                        .toString()),
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color(
                                                                          0xFF5b6368),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    '  ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color(
                                                                          0xFF5b6368),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    multislottime_getDateFormat(eventHistoryList[
                                                                            index]
                                                                        .event_start_date
                                                                        .toString()),
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color(
                                                                          0xFF5b6368),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    '-',
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color(
                                                                          0xFF5b6368),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    multislottime_getDateFormat(eventHistoryList[
                                                                            index]
                                                                        .event_end_date
                                                                        .toString()),
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color(
                                                                          0xFF5b6368),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container(),
                                                      SizedBox(height: 2),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            child: Text(
                                                              'Total Number of Tickets - ',
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              eventHistoryList[
                                                                      index]
                                                                  .ticket
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 2),
                                                      eventHistoryList[index]
                                                                  .type ==
                                                              "paid"
                                                          ? Row(
                                                              children: [
                                                                Container(
                                                                  child: Text(
                                                                    'Total Amount paid - ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color(
                                                                          0xFF5b6368),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Text(
                                                                    "${eventHistoryList[index].amount.toString()} Rs",
                                                                    style:
                                                                        TextStyle(
                                                                      color: const Color(
                                                                          0xFF5b6368),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          : Container(),
                                                      SizedBox(height: 2),
                                                      eventHistoryList[index]
                                                                  .multislot ==
                                                              0
                                                          ? SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: eventHistoryList[
                                                                              index]
                                                                          .startDate !=
                                                                      eventHistoryList[
                                                                              index]
                                                                          .endDate
                                                                  ? Row(
                                                                      children: [
                                                                        Container(
                                                                          child: Text(
                                                                              "Event Date - ",
                                                                              style: TextStyle(color: const Color(0xFF5b6368), fontSize: 12, fontWeight: FontWeight.w600)),
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            getDateFormat(eventHistoryList[index].startDate.toString()),
                                                                            style:
                                                                                TextStyle(
                                                                              color: const Color(0xFF5b6368),
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            '-',
                                                                            style:
                                                                                TextStyle(
                                                                              color: const Color(0xFF5b6368),
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            getDateFormat1(eventHistoryList[index].endDate.toString()),
                                                                            style:
                                                                                TextStyle(
                                                                              color: const Color(0xFF5b6368),
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : Row(
                                                                      children: [
                                                                        Container(
                                                                          child: Text(
                                                                              "Event Date - ",
                                                                              style: TextStyle(color: const Color(0xFF5b6368), fontSize: 12, fontWeight: FontWeight.w600)),
                                                                        ),
                                                                        Container(
                                                                          child: Text(
                                                                              getDateFormat(eventHistoryList[index].startDate.toString()),
                                                                              style: TextStyle(color: const Color(0xFF5b6368), fontSize: 12, fontWeight: FontWeight.w600)),
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            ", ",
                                                                            style:
                                                                                TextStyle(
                                                                              color: const Color(0xFF5b6368),
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Text(
                                                                            getDateFormat2(eventHistoryList[index].startDate.toString()),
                                                                            style:
                                                                                TextStyle(
                                                                              color: const Color(0xFF5b6368),
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                            )
                                                          : SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                                  Container(),
                                                            ),
                                                      SizedBox(height: 2),
                                                      eventHistoryList[index]
                                                                  .multislot ==
                                                              0
                                                          ? SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    child: Text(
                                                                      "Event Time - ",
                                                                      style: TextStyle(
                                                                          color: const Color(
                                                                              0xFF5b6368),
                                                                          fontSize:
                                                                              12,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      time24to12Format(
                                                                          eventHistoryList[index]
                                                                              .startTime),
                                                                      style:
                                                                          TextStyle(
                                                                        color: const Color(
                                                                            0xFF5b6368),
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      '-',
                                                                      style:
                                                                          TextStyle(
                                                                        color: const Color(
                                                                            0xFF5b6368),
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    child: Text(
                                                                      time24to12Format(
                                                                          eventHistoryList[index]
                                                                              .endTime),
                                                                      style:
                                                                          TextStyle(
                                                                        color: const Color(
                                                                            0xFF5b6368),
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              width: double
                                                                  .infinity,
                                                              child:
                                                                  Container(),
                                                            ),
                                                      SizedBox(height: 2),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            // "Description: ${capitalize(filteredList[index].description)}"
                                                            "Location: ${capitalize(eventHistoryList[index].location)}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                            //  TextStyle(
                                                            //   color: const Color(
                                                            //       0xFF5b6368),
                                                            //   fontSize: 11,
                                                            // ),
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

                  Container(
                    height: MediaQuery.of(context).size.height * 0.78,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder(
                        future: _loadservice,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            if (snapshot.data == null) {
                              serviceHistoryList = [];
                            } else {
                              serviceHistoryResponseModel = snapshot.data;
                              serviceHistoryList =
                                  serviceHistoryResponseModel.data;
                            }
                            return serviceHistoryList.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "No History Available",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: serviceHistoryList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(7),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "${capitalize(serviceHistoryList[index].conciergeservicesName)}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xFF96700f),
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "Booking Id: ${capitalize(serviceHistoryList[index].bookingId.toString())}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "Booking Date: ${serviceHistoryList[index].bookingDate}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
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

                  Container(
                    height: MediaQuery.of(context).size.height * 0.78,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder(
                        future: _loadamenities,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            if (snapshot.data == null) {
                              amenitiesHistoryList = [];
                            } else {
                              amenitiesHistoryResponse = snapshot.data;
                              amenitiesHistoryList =
                                  amenitiesHistoryResponse.data;
                            }
                            return amenitiesHistoryList.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "No History Available",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: amenitiesHistoryList.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(7),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(top: 5),
                                                              child: Text(
                                                                "${capitalize(amenitiesHistoryList[index].amenitiesName)}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: const Color(
                                                                        0xFFb48919),
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            amenitiesHistoryList[
                                                                            index]
                                                                        .payType ==
                                                                    "paid"
                                                                ? Container(
                                                                    height: 20,
                                                                    width: 60,
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
                                                                              Radius.circular(10.0) //                 <--- border radius here
                                                                              ),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          "PAID",
                                                                          style:
                                                                              GoogleFonts.sourceSansPro(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white))),
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    height: 20,
                                                                    width: 60,
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
                                                                              Radius.circular(10.0) //                 <--- border radius here
                                                                              ),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          "FREE",
                                                                          style:
                                                                              GoogleFonts.sourceSansPro(textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white))),
                                                                    ),
                                                                  ),
                                                          ]),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "Booking Id: ${amenitiesHistoryList[index].bookingId}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "Slot Start Date: ${amenitiesHistoryList[index].slotStartTime}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "Slot End Date: ${amenitiesHistoryList[index].slotEndTime}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "Booking Date: ${amenitiesHistoryList[index].bookingDate}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            "Location: ${capitalize(amenitiesHistoryList[index].locaton)}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                color: const Color(
                                                                    0xFF5b6368),
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
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
                ]))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
