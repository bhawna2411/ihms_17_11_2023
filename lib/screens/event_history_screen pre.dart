import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/EventHistoryResponseModel.dart';
import 'package:ihms/models/EventsResponseModel.dart';
import 'package:ihms/screens/event_history_details_screen.dart';
import 'package:ihms/screens/participate_screen.dart';
import 'package:ihms/screens/tabbar.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class EventHistoryScreen extends StatefulWidget {
  @override
  _EventHistoryScreenState createState() => _EventHistoryScreenState();
}

class _EventHistoryScreenState extends State<EventHistoryScreen> {
  ScrollController controller = ScrollController();
  TextEditingController _startdateController = TextEditingController();
  TextEditingController _enddateController = TextEditingController();
  EventHistoryResponseModel eventHistoryResponseModel;
  List<EventHistory> eventHistoryList;
  List<EventHistory> filteredList = [];
  Future _loadevents;

  loadevents() {
    setState(() {
      _loadevents = getEventHistory();
    });
  }

  @override
  void initState() {
    _startdateController.text =
        ""; // DateFormat('yyyy-MM-dd').format(DateTime.now());
    _enddateController.text = "";
    //DateFormat('yyyy-MM-dd').format(DateTime.now());
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
    String result2 = Jiffy(date).format('h:mm:ss a');
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
                    "MY EVENTS",
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _startdateController,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Start Date",
                                    hintStyle: TextStyle(
                                        color: Color(0xFF203040), fontSize: 13),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  DateTime pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(3000),
                                    initialEntryMode:
                                        DatePickerEntryMode.calendarOnly,
                                  );

