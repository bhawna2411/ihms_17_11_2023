import 'dart:core';
import 'package:flutter/material.dart';
import 'package:ihms/models/UserProfileResponseModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/AvailableSeatsResponseModel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'Thankyou_join_activities.dart';
import 'package:intl/intl.dart';

class ParticipantsDetailScreen extends StatefulWidget {
  @override
  int eventID;
  String adultAmt;
  String childAmt;
  String eventName;
  int multislot;
  List<String> eventStarttime;
  List<String> eventEndtime;
  List<String> multislotstime;
  List<String> multislotetime;
  ParticipantsDetailScreen(this.eventID, this.adultAmt, this.childAmt,
      this.eventName, this.multislot, this.multislotstime, this.multislotetime);
  _ParticipantsDetailScreenState createState() =>
      _ParticipantsDetailScreenState();
}

class _ParticipantsDetailScreenState extends State<ParticipantsDetailScreen> {
  int adultCount = 0;
  int childCount = 0;
  int amount = 0;
  String paymentby;
  String orderIdData;
  AvailableSeatsResponseModel availableSeatsResponseModel;
  bool _isLoading;
  int selectedseat = 0;
  String dropdownvalueFortime = "Select Multislottime";
  Razorpay _razorpay;
  var uuid = Uuid();
  getseat() {
    availableSeat(widget.eventID, context).then((value) {
      setState(() {
        availableSeatsResponseModel = value;
        _isLoading = false;
      });

      print(
          '-------------availableSeatsResponseModel.data[0].numberOfSeatsAvailable----------------${availableSeatsResponseModel.data[0].numberOfSeatsAvailable}');
    });
  }
  _generateOrderId(BuildContext context) async {
SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    paymentby = "razorpay";
      generateOrderIdRequest(
        amount,
        userId,
        paymentby,
        context,
      ).then((value) {
        orderIdData = value.orderId;
        print("Order id api : $orderIdData");
        setState(() {
          
        });
      });
    }
  
