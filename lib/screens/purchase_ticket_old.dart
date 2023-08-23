import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:ihms/utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PurchaseTicket extends StatefulWidget {
  @override
  int eventID;
  String eventAmount;
  PurchaseTicket(this.eventID, this.eventAmount);
  _PurchaseTicketState createState() => _PurchaseTicketState();
}

class _PurchaseTicketState extends State<PurchaseTicket> {
  // List<GlobalKey<FormState>> _formKeys = [GlobalKey<FormState>()];
  //final _formKey = GlobalKey<FormState>();
  List<TextEditingController> _controllers = new List();
  List<TextEditingController> _controllers1 = new List();
  List<FocusNode> _FocusNode1 = new List();
  List<FocusNode> _FocusNode2 = new List();
  FocusNode myFocusNode1 = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();

  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  ScrollController controller = ScrollController();
  var _count = 0;

  List<Map<String, dynamic>> _values;

  static const platform = const MethodChannel("razorpay_flutter");

  Razorpay _razorpay;

  // Map<String, String Function(String)> formFields = {
  //     'username': (String? value) {
  //       return (value!.isEmpty) ? 'Can not be Empty' : null;
  //     },
  //     'password': (String? value) {
  //       return (value == null || value!.length < 8)
  //           ? 'Must be 8 Char Long'
  //           : null;
  //     },
  //   };

