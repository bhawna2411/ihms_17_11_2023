import 'dart:core';
import 'package:flutter/material.dart';
import 'package:ihms/models/UserProfileResponseModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/AvailableSeatsResponseModel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/EventsResponseModel.dart';
import '../models/OrderIdResponse.dart';
import 'package:intl/intl.dart';

class ParticipantsDetailScreen extends StatefulWidget {
  @override
  // ignore: override_on_non_overriding_member
  int eventID;
  String adultAmt;
  String childAmt;
  String eventName;
  int multislot;
  List<String> eventStarttime;
  List<String> eventEndtime;
  List<MultislotTime> multislotstime;
  EventData eventData;

  ParticipantsDetailScreen(this.eventID, this.adultAmt, this.childAmt,
      this.eventName, this.multislot, this.multislotstime, this.eventData);

  _ParticipantsDetailScreenState createState() =>
      _ParticipantsDetailScreenState();
}

class _ParticipantsDetailScreenState extends State<ParticipantsDetailScreen> {
  Future<OrderIdResponse> orderIdResponse;
  int adultCount = 0;
  int childCount = 0;
  int amount = 0;
  String paymentby;
  String _orderIdData;
  AvailableSeatsResponseModel availableSeatsResponseModel;
  bool _isLoading;
  int selectedseat = 0;
  String dropdownvalueFortime = "Select time slot";
  Razorpay _razorpay;
  List<ParticipantElement> multislotList = [];
  int dropdownSelectedIndex = 0;
  var uuid = Uuid();
  int payAmount;
  int seatsBooks;
  String _startDate = '';
  String _endDate = '';
  int _eventId = 0;
  String _UserId = '';
  int nonPaid;
  int numberofAvaliableSeats = 0;
  List<dynamic> categoryData = [];
  List<dynamic> uniqueCategory = [];
  Set<dynamic> uniqueAttributes = {};
  List<dynamic> uniqueObjects = [];
  List<dynamic> newCategory = [];
  var _currentDate = DateTime.now();
  List<String> sdate = [];
  List<String> edate = [];
  List<int> index_value = [];
  List<String> seatsavailable = [];

  getseat() {
    availableSeat(widget.eventID, context).then((value) {
      setState(() {
        availableSeatsResponseModel = value;
        _isLoading = false;
      });
    });
  }

  getFilteredDate() {
    for (var i = 0; i < widget.eventData.multislotTime.length; i++) {
      var dataa = DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(DateTime.parse(widget.eventData.multislotTime[i].startDate));
      if (_currentDate.isBefore(DateTime.parse(dataa))) {
        sdate.add(widget.eventData.multislotTime[i].startDate);
        edate.add(widget.eventData.multislotTime[i].endDate);
        index_value.add(i);
      }
    }
  }

  String time24to12Format(String time) {
    int h = int.parse(time.split(":").first);
    int m = int.parse(time.split(":").last.split(" ").first);
    String send = "";
    if (h > 12) {
      var temp = h - 12;
      send = "PM";
    } else {
      send = "AM";
    }
    return send;
  }