  _register(BuildContext context) async {
    await availableSeat(widget.eventID, context).then((value) {
      availableSeatsResponseModel = value;

      print(availableSeatsResponseModel.data[0].numberOfSeatsAvailable);
    });

    (adultCount + childCount) <=
            int.parse(
                availableSeatsResponseModel.data[0].numberOfSeatsAvailable)
        ? openCheckout()
        : Container();
    //print(availableSeatsResponseModel.data[0].numberOfSeatsAvailable);
    //Container();
    // print(adultCount + childCount);
    //await participateRegister(adultCount, childCount, widget.eventID, context);
    // Future.delayed(const Duration(milliseconds: 50), () {
    //   setState(() {
    //     (adultCount + childCount) <=
    //             int.parse(
    //                 availableSeatsResponseModel.data[0].numberOfSeatsAvailable)
    //         ? openCheckout()
    //         : showToast(
    //             'No. of available seat is less than selected candidate',
    //           );
    //   });
    // });
  }
  @override
  Widget build(BuildContext context) {
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
                        //image: NetworkImage(widget.eventData.splitImage[0]),
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
                                        "Available Seat :-  ${availableSeatsResponseModel != null ? int.parse(availableSeatsResponseModel?.data[0].numberOfSeatsAvailable) : ' '}"),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border.all(
                                        color: Color(0xFF9a7210),
                                        width: 0.5,
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Adult",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFFb48919),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                adultCount <= 0
                                                    ? adultCount = 0
                                                    : adultCount =
                                                        adultCount - 1;
                                              });
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              color: Color(0xFF9a7210),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(6),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.09,
                                              child: Center(
                                                child: FittedBox(
                                                  child: Text(
                                                    adultCount.toString(),
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      // color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                adultCount = adultCount + 1;
                                              });
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.add,
                                                color: Color(0xFF9a7210),
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
                                Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      border: Border.all(
                                        color: Color(0xFF9a7210),
                                        width: 0.5,
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Children",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFFb48919),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                childCount <= 0
                                                    ? childCount = 0
                                                    : childCount =
                                                        childCount - 1;
                                              });
                                              
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              color: Color(0xFF9a7210),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(6),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.09,
                                              child: Center(
                                                child: FittedBox(
                                                  child: Text(
                                                    childCount.toString(),
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      // color: Colors.green,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                childCount = childCount + 1;
                                              });
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(right: 10),
                                              child: Icon(
                                                Icons.add,
                                                color: Color(0xFF9a7210),
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
                                widget.multislot == 1
                                    ? Container(
                                        height: 40,
                                        width: 240,
                                        padding: EdgeInsets.all(2),
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
                                              fontSize: 15,
                                              color: Color(0xFFb48919),
                                            ),
                                          ),
                                          isExpanded: true,
                                          underline: Container(
                                              color: Colors.transparent),
                                          items: List.generate(
                                            widget.multislotstime.length,
                                            (int index) {
                                              return DropdownMenuItem<String>(
                                                value: DateFormat(
                                                            "MMM dd,hh:mm")
                                                        .format(DateTime.parse(
                                                            widget
                                                                .multislotstime
                                                                .elementAt(
                                                                    index))) +
                                                    ' - ' +
                                                    DateFormat("MMM dd,hh:mm")
                                                        .format(DateTime.parse(
                                                            widget
                                                                .multislotetime
                                                                .elementAt(
                                                                    index))),
                                                child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5.0),
                                                    height: 100.0,
                                                    child: Text(DateFormat("MMM dd,hh:mm")
                                                            .format(DateTime.parse(
                                                                widget
                                                                    .multislotstime
                                                                    .elementAt(
                                                                        index))) +
                                                        ' - ' +
                                                        DateFormat("MMM dd,hh:mm")
                                                            .format(DateTime.parse(
                                                                widget.multislotetime.elementAt(index))))),
                                              );
                                            },
                                          ),
                                          onChanged: (newValue) {
                                            setState(() {
                                              dropdownvalueFortime = newValue;
                                              print(
                                                  '---newValueee---$newValue');
                                            });
                                          },
                                        ),
                                        // child: Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Container(
                                        //       width: 200,
                                        //       child: DropdownButton<String>(
                                        //         hint: Text(
                                        //           "Service Type",
                                        //           style: TextStyle(
                                        //             fontSize: 20,
                                        //             color: Color(0xFFb48919),
                                        //           ),
                                        //         ),
                                        //         // isExpanded: true,
                                        //         items: <String>['A', 'B', 'C', 'D']
                                        //             .map((String value) {
                                        //           return DropdownMenuItem<String>(
                                        //             value: value,
                                        //             child: Text(value),
                                        //           );
                                        //         }).toList(),
                                        //         onChanged: (_) {},
                                        //       ),
                                        //     )
                                        // Container(
                                        //   margin: EdgeInsets.only(left: 10),
                                        //   child: Text(
                                        //     "Children",
                                        //     style: TextStyle(
                                        //       fontSize: 20,
                                        //       color: Color(0xFFb48919),
                                        //     ),
                                        //   ),
                                        // ),
                                        // Row(
                                        //   children: [
                                        //     GestureDetector(
                                        //       onTap: () {
                                        //         setState(() {
                                        //           childCount <= 0
                                        //               ? childCount = 0
                                        //               : childCount =
                                        //                   childCount - 1;
                                        //         });
                                        //       },
                                        //       child: Icon(
                                        //         Icons.remove,
                                        //         color: Color(0xFF9a7210),
                                        //       ),
                                        //     ),
                                        //     SizedBox(
                                        //       height: 12,
                                        //     ),
                                        //     Padding(
                                        //       padding: const EdgeInsets.all(6),
                                        //       child: SizedBox(
                                        //         width: MediaQuery.of(context)
                                        //                 .size
                                        //                 .width *
                                        //             0.09,
                                        //         child: Center(
                                        //           child: FittedBox(
                                        //             child: Text(
                                        //               childCount.toString(),
                                        //               style: TextStyle(
                                        //                 fontSize: 18,
                                        //                 fontWeight:
                                        //                     FontWeight.w500,
                                        //                 // color: Colors.green,
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     GestureDetector(
                                        //       onTap: () {
                                        //         setState(() {
                                        //           childCount = childCount + 1;
                                        //         });
                                        //       },
                                        //       child: Container(
                                        //         margin:
                                        //             EdgeInsets.only(right: 10),
                                        //         child: Icon(
                                        //           Icons.add,
                                        //           color: Color(0xFF9a7210),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        //   ],
                                        // ),
                                      )
                                    : Container(),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    
                                    Text("Total Amount"),
                                    SizedBox(width: 10),
                                    Text(
                                      "\u{20B9} ${amount = adultCount * int.parse(widget.adultAmt) + childCount * int.parse(widget.childAmt)}",
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: (adultCount + childCount) <=
                                int.parse(availableSeatsResponseModel
                                    .data[0].numberOfSeatsAvailable)
                            ? GestureDetector(
                                onTap: () {
                                  adultCount == 0 && childCount == 0
                                      ? Fluttertoast.showToast(
                                          msg: "Add Participants First",
                                          gravity: ToastGravity.CENTER,
                                          toastLength: Toast.LENGTH_SHORT,
                                          timeInSecForIosWeb: 1,
                                        )
                                      : _register(context);
                                  // openCheckout();
                                  // print(adultCount);
                                  // print(childCount);
                                   _generateOrderId(context);
                                  print("participate now screen");
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
                                // onTap: () {
                                //   pendingeventrequest(
                                //       widget.eventID,
                                //       adultCount,
                                //       childCount,
                                //       widget.eventName,
                                //       context);
                                // },
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
                                            fontSize: 30,
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
  // var uuid = Uuid();
  void initState() {
    _loadUserDetails = userProfile();

    setState(() {
      userProfile().then((value) {
        userProfileResponseModel = value;
        print("OBJECT ${value.data.name}");
        setState(() {});
      });
    });
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _isLoading = true;
    getseat();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var amount = (adultCount * int.parse(widget.adultAmt) +
            childCount * int.parse(widget.childAmt)) *
        100;


    print("Order id $orderIdData");
    print("Amount $amount");

    var options = {
      'key': 'rzp_test_6HQ6WlDv3eDGPr',
      'amount': amount,
      'name': 'Total Amount',
      "currency": "INR",
      "payment_capture": 2,
      "base_currency": "INR",
      "order_id": orderIdData,
      //"base_currency": "INR",
      // 'description': 'Fine T-Shirt',
      'prefill': {
        'contact': userProfileResponseModel.data.mobile,
        'email': userProfileResponseModel.data.email
      },
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };
    print("This is external wallet");
    print("This is Order id: $orderIdData");
    Future.delayed(Duration(milliseconds: 300), () {
      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => ThankyouJoinACtivitiesScreen(
              "Your request for ${widget.eventName} participation has been received. If more family members are keen to participate, please click on participate button again! ."))); //Seats will be alloted to you once it gets approved.")));
    });

    try {
      // print("helllhvhgjhv");
      print("options-------------------- detail--------------${options.toString()}");
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    print("--------------_handlePaymentSuccess----------$response");

    print("userId------------ $userId");
    print("respnse razorpay =====  ${response.toString()}");
    print("respnse order id razorpay =====  ${response.orderId}");
    print("respnse payment id razorpay =====  ${response.paymentId}");
    print("respnse signature razorpay =====  ${response.signature}");

    // addTransaction(userId,response.orderId,response.paymentId,amount,"SUCCESS",context);

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
    // paidregister(
    //     widget.eventID, adultCount, childCount, widget.eventName, context);
        // var orderId = response.orderId;
    // _register(context);
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    print("--------_handlePaymentError----------${response.message}");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
   // addTransaction(userId,orderIdData,'',amount,"FAILURE",context);
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
    Navigator.pop(context);
  }

  void _handleExternalWallet(ExternalWalletResponse response, contaxt) async {
    showLoader(context);
 SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    // addTransaction(userId,orderIdData,'',amount,"SUCCESS",context);

    print("--------------_handleExternalWallet----------$response");

    // addTransaction(userId,'',amount,"SUCCESS",context);


    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }
}


