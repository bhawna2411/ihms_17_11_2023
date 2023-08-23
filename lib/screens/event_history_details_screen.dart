import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/models/EventHistoryResponseModel.dart';
import 'package:ihms/screens/participate_screen.dart';
import 'package:jiffy/jiffy.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:intl/intl.dart';

final themeMode = ValueNotifier(2);

getDateFormat(String date) {
  // if (date != null) {
  // String dataa = DateTime.parse(date);
  print("date--------$date");
  String result2 = Jiffy(DateTime.parse(date)).format('EEE , do MMM yyyy');
  print("----------result2-----------${result2}");
  return result2;
  // }
}

class EventHistoryDetailsScreen extends StatefulWidget {
  @override
  EventHistory eventData;
  List<String> tags;
  EventHistoryDetailsScreen(this.eventData);
  _EventHistoryDetailsScreenState createState() =>
      _EventHistoryDetailsScreenState();
}

final _contactEditingController = TextEditingController();

class _EventHistoryDetailsScreenState extends State<EventHistoryDetailsScreen> {
  FocusNode myFocusNode = new FocusNode();
  ScrollController controller = ScrollController();
  var _currentDate = DateTime.now();
  var _currentDate1 = DateTime.now();
  List<int> persons = [];
  var shouldAbsorb;
  var _finalDate;
  _launchURL(url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    getFinalDate() {
      if (widget.eventData.multislot == 0) {
        _finalDate = widget.eventData.startDate.toString() +
            ' ' +
            widget.eventData.startTime;
        return _finalDate;
      } else {
        // for (var each in widget.eventData.multislotTime.stratTime) {
        //   persons.add(DateTime.parse(each).millisecondsSinceEpoch);
        // }
        var _fDate = persons.reduce((curr, next) => curr > next ? curr : next);
        var dt = DateTime.fromMillisecondsSinceEpoch(_fDate);
        _finalDate = DateFormat('yyyy-MM-dd hh:mm').format(dt);
        return _finalDate;
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: widget.eventData.image == null
                    ? Text("data")
                    : CarouselWithIndicatorDemo(widget.eventData.image),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.29,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: ExactAssetImage("assets/images/bg_color.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03,
              ),
              child: InkWell(
                child: new IconButton(
                    icon: new Icon(
                      Icons.arrow_back,
                      size: 20,
                    ),
                    color: Colors.white,
                    onPressed: () => {Navigator.pop(context)}),
              ),
            ),
            Center(
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.loose,
                clipBehavior: Clip.hardEdge,
                children: [
                  FittedBox(
                    child: Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.height * 0.02),
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.20,
                        bottom: MediaQuery.of(context).size.height * 0.10,
                      ),
                      width: MediaQuery.of(context).size.width * 0.92,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                              bottom: MediaQuery.of(context).size.height * 0.02,
                            ),
                            child: Row(
                              children: [
                                Text(widget.eventData.name,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFba8e1c))),
                              ],
                            ),
                          ),
                          // widget.eventData.multislot == 0
                          //     ? 
                              Container(
                                  margin: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.03,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFf7f2ce),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: new IconButton(
                                            icon: new Icon(
                                              Icons.calendar_today,
                                              size: 15,
                                              color: Color(0xFF90700b),
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.28,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("EVENT START",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11,
                                                    color: Color(0xFFba8e1c),),),
                                            Container(
                                              width: 100,
                                              child: Text(
                                                 getDateFormat(widget
                                                      .eventData.startDate
                                                      .toString()),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 9,
                                                      color:
                                                          Color(0xFFcbb269),),),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.10,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFf7f2ce),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  5.0) ,
                                              ),
                                        ),
                                        child: Center(
                                          child: new IconButton(
                                            icon: new Icon(
                                              Icons.calendar_today,
                                              size: 15,
                                              color: Color(0xFF90700b),
                                            ),
                                            color: Colors.white,
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("EVENT END",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11,
                                                    color: Color(0xFFba8e1c),),),
                                            
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Flexible(
                                              child: Container(
                                                child: Text(
                                                  getDateFormat(widget
                                                      .eventData.endDate
                                                      .toString()),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 9,
                                                      color: Color(0xFFcbb269),),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                         Container(
                            decoration: BoxDecoration(),
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("About Event",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFba8e1c),),),
                                    ],
                                  ),
                                  Text(widget.eventData.description,
                                      style: TextStyle(
                                          height: 1.5,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFcbb269),),),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(),
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Number of Seats Available",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFba8e1c),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    widget.eventData.numberOfSeatsAvailable,
                                    style: TextStyle(
                                      height: 1.5,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFFcbb269),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(),
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text("Tags",
                                      //     textAlign: TextAlign.start,
                                      //     style: TextStyle(
                                      //         fontSize: 17,
                                      //         fontWeight: FontWeight.w600,
                                      //         color: Color(0xFFba8e1c))),
                                    ],
                                  ),
                                  Wrap(
                                    spacing: 5.0,
                                    children: widget.eventData.tags.length < 1
                                        ? Container()
                                        : List.generate(
                                            widget.eventData.tags.length,
                                            (index) {
                                              return FittedBox(
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Color(0xFFe2dcca),
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(20.0),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 5,
                                                          bottom: 5),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            widget.eventData
                                                                .tags[index]
                                                                .toLowerCase(),
                                                            style: GoogleFonts.sourceSansPro(
                                                                textStyle: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        10,
                                                                    color: Color(
                                                                        0xFF455a64))),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              widget.eventData.type == "non-paid"
                                  ? Container()
                                  : Container(
                                      // color: Colors.amber,
                                      // height: 100,

                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Amount",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFba8e1c))),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Wrap(
                                          //   spacing: 5,
                                          //   direction: Axis.vertical,
                                          //   children: List.generate(
                                          //       widget
                                          //           .eventData
                                          //           .participants
                                          //           .participantName
                                          //           .length, (index) {
                                          //     return Text(
                                          //       '${widget.eventData.participants.participantName[index]} : \u{20B9} ${widget.eventData.participants.amount[index]} per seat',
                                          //       style: TextStyle(
                                          //         fontSize: 10,
                                          //         fontWeight: FontWeight.w600,
                                          //         color: Color(0xFFcbb269),
                                          //       ),
                                          //     );
                                          //   }),
                                          // ),
                                        ],
                                      ),
                                    )
                            ],
                          ),
                          SizedBox(
                              height: widget.eventData.amountAdult == null
                                  ? 5
                                  : 20),
                          Container(
                            margin: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.005,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 0,
                                  height: 20,
                                  child: Icon(
                                    Icons.location_on_sharp,
                                    size: 17,
                                    color: Color(0xFF90700b),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Location",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFba8e1c))),
                                SizedBox(
                                  width: 120,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    onPressed:
                                    _launchURL(widget.eventData.url);
                                  },
                                  child: widget.eventData.url != null
                                      ? Text(
                                          "Event gallery",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xFFba8e1c)),
                                        )
                                      : Container(),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.topStart,
                            child: widget.eventData.location == null
                                ? Container()
                                : Text(widget.eventData.location,
                                    style: TextStyle(
                                        height: 1.5,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFcbb269))),
                          ),
                          SizedBox(
                            height: 50,
                          )
                        ],
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