                                  if (pickedDate != null) {
                                    setState(() {
                                      _startdateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.calendar_month_outlined,
                                  color: Color(0xFF203040),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _enddateController,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "End Date",
                                    hintStyle: TextStyle(
                                        color: Color(0xFF203040), fontSize: 13),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  DateTime pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(3000),
                                    initialEntryMode:
                                        DatePickerEntryMode.calendarOnly,
                                  );

                                  if (pickedDate != null) {
                                    setState(() {
                                      _enddateController.text =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.calendar_month_outlined,
                                  color: Color(0xFF203040),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
                          print('--------------loading----------------');
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

                          print(
                              "eventHistoryList -----   ${eventHistoryList.length}");

                          if (_startdateController.text == "" &&
                              _enddateController.text == "") {
                            filteredList.addAll(eventHistoryList);
                          } else {
                            for (var i = 0; i < eventHistoryList.length; i++) {
                              // print("i = $i");
                              // print(
                              //     "eventHistoryList[i].eventJoinDate = ${eventHistoryList[i].eventJoinDate}");
                              // print(
                              //     "start date --- ${DateFormat('yyyy-MM-dd').format(eventHistoryList[i].eventJoinDate).compareTo(_startdateController.text) >= 0} ");

                              // print(
                              //     "end date --- ${DateFormat('yyyy-MM-dd').format(eventHistoryList[i].eventJoinDate).compareTo(_enddateController.text) <= 0}");

                              if (eventHistoryList[i].eventJoinDate != null) {
                                // print("i = $i");

                                if (DateFormat('yyyy-MM-dd')
                                            .format(eventHistoryList[i]
                                                .eventJoinDate)
                                            .compareTo(
                                                _startdateController.text) >=
                                        0 &&
                                    DateFormat('yyyy-MM-dd')
                                            .format(eventHistoryList[i]
                                                .eventJoinDate)
                                            .compareTo(
                                                _enddateController.text) <=
                                        0) {
                                  filteredList.add(eventHistoryList[i]);
                                }
                              }
                            }
                          }
                          print("filteredList -----   ${filteredList.length}");

                          return filteredList.isEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                  itemCount: filteredList.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        print("hello");

                                        // Navigator.of(context,
                                        //         rootNavigator: true)
                                        //     .push(
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         EventHistoryDetailScreen(
                                        //             filteredList[index]),
                                        //   ),
                                        // );
                                          // Navigator.of(context,
                                          //                       rootNavigator:
                                          //                           true)
                                          //                   .push(MaterialPageRoute(
                                          //                       builder: (context) =>
                                          //                           Participate_Screen(
                                          //                               filteredList[index])));
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
                                              // Container(
                                              //   height: 110,
                                              //   width: MediaQuery.of(context)
                                              //       .size
                                              //       .width,
                                              //   decoration: BoxDecoration(
                                              //     borderRadius:
                                              //         BorderRadius.only(
                                              //       topLeft: Radius.circular(7),
                                              //       topRight:
                                              //           Radius.circular(7),
                                              //     ),
                                              //     image: DecorationImage(
                                              //       fit: BoxFit.cover,
                                              //       image: filteredList[index]
                                              //                   .image ==
                                              //               ''
                                              //           ? NetworkImage(
                                              //               'https://th.bing.com/th/id/OIP._ZIjfYAE0_HpYth1f-mq2QHaE7?pid=ImgDet&rs=1',
                                              //             )
                                              //           : NetworkImage(
                                              //               filteredList[index]
                                              //                   .image,
                                              //             ),
                                              //     ),
                                              //   ),
                                              // ),
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child:
                                                          filteredList[index]
                                                                      .type ==
                                                                  "non-paid"
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Container(
                                                                      child:
                                                                          Text(
                                                                        capitalizeAllWord(
                                                                            filteredList[index].name),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.clip,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              const Color(0xFF96700f),
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          20,
                                                                      width: 60,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient:
                                                                            LinearGradient(
                                                                          begin:
                                                                              Alignment.centerLeft,
                                                                          end: Alignment
                                                                              .centerRight,
                                                                          colors: [
                                                                            const Color(0xFFb48919),
                                                                            const Color(0xFF9a7210),
                                                                          ],
                                                                        ),
                                                                        borderRadius: BorderRadius.all(
                                                                            Radius.circular(10.0) //                 <--- border radius here
                                                                            ),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "FREE",
                                                                          style:
                                                                              GoogleFonts.sourceSansPro(
                                                                            textStyle:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 13,
                                                                              color: Colors.white,
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
                                                                      child:
                                                                          Text(
                                                                        capitalizeAllWord(
                                                                            filteredList[index].name),
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.clip,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              const Color(0xFF96700f),
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      height:
                                                                          20,
                                                                      width: 60,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient:
                                                                            LinearGradient(
                                                                          begin:
                                                                              Alignment.centerLeft,
                                                                          end: Alignment
                                                                              .centerRight,
                                                                          colors: [
                                                                            const Color(0xFFb48919),
                                                                            const Color(0xFF9a7210),
                                                                          ],
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.all(
                                                                          Radius.circular(
                                                                              10.0),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          "PAID",
                                                                          style:
                                                                              GoogleFonts.sourceSansPro(
                                                                            textStyle:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 13,
                                                                              color: Colors.white,
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
                                                                filteredList[
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
                                                            filteredList[
                                                                        index].booking_id.toString(),
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
                                                    filteredList[index].multislot == 1?
                                                                 Row(
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            'Slot booked - ',
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
                                                            multislot_getDateFormat(
                                                                filteredList[
                                                                        index]
                                                                    .event_start_date
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
                                                         Container(
                                                          child: Text(
                                                            '  ',
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
                                                            multislottime_getDateFormat(
                                                                filteredList[
                                                                        index]
                                                                    .event_start_date
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
                                                          Container(
                                                          child: Text(
                                                            '-',
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
                                                            multislottime_getDateFormat(
                                                                filteredList[
                                                                        index]
                                                                    .event_end_date
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
                                                    ):Container(),
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
                                                            filteredList[index]
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
                                                    Row(
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            'Total Amount paid - ',
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
                                                            "${filteredList[index].amount.toString()} Rs",
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
                                                    filteredList[index]
                                                                .multislot ==
                                                            0
                                                        ? SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child: filteredList[
                                                                            index]
                                                                        .startDate !=
                                                                    filteredList[
                                                                            index]
                                                                        .endDate
                                                                ? Row(
                                                                    children: [
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          getDateFormat(filteredList[index]
                                                                              .startDate
                                                                              .toString()),
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                const Color(0xFF5b6368),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          '-',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                const Color(0xFF5b6368),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          getDateFormat1(filteredList[index]
                                                                              .endDate
                                                                              .toString()),
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                const Color(0xFF5b6368),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Row(
                                                                    children: [
                                                                      Container(
                                                                        child: Text(
                                                                            getDateFormat(filteredList[index]
                                                                                .startDate
                                                                                .toString()),
                                                                            style: TextStyle(
                                                                                color: const Color(0xFF5b6368),
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w600)),
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          ",",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                const Color(0xFF5b6368),
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Text(
                                                                          getDateFormat2(filteredList[index]
                                                                              .startDate
                                                                              .toString()),
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                const Color(0xFF5b6368),
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
                                                            width:
                                                                double.infinity,
                                                            child: Container(),
                                                          ),
                                                    SizedBox(height: 2),
                                                    filteredList[index]
                                                                .multislot ==
                                                            0
                                                        ? SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  child: Text(
                                                                    time24to12Format(
                                                                        filteredList[index]
                                                                            .startTime),
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
                                                                    time24to12Format(
                                                                        filteredList[index]
                                                                            .endTime),
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
                                                            ),
                                                          )
                                                        : SizedBox(
                                                            width:
                                                                double.infinity,
                                                            child: Container(),
                                                          ),
                                                    SizedBox(height: 2),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5),
                                                        child: Text(
                                                          "Description: ${capitalize(filteredList[index].description)}",
                                                          textAlign:
                                                              TextAlign.left,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            color: const Color(
                                                                0xFF5b6368),
                                                            fontSize: 11,
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
    );
  }
}
