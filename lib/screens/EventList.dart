import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/EventsResponseModel.dart';
import 'package:flutter_dash/flutter_dash.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({Key key}) : super(key: key);

  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  EventsResponseModel eventsResponseModel;

  List<EventData> eventList;
  Future _loadevents;
  @override
  void initState() {
    // TODO: implement initState
    loadevents();
    super.initState();
  }

  loadevents() {
    setState(() {
      _loadevents = getEvents();
    });
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
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: FutureBuilder(
                future: _loadevents,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("");
                  } else {
                    eventsResponseModel = snapshot.data;
                    eventList = eventsResponseModel.data;
                    return Row(children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.90,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: eventList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.fromLTRB(25, 11, 25, 0),
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(24),
                                  height:
                                      MediaQuery.of(context).size.height * .15,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.height *
                                                .065,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                eventList[index].image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 22),
                                      Dash(
                                          direction: Axis.vertical,
                                          length: 77,
                                          dashLength: 1,
                                          dashGap: 2,
                                          dashColor: const Color(0xFF999999)),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                eventList[index].date,
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xFF333333),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: 40,
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 1),
                                                height: 15,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.amber,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  "GET TICKET",
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  eventList[index].name,
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xFF96700f),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Text(
                                                  eventList[index].date,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xFFc0a155),
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ]);
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
              "POPULAR EVENTS",
              style: GoogleFonts.sourceCodePro(
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
}