  _register(BuildContext context) async {
    print(
        "==========================PARTICIPANT REGISTRATION STARTS==========================================");

    bool validname;
    bool validmobile;

    for (var i = 0; i <= _controllers.length - 1; i++) {
      print(_controllers[i].text.runtimeType);
      if (_controllers[i].text.trim() == "" || _controllers[i].text == null) {
        validname = false;
      } else {
        validname = true;
      }
    }
    for (var i = 0; i <= _controllers1.length - 1; i++) {
      if (_controllers1[i].text.trim() == '') {
        validmobile = false;
      } else {
        validmobile = true;
      }
    }

    if (nameController.text.trim() == '' || nameController.text.length < 1) {
      showToast('Please Enter Name');
    } else if (mobileController.text.trim() == '' ||
        mobileController.text.length < 10) {
      showToast('Enter Valid Mobile Number');
    } else if (validname == false) {
      showToast('Please Enter Name');
    } else if (validmobile == false) {
      showToast('Enter Valid Mobile Number');
    } else {
      print(
          "$validmobile $validname ${nameController.text} ${mobileController.text}");

      // participateRegister(nameController.text, mobileController.text,
      //     _controllers, _controllers1, widget.eventID, context);
      print(
          "===============================PARTICIPANT REGISTERED====================================================");
    }
  }
  //    else if (mobileController.text.isNotEmpty &&
  //       nameController.text.isNotEmpty) {
  //     for (int i = 0; i < _controllers.length; i++) {
  //       if (validmobile = false) {
  //         showToast('Please Enter Name', context: context);
  //       }
  //     }
  //   } else if (mobileController.text.isNotEmpty &&
  //       nameController.text.isNotEmpty) {
  //     for (int i = 0; i < _controllers1.length; i++) {
  //       if (validmobile == false) {
  //         showToast('Enter Valid Mobile Number', context: context);
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFfbf0d4),
        body: SingleChildScrollView(
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * .50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  //image: NetworkImage(widget.eventData.splitImage[0]),
                  image: ExactAssetImage("assets/images/dashboard_bg.png"),
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
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * .5),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 10,
                      child: Container(
                        //color: Colors.white,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(
                                  20.0) //                 <--- border radius here
                              ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                //height: 10,
                                ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * .71,
                                height:
                                    MediaQuery.of(context).size.height * .085,
                                child: new TextFormField(
                                  controller: nameController,
                                  focusNode: myFocusNode1,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xFFa5a5a5))),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFa5a5a5)),
                                      ),
                                      border: UnderlineInputBorder(),
                                      labelText: 'Name',
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: myFocusNode1.hasFocus
                                              ? const Color(0xFFa5a5a5)
                                              : const Color(0xFFa5a5a5))),
                                ),
                              ),
                            ),
                            SizedBox(
                                // height: MediaQuery.of(context).size.height * .013,
                                ),
                            Container(
                              width: MediaQuery.of(context).size.width * .71,
                              height: MediaQuery.of(context).size.height * .085,
                              child: new TextFormField(
                                maxLength: 10,
                                controller: mobileController,
                                focusNode: myFocusNode2,
                                style: TextStyle(
                                    height: 1.5,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFa5a5a5),
                                    fontSize: 12),
                                cursorColor: const Color(0xFFa5a5a5),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    counterText: '',
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFFa5a5a5))),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xFFa5a5a5)),
                                    ),
                                    fillColor: Colors.white,
                                    border: UnderlineInputBorder(),
                                    labelText: 'Mobile No',
                                    labelStyle: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                        color: myFocusNode2.hasFocus
                                            ? const Color(0xFFa5a5a5)
                                            : const Color(0xFFa5a5a5))),
                                validator: (value) {
                                  if (value.length < 10 && value.isEmpty) {
                                    return "Atleast 10 digit required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _count,
                      itemBuilder: (context, index) {
                        print(index);
                        return _row(index);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FloatingActionButton(
                          child: Icon(
                            Icons.add,
                            color: Colors.red,
                            size: 35,
                          ),
                          backgroundColor: Color(0xFF9a7210),
                          onPressed: () async {
                            _controllers.add(new TextEditingController());
                            _controllers1.add(new TextEditingController());
                            _FocusNode1.add(new FocusNode());
                            _FocusNode2.add(new FocusNode());
                            // _formKeys.add(new GlobalKey<FormState>());
                            setState(() {
                              _count++;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // _register(context);
                          openCheckout();
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
                            border: Border.all(color: Colors.white, width: 4),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    70.0) //                 <--- border radius here
                                ),
                          ),
                          child: Center(
                            child: Text("Submit",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 30,
                                    color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ]),
        ));
  }

  _row(int index) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 10,
                child: Container(
                  //color: Colors.white,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(
                            20.0) //                 <--- border radius here
                        ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                          // height: 10,
                          ),
                      Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * .71,
                          height: MediaQuery.of(context).size.height * .085,
                          child: new TextFormField(
                            autofocus: false,
                            controller: _controllers[index],
                            focusNode: _FocusNode1[index],
                            style: TextStyle(
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFFa5a5a5),
                                fontSize: 12),
                            cursorColor: const Color(0xFFa5a5a5),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: const Color(0xFFa5a5a5))),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFFa5a5a5)),
                                ),
                                border: UnderlineInputBorder(),
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                    color: _FocusNode1[index].hasFocus
                                        ? const Color(0xFFa5a5a5)
                                        : const Color(0xFFa5a5a5))),
                          ),
                        ),
                      ),
                      SizedBox(
                          //height: MediaQuery.of(context).size.height * .013,
                          ),
                      Container(
                        width: MediaQuery.of(context).size.width * .71,
                        height: MediaQuery.of(context).size.height * .085,
                        child: new TextFormField(
                          maxLength: 10,
                          autofocus: false,
                          controller: _controllers1[index],
                          focusNode: _FocusNode2[index],
                          style: TextStyle(
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFa5a5a5),
                              fontSize: 12),
                          cursorColor: const Color(0xFFa5a5a5),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              counterText: '',
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xFFa5a5a5))),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: const Color(0xFFa5a5a5)),
                              ),
                              fillColor: Colors.white,
                              border: UnderlineInputBorder(),
                              labelText: 'Mobile No',
                              labelStyle: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: _FocusNode2[index].hasFocus
                                      ? const Color(0xFFa5a5a5)
                                      : const Color(0xFFa5a5a5))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    var amount = (int.parse(widget.eventAmount) * (_count + 1) * 100);
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': amount,
      'name': 'Total Amount',
      // 'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(
        "=============HANDLE PAYMENT START========================================================");
    _register(context);
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName,
        toastLength: Toast.LENGTH_SHORT);
  }
}
