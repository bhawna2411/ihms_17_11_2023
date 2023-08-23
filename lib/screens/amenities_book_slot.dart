import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/AmenitiesResponseModel.dart';
import 'package:ihms/models/UserProfileResponseModel.dart';
import 'package:ihms/utils.dart';
import 'package:jiffy/jiffy.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AmenitiesBookSlot extends StatefulWidget {
  Datumm amenitiesListData;
  AmenitiesBookSlot(this.amenitiesListData);

  @override
  State<AmenitiesBookSlot> createState() => _AmenitiesBookSlotState();
}

class _AmenitiesBookSlotState extends State<AmenitiesBookSlot> {
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;
  bool check4 = false;
  bool check5 = false;
  bool check6 = false;
  bool check7 = false;
  List<String> time;
  bool dateSelected = true;
  List<SlotElement> slotTimeList;
  String dropdownValue;
  String slotStartTime;
  String slotEndTime;
  CalendarController _controller;
  bool isDateGone;
  int amount;
  int payAmount;
  String paymentby;
  Razorpay _razorpay;
  int selectedValue;
  Map<DateTime, List<SlotElement>> _events;
  TextEditingController commentController = TextEditingController();
  UserProfileResponseModel userProfileResponseModel;
//  Map<DateTime, List<String>> _eventsData;
 Map<DateTime, List<String>> _eventsData = {};


  @override
  void initState() {
    super.initState();
    _events = {};
    userProfile().then((value) {
      userProfileResponseModel = value;
      setState(() {});
    });
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _controller = CalendarController();
    dropdownValue = widget.amenitiesListData.bookingType;
    var currentFormat = DateFormat('yyyy-MM-dd');
    var currentDate = currentFormat.format(DateTime.now());
    slotTimeList = widget.amenitiesListData.slot
        .where((element) =>
            convertDateTimeDisplay(element.multislotStarttime) == currentDate)
        .toList();
    setState(() {});

   widget.amenitiesListData.slot.forEach((element) {
    if(element.multislotNumberofseats != "0"){
        Jiffy jiffyDateTime = Jiffy(element.multislotStarttime, "yyyy-MM-dd hh:mm a");
        String year = jiffyDateTime.format("yyyy");
        String month = jiffyDateTime.format("MM");
        String date = jiffyDateTime.format("dd");

        DateTime eventDate = DateTime(int.parse(year), int.parse(month), int.parse(date));


        if (_eventsData.containsKey(eventDate)) {
          _eventsData[eventDate].add('symbol1');
        } else {
          _eventsData[eventDate] = ['symbol1'];
        }
    }
});

  }


  @override
  void dispose() {
    _controller.dispose();
    _razorpay.clear();
    super.dispose();
  }

  void onRadioChanged(int value) {
    setState(() {
      selectedValue = value;
      slotStartTime = slotTimeList[value].multislotStarttime;
      slotEndTime = slotTimeList[value].multislotEndtime;
      amount = int.parse(slotTimeList[value].multislotAmount);
    });
  }