  _generateOrderId(
      BuildContext context,
      int totalAmount,
      int numberOfAvailableSeats,
      int totalseats,
      String startDate,
      String endDate) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    paymentby = "razorpay";
    generateOrderIdRequest(
      totalAmount,
      userId,
      paymentby,
      context,
    ).then((value) {
      openCheckout(value.orderId, totalAmount);
      setState(() {
        payAmount = totalAmount;
        seatsBooks = totalseats;
        _startDate = startDate;
        _endDate = endDate;
      });
    });
  }

  _register(
      BuildContext context,
      int totalAmount,
      int numberOfAvailableSeats,
      int totalseats,
      int eventId,
      String userId,
      String startDate,
      String endDate) async {
    setState(() {
      payAmount = totalAmount;
      seatsBooks = totalseats;
      _eventId = eventId;
      _UserId = userId;
      if (widget.eventData.multislot != 1) {
        _startDate =
            widget.eventData.start_date + " " + widget.eventData.start_time;
        _endDate = widget.eventData.end_date + " " + widget.eventData.end_time;

        _generateOrderId(context, totalAmount, numberOfAvailableSeats,
            totalseats, startDate, endDate);
      } else {
        _startDate = startDate;
        _endDate = endDate;

        _generateOrderId(context, totalAmount, numberOfAvailableSeats,
            totalseats, startDate, endDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int _totalamount = 0;
    int _totalSeats = 0;
    int totalQunatity = 0;
    setState(() {
      if (widget.multislot == 1 && widget.eventData.multislotTime.length > 0) {
        for (var item in widget
            .eventData.multislotTime[dropdownSelectedIndex].participants) {
          _totalamount = _totalamount + int.parse(item.mamount) * item.quantity;
          _totalSeats = _totalSeats + item.quantity.toInt();
          totalQunatity = totalQunatity + item.quantity.toInt();
          numberofAvaliableSeats = widget
              .eventData.multislotTime[dropdownSelectedIndex].seatsAvailable;
        }
      } else {
        for (var item in widget.eventData.participants) {
          _totalamount =
              _totalamount + int.parse(item.amount) * item.totalseats;
          _totalSeats = _totalSeats + item.totalseats.toInt();
          totalQunatity = totalQunatity + item.totalseats.toInt();
          numberofAvaliableSeats =
              int.parse(widget.eventData.number_of_seats_available);
        }
      }
    });
    return Scaffold(
        backgroundColor: Color(0xFFfbf0d4),
        body: _isLoading == true
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Stack(children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            ExactAssetImage("assets/images/dashboard_bg.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.29,
                    ),
                    height: MediaQuery.of(context).size.height * .7,
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
                          color: Color(0xFF203040),
                          onPressed: () => {Navigator.pop(context)}),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                        ),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            padding: EdgeInsets.all(30),
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width * .5),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Available Seat :-  ${numberofAvaliableSeats < 0 ? "0" : numberofAvaliableSeats.toString()}"),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "Scroll For More Categories"),
                                  ],
                                ),
                                 SizedBox(
                                  height: 20,
                                ),
                                widget.multislot == 1
                                    ? Container(
                                        height: 150,
                                        child: ListView.builder(
                                            itemCount: widget
                                                .eventData
                                                .multislotTime[
                                                    dropdownSelectedIndex]
                                                .participants
                                                .length,
                                            itemBuilder: ((context, index) {

                                              return Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.grey.shade50,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFF9a7210),
                                                          width: 0.5,
                                                        )),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: Text(
                                                            widget
                                                                .eventData
                                                                .multislotTime[
                                                                    dropdownSelectedIndex]
                                                                .participants[
                                                                    index]
                                                                .mparticipantName,
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              color: Color(
                                                                  0xFFb48919),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  widget
                                                                      .eventData
                                                                      .multislotTime[
                                                                          dropdownSelectedIndex]
                                                                      .participants[
                                                                          index]
                                                                      .quantity = widget
                                                                              .eventData
                                                                              .multislotTime[
                                                                                  dropdownSelectedIndex]
                                                                              .participants[
                                                                                  index]
                                                                              .quantity >
                                                                          0
                                                                      ? widget
                                                                              .eventData
                                                                              .multislotTime[dropdownSelectedIndex]
                                                                              .participants[index]
                                                                              .quantity -
                                                                          1
                                                                      : 0;
                                                                  if (widget
                                                                          .eventData
                                                                          .multislotTime[
                                                                              dropdownSelectedIndex]
                                                                          .participants[
                                                                              index]
                                                                          .quantity !=
                                                                      0) {
                                                                    categoryData.remove(widget
                                                                        .eventData
                                                                        .multislotTime[
                                                                            dropdownSelectedIndex]
                                                                        .participants[
                                                                            index]
                                                                        .mparticipantName);
                                                                  }
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: Color(
                                                                    0xFF9a7210),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6),
                                                              child: SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.09,
                                                                child: Center(
                                                                  child:
                                                                      FittedBox(
                                                                    child: Text(
                                                                      widget
                                                                          .eventData
                                                                          .multislotTime[
                                                                              dropdownSelectedIndex]
                                                                          .participants[
                                                                              index]
                                                                          .quantity
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  widget
                                                                      .eventData
                                                                      .multislotTime[
                                                                          dropdownSelectedIndex]
                                                                      .participants[
                                                                          index]
                                                                      .quantity = widget
                                                                          .eventData
                                                                          .multislotTime[
                                                                              dropdownSelectedIndex]
                                                                          .participants[
                                                                              index]
                                                                          .quantity +
                                                                      1;
                                                                  if (widget
                                                                          .eventData
                                                                          .multislotTime[
                                                                              dropdownSelectedIndex]
                                                                          .participants[
                                                                              index]
                                                                          .quantity !=
                                                                      0) {
                                                                    categoryData.add(widget
                                                                        .eventData
                                                                        .multislotTime[
                                                                            dropdownSelectedIndex]
                                                                        .participants[
                                                                            index]
                                                                        .mparticipantName);
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            10),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Color(
                                                                      0xFF9a7210),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              );
                                            })),
                                      )
                                    : Container(
                                        height: 150,
                                        child: ListView.builder(
                                            itemCount: widget
                                                .eventData.participants.length,
                                            itemBuilder: ((context, index) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.grey.shade50,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                        border: Border.all(
                                                          color:
                                                              Color(0xFF9a7210),
                                                          width: 0.5,
                                                        )),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: Text(
                                                            widget
                                                                .eventData
                                                                .participants[
                                                                    index]
                                                                .participantName,
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              color: Color(
                                                                  0xFFb48919),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  widget
                                                                      .eventData
                                                                      .participants[
                                                                          index]
                                                                      .totalseats = widget
                                                                              .eventData
                                                                              .participants[
                                                                                  index]
                                                                              .totalseats >
                                                                          0
                                                                      ? widget
                                                                              .eventData
                                                                              .participants[index]
                                                                              .totalseats -
                                                                          1
                                                                      : 0;
                                                                  if (widget
                                                                          .eventData
                                                                          .participants[
                                                                              index]
                                                                          .totalseats !=
                                                                      0) {
                                                                    categoryData.remove(widget
                                                                        .eventData
                                                                        .participants[
                                                                            index]
                                                                        .participantName);
                                                                  }
                                                                });
                                                              },
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: Color(
                                                                    0xFF9a7210),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 12,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6),
                                                              child: SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.09,
                                                                child: Center(
                                                                  child:
                                                                      FittedBox(
                                                                    child: Text(
                                                                      widget
                                                                          .eventData
                                                                          .participants[
                                                                              index]
                                                                          .totalseats
                                                                          .toString(),
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  widget
                                                                      .eventData
                                                                      .participants[
                                                                          index]
                                                                      .totalseats = widget
                                                                          .eventData
                                                                          .participants[
                                                                              index]
                                                                          .totalseats +
                                                                      1;
                                                                  if (widget
                                                                          .eventData
                                                                          .participants[
                                                                              index]
                                                                          .totalseats !=
                                                                      0) {
                                                                    categoryData.add(widget
                                                                        .eventData
                                                                        .participants[
                                                                            index]
                                                                        .participantName);
                                                                  }
                                                                });
                                                              },
                                                              child: Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            10),
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: Color(
                                                                      0xFF9a7210),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              );
                                            })),
                                      ),
                                widget.multislot == 1
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            border: Border.all(
                                              color: Color(0xFF9a7210),
                                              width: 0.5,
                                            )),
                                        child: DropdownButton<String>(
                                          hint: Text(
                                            dropdownvalueFortime,
                                            style: TextStyle(
                                              // fontSize: 15,
                                              fontSize: 16,
                                              color: Color(0xFFb48919),
                                            ),
                                          ),
                                          isExpanded: true,
                                          underline: Container(
                                              color: Colors.transparent),
                                          items: List.generate(
                                            sdate.length,
                                            (int index) {

                                              return widget.multislotstime !=
                                                      null
                                                  ? DropdownMenuItem<String>(
                                                      onTap: () {
                                                        setState(() {
                                   
                                                        });
                                                            if (widget.multislot == 1) {
                                                            widget.eventData.multislotTime[dropdownSelectedIndex].participants
                                                                .forEach((element) {
                                                              setState(() {
                                                                element.quantity = 0;
                                                                categoryData.clear();
                                                              });
                                                            });
                                                          } else {
                                                            widget.eventData.participants.forEach((element) {
                                                              setState(() {
                                                                element.totalseats = 0;
                                                                categoryData.clear();
                                                              });
                                                            });
                                                          }
                                                        dropdownSelectedIndex =
                                                            index_value[index];
                                                        dropdownSelectedIndex =
                                                            index_value[index];
                                                        var stdate = DateFormat(
                                                                "yyyy-MM-dd HH:mm:ss")
                                                            .format(DateTime
                                                                .parse(sdate[
                                                                    index]));
                                                        _startDate = stdate;
                                                        var etdate = DateFormat(
                                                                "yyyy-MM-dd HH:mm:ss")
                                                            .format(DateTime
                                                                .parse(edate[
                                                                    index]));
                                                        _endDate = etdate;
                                                      },
                                                      value: DateFormat(
                                                                  "MMM dd,hh:mm")
                                                              .format(DateTime.parse(
                                                                  sdate[index]
                                                                      .toString())) +
                                                          ' ' +
                                                          time24to12Format(DateFormat(
                                                                  "HH:mm")
                                                              .format(DateTime.parse(
                                                                  sdate[index]
                                                                      .toString()))) +
                                                          ' - ' +
                                                          DateFormat("MMM dd,hh:mm")
                                                              .format(DateTime.parse(edate[index].toString())) +
                                                          ' ' +
                                                          time24to12Format(DateFormat("HH:mm").format(DateTime.parse(edate[index].toString()))),
                                                      child: Container(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  bottom: 5.0),
                                                          height: 100.0,
                                                          child: Text(DateFormat(
                                                                      "MMM dd,hh:mm")
                                                                  .format(DateTime.parse(
                                                                      sdate[index]
                                                                          .toString())) +
                                                              ' ' +
                                                              time24to12Format(
                                                                  DateFormat("HH:mm")
                                                                      .format(
                                                                          DateTime.parse(sdate[index].toString()))) +
                                                              ' - ' +
                                                              DateFormat("MMM dd,hh:mm").format(DateTime.parse(edate[index].toString())) +
                                                              ' ' +
                                                              time24to12Format(DateFormat("HH:mm").format(DateTime.parse(edate[index].toString()))))),
                                                    )
                                                  : Container();
                                            },
                                          ),
                                          onChanged: (newValue) {
                                            setState(() {
                                              dropdownvalueFortime = newValue;
                                            });
                                          },
                                        ),
                                      )
                                    : Container(),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text("Total Amount"),
                                    SizedBox(width: 10),
                                    Text(
                                      "\u{20B9} ${_totalamount}",
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: totalQunatity <= numberofAvaliableSeats
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    categoryData.forEach((element) {
                                      newCategory.add({"category": element});
                                    });
                                  });

                                  _totalSeats == 0 &&
                                          _totalamount == 0
                                      ? Fluttertoast.showToast(
                                          msg: widget.eventData.multislot == 1
                                              ? "Please Select valid Participants and Time Slot"
                                              : "Add Participants First",
                                          gravity: ToastGravity.CENTER,
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                        )
                                      : widget.eventData.multislot == 1 &&
                                              dropdownvalueFortime ==
                                                  "Select time slot"
                                          ? Fluttertoast.showToast(
                                              msg: "Please Select Time Slot",
                                              gravity: ToastGravity.CENTER,
                                              toastLength: Toast.LENGTH_SHORT,
                                              timeInSecForIosWeb: 1,
                                            )
                                          : _register(
                                              context,
                                              _totalamount,
                                              numberofAvaliableSeats,
                                              _totalSeats,
                                              widget.eventID,
                                              widget.eventName,
                                              _startDate,
                                              _endDate);
                                },
                                child: Container(
                                  height: 70,
                                  width: 260,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        const Color(0xFFb48919),
                                        const Color(0xFF9a7210),
                                      ],
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 4),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            70.0) //                 <--- border radius here
                                        ),
                                  ),
                                  child: Center(
                                    child: Text("Pay Now",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            // fontSize: 30,
                                            fontSize: 16,
                                            color: Colors.white)),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  pendingeventrequest(
                                      widget.eventID,
                                      widget.eventName,
                                      _totalSeats,
                                      widget.eventData.multislot == 1
                                          ? _startDate
                                          : '${widget.eventData.start_date} ',
                                      widget.eventData.multislot == 1
                                          ? _endDate
                                          : '${widget.eventData.end_date} ',
                                      context);
                                },
                                child: Container(
                                  height: 70,
                                  width: 260,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        const Color(0xFFb48919),
                                        const Color(0xFF9a7210),
                                      ],
                                    ),
                                    border: Border.all(
                                        color: Colors.white, width: 4),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            70.0) //                 <--- border radius here
                                        ),
                                  ),
                                  child: Center(
                                    child: Text("Register later",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            fontSize: 16,
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ]),
              ));
  }

  Future _loadUserDetails;
  UserProfileResponseModel userProfileResponseModel;

  @override
  void initState() {
    _loadUserDetails = userProfile();

    setState(() {
      userProfile().then((value) {
        userProfileResponseModel = value;
        setState(() {});
      });
    });
    if (widget.multislot == 1) {
      widget.eventData.multislotTime[dropdownSelectedIndex].participants
          .forEach((element) {
        setState(() {
          element.quantity = 0;
        });
      });
    } else {
      widget.eventData.participants.forEach((element) {
        setState(() {
          element.totalseats = 0;
        });
      });
    }
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _isLoading = true;
    getseat();
    getFilteredDate();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(String orderId, int totalAmount) async {
    var options = {
      'key': 'rzp_live_aQI5jsUi2gFbAW',
      'amount': totalAmount,
      'name': 'IHMS',
      "currency": "INR",
      "payment_capture": 1,
      "base_currency": "INR",
      "order_id": orderId,
      'prefill': {
        'contact': userProfileResponseModel.data.mobile,
        'email': userProfileResponseModel.data.email
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    addTransaction(
        dropdownvalueFortime,
        userId,
        response.orderId,
        response.paymentId,
        payAmount,
        "SUCCESS",
        context,
        _eventId,
        _UserId.toString(),
        seatsBooks.toString(),
        _startDate,
        _endDate,
        0,
        newCategory);

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response, contaxt) async {
    showLoader(context);
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }
}