  void openCheckout(String orderId, int totalAmount) async {
    var options = {
      'key': 'rzp_live_aQI5jsUi2gFbAW',
      // 'key': 'rzp_test_RPD53nMcVczQWe',
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
      // 'external': {
      //   'wallets': ['paytm']
      // }
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
    amenityParticipate(
        widget.amenitiesListData.name,
        widget.amenitiesListData.id,
        widget.amenitiesListData.amenityPayType,
        widget.amenitiesListData.bookingType,
        slotStartTime,
        slotEndTime,
        response.orderId,
        response.paymentId,
        amount,
        1,
        "SUCCESS",
        context,
        commentController.text);
// print("success ========================= ");
//     Fluttertoast.showToast(
//         msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response, contaxt) async {
    showLoader(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd');
    final DateFormat serverFormater = DateFormat('yyyy-MM-dd');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  String convertTimeDisplay(String date) {
    final DateTime displayDate = DateFormat('dd-MM-yyyy hh:mm').parse(date);
    final String formatted = DateFormat('hh:mm a').format(displayDate);
    return formatted;
  }

  _generateOrderId(BuildContext context, int totalAmount, String startDate,
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
      });
    });
  }

  registerAmenity(BuildContext context, int amount, int id, String name,
      String startslot, String endslot) async {
    if (selectedValue == null) {
      showToast(
        'Please select atleast one slot',
      );
    } else {
      setState(() {
        _generateOrderId(context, amount, startslot, endslot);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
          title: Text(widget.amenitiesListData.name,
              style: TextStyle(
                  color: Color(0xFF90700b), fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("<${widget.amenitiesListData.amenityPayType}>",
                  style: TextStyle(
                      color: Color(0xFF90700b),
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              SizedBox(
                height: 30,
              ),
              Text("BOOKING TYPE",
                  style: TextStyle(
                      color: Color(0xFFcbb269),
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
              SizedBox(
                height: 10,
              ),
              Text(dropdownValue,
                  style: TextStyle(
                      color: Color(0xFFcbb269),
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),

              SizedBox(
                height: 5,
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 16),
              //   decoration: BoxDecoration(
              //     border: Border(
              //       top: BorderSide(color: Color(0xFFcbb269), width: 2.0),
              //       bottom: BorderSide(color: Color(0xFFcbb269), width: 2.0),
              //     ),
              //   ),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton<String>(
              //       icon: Icon(Icons.keyboard_arrow_down,
              //           color: Color(0xFFcbb269)),
              //       isExpanded: true,
              //       value: dropdownValue,
              //       items: <String>[
              //         'Single',
              //         'Multiple',
              //       ].map((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value,
              //               style: TextStyle(color: Color(0xFFcbb269))),
              //         );
              //       }).toList(),
              //       onChanged: (String newValue) {
              //         dropdownValue = newValue;
              //         setState(() {});
              //         print(dropdownValue);
              //       },
              //       hint: Text('Select an option'),
              //     ),
              //   ),
              // ),

              SizedBox(height: 10),
              TableCalendar(
                startDay: DateTime.now(),
                endDay: DateTime(DateTime.now().year + 1),
                initialCalendarFormat: CalendarFormat.month,
                calendarStyle: CalendarStyle(
                  outsideStyle: TextStyle(color: Color(0xFFcbb269)),
                  weekdayStyle: TextStyle(color: Color(0xFFcbb269)),
                  holidayStyle: TextStyle(color: Color(0xFFcbb269)),
                  weekendStyle: TextStyle(color: Color(0xFFcbb269)),
                  outsideHolidayStyle: TextStyle(color: Color(0xFFcbb269)),
                  outsideWeekendStyle: TextStyle(color: Color(0xFFcbb269)),
                  eventDayStyle: TextStyle(color: Color(0xFFcbb269)),
                  // todayColor: Colors.transparent,
                  selectedColor: Theme.of(context).primaryColor,
                  // todayStyle: TextStyle(
                  //     color: Color(0xFFcbb269)),
                ),
                events: _eventsData,               
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(color: Colors.black),
                  weekdayStyle: TextStyle(color: Colors.black),
                ),
                headerStyle: HeaderStyle(
                  centerHeaderTitle: true,
                  formatButtonDecoration: BoxDecoration(
                    color: Color(0xFFcbb269),
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false,
                ),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: (date, events, day) {
                  var outputFormat = DateFormat('yyyy-MM-dd');
                  var outputDate = outputFormat.format(date);
                  slotTimeList = widget.amenitiesListData.slot
                      .where((element) =>
                          convertDateTimeDisplay(element.multislotStarttime) ==
                          outputDate)
                      .toList();
                  dateSelected = false;
                  setState(() {});
                },
                builders: CalendarBuilders(
                  selectedDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xFFcbb269),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(color: Colors.white),
                      )),
                  todayDayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: dateSelected
                              ? Color(0xFFcbb269)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                            color: dateSelected
                                ? Colors.white
                                : Color(0xFFcbb269)),
                      )),
                ),
                calendarController: _controller,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: slotTimeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final DateTime givenDate =
                              DateFormat('yyyy-MM-dd hh:mm a').parse(
                                  slotTimeList[index].multislotStarttime);
                          String formattedDate =
                              DateFormat('yyyy-MM-dd hh:mm a')
                                  .format(DateTime.now());
                          final DateTime currentDate =
                              DateFormat('yyyy-MM-dd hh:mm a')
                                  .parse(formattedDate);
                          return int.parse(slotTimeList[index].multislotNumberofseats) == 0 ||
                                  int.parse(slotTimeList[index]
                                          .multislotNumberofseats) <
                                      0 ||
                                  currentDate.isAfter(givenDate)
                              ? Container()
                              : Row(
                                  children: [
                                    Radio(
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => Color(0xFFcbb269)),
                                      value: index,
                                      groupValue: selectedValue,
                                      onChanged: onRadioChanged,
                                    ),
                                    Text(
                                        "${convertTimeDisplay(slotTimeList[index].multislotStarttime)} - ${convertTimeDisplay(slotTimeList[index].multislotEndtime)}",
                                        style: TextStyle(
                                          color: Color(0xFFcbb269),
                                        )),
                                  ],
                                );
                        })
                  ],
                ),
              ),
              SizedBox(height: 50),
              Row(
                children: [
                  Text("COMMENTS",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFcbb269))),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: commentController,
                maxLines: 3,
                style: TextStyle(
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFa5a5a5),
                    fontSize: 12),
                decoration: InputDecoration(
                    labelText: 'Write your comments...',
                    alignLabelWithHint: true,
                    labelStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFcbb269),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Color(0xFFcbb269)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xFFcbb269),
                      ),
                      borderRadius: BorderRadius.circular(0),
                    )),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  if (widget.amenitiesListData.amenityPayType == "non-paid") {
                    if (selectedValue == null) {
                      showToast(
                        'Please select atleast one slot',
                      );
                    } else {
                      amenityParticipate(
                          widget.amenitiesListData.name,
                          widget.amenitiesListData.id,
                          widget.amenitiesListData.amenityPayType,
                          widget.amenitiesListData.bookingType,
                          slotStartTime,
                          slotEndTime,
                          "No Paid",
                          "No Paid",
                          0,
                          1,
                          "SUCCESS",
                          context,
                          commentController.text);
                    }
                  } else {
                    registerAmenity(
                        context,
                        amount,
                        widget.amenitiesListData.id,
                        widget.amenitiesListData.name,
                        slotStartTime,
                        slotEndTime);
                  }
                },
                child: Center(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFcbb269),
                      ),
                      child: Text(
                        "Book Now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
