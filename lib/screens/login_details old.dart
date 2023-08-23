import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/FlatResponseModel.dart';
import 'package:ihms/models/SocietyResponseModel.dart';
import 'package:ihms/models/TowerResponseModel.dart';
import 'package:ihms/models/StaticPageResponseModel.dart';
import 'package:ihms/screens/otp_screen.dart';
import 'package:ihms/utils.dart';

class LoginDetails extends StatefulWidget {
  @override
  _LoginDetailsState createState() => _LoginDetailsState();
}

class _LoginDetailsState extends State<LoginDetails> {
  SocietyResponseModel societyResponseModel;
  List<SocietData> societyList;
  List<TowerData> towerList;
  List<FlatData> flatList;
  Future _loadSocieties;
  Future _loadStaticPages;
  int _radiovalue;
  int _radiovaluegender;
  int type = 1;

  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController annicontroller = TextEditingController();
  TextEditingController emailTextFiled = TextEditingController();
  String initValue = "Select your Birth Date";
  bool isDateSelected = false;
  DateTime birthDate; // instance of DateTime
  String birthDateInString;
  String birthDateInString1;
  StaticPageResponseModel staticPageResponseModel;
  var _currentDate = DateTime.now();

  loadevents() {
    setState(() {
      _loadSocieties = getSociety();
      // _loadStaticPages = staticpage();
      staticpage().then((value) {
        staticPageResponseModel = value;
        // socialModel.data[0].facebook
        print(
            '---------staticPageResponseModeltc----------${staticPageResponseModel.data[0].tC}');
      });
    });
  }

  // loadevents() {
  //   setState(() {
  //     socialurl().then((value) {
  //       socialModel = value;
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     });
  //   });
  // }
  String getDayOfMonthSuffix(int dayNum) {
    if (!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if (dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch (dayNum % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  _register(BuildContext context) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailTextFiled.text);
    if (emailValid == false) {
      showToast("This Should be in email Format");
    } else if (emailTextFiled.text.trim().isEmpty) {
      showToast("Email Filed Empty");
    } else if (nameController.text.trim() == '') {
      showToast(
        'Enter Name ',
      );
    } else if (mobileController.text.trim() == '' ||
        mobileController.text.length < 10) {
      showToast(
        'Enter Valid Mobile Number',
      );
    }
    // else if (birthDateInString == null) {
    //   showToast(
    //     'Enter DOB',
    //   );
    // }
    else if (dropdownvalueForSociety == 'Select Society & Location') {
      showToast(
        'Select Society',
      );
    } else if (dropdownvalueForTower == 'Select Tower') {
      showToast(
        'Select Tower',
      );
    } else if (dropdownvalueForFlaat == 'Select Flat no') {
      showToast(
        'Select flat',
      );
    } else if (_radiovaluegender == null) {
      showToast(
        'Select Gender',
      );
    } else if (_radiovalue == null) {
      showToast(
        'Select Type',
      );
    } else if (isChecked == false) {
      showToast(
        'Check I agree to the terms and condition ',
      );
    } else {
      print("=============New Society===================");
      print(
        societyList[items.indexOf(dropdownvalueForSociety) - 1].id.toString(),
      );
      sendotp(mobileController.text, type, context).then((value) {
        if (value == "true") {
          Timer(Duration(seconds: 2), () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Otp_screen(
                    nameController.text,
                    emailTextFiled.text,
                    mobileController.text,
                    _radiovalue.toString(),
                    _radiovaluegender,
                    birthDateInString,
                    birthDateInString1,
                    societyList[items.indexOf(dropdownvalueForSociety) - 1]
                        .id
                        .toString(),
                    towerList[toweritems.indexOf(dropdownvalueForTower) - 1]
                        .id
                        .toString(),
                    flatList[flatitems.indexOf(dropdownvalueForFlaat) - 1]
                        .id
                        .toString(),
                    type)));
          });
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    loadevents();
    super.initState();
  }

  bool _load = false;
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();
  FocusNode myFocusNode2 = new FocusNode();
  FocusNode myFocusNode3 = new FocusNode();
  FocusNode myFocusNode4 = new FocusNode();
  bool isChecked = false;

  String dropdownvalueForSociety = 'Select Society & Location';
  String dropdownvalueForTower = 'Select Tower';
  String dropdownvalueForFlaat = 'Select Flat no';
  int selectedSocietyIndex = 30;
  int selectedTowerIndex = 30;
  int selectedFlatIndex = 30;
  var items = [
    'Select Society & Location',
  ];
  var toweritems = ['Select Tower'];
  var flatitems = ['Select Flat no'];
  bool _loading = false;

  void _onLoading() {
    setState(() {
      _loading = true;
      new Future.delayed(new Duration(seconds: 3), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = _load
        ? new Container(
            color: Colors.grey[300],
            width: 70.0,
            height: 70.0,
            child: new Padding(
                padding: const EdgeInsets.all(5.0),
                child: new Center(child: new CircularProgressIndicator())),
          )
        : new Container();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SafeArea(
            child: SingleChildScrollView(
              // physics: const NeverScrollableScrollPhysics(),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    //color: const Color(0xFFf5d892),
                    //color: Colors.amber,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1.1,
                      clipBehavior: Clip.hardEdge,
                      //color: Colors.white,
                      decoration: new BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //     bottomLeft: Radius.circular(35),
                        //     bottomRight: Radius.circular(35)),
                        image: new DecorationImage(
                          image: ExactAssetImage('assets/images/login.png'),
                          fit: BoxFit.fill,
                        ),
                      )),
                  Container(
                      // height: 174,
                      height: MediaQuery.of(context).size.height * .16,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.white,
                      decoration: new BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //     bottomLeft: Radius.circular(35),
                        //     bottomRight: Radius.circular(35)),
                        image: new DecorationImage(
                          image: ExactAssetImage("assets/images/k.png"),
                          fit: BoxFit.fill,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.29,
                          MediaQuery.of(context).size.width * .07,
                          0,
                          0),
                      //height: 45,
                      height: MediaQuery.of(context).size.height * .05,
                      // width: 165,
                      width: MediaQuery.of(context).size.width * .4,
                      //color: Colors.white,
                      decoration: new BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //     bottomLeft: Radius.circular(35),
                        //     bottomRight: Radius.circular(35)),
                        image: new DecorationImage(
                          image:
                              ExactAssetImage('assets/images/logo copy 3.png'),
                          fit: BoxFit.fill,
                        ),
                      )),
                  FutureBuilder(
                      future: _loadSocieties,
                      builder: (context, snapshot) {
                        items = [];
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.height * 0.00,
                                  MediaQuery.of(context).size.height * 0.46,
                                  MediaQuery.of(context).size.height * 0.00,
                                  MediaQuery.of(context).size.height * 0.00,
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 5,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          print(societyResponseModel = snapshot?.data);
                          societyList = societyResponseModel?.data;
                          items.add("Select Society & Location");
                          for (var each in societyList) {
                            items.add(each.name);
                          }

                          return Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 20,
                                      top: MediaQuery.of(context).size.height *
                                          .12,
                                      right: 20,
                                      bottom: 35,
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      // margin: EdgeInsets.fromLTRB(
                                      //   20,
                                      //   MediaQuery.of(context).size.height * .16,
                                      //   0,
                                      //   MediaQuery.of(context).size.height * .2,
                                      // ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 40,
                                            right: 40,
                                            top: 15,
                                            bottom: 30),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Let's Get Started!",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      const Color(0xFFb38b3c),
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .005,
                                            ),
                                            Text(
                                              "Create an account with IHMS to get all features.",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color:
                                                      const Color(0xFFa3906b),
                                                  fontFamily: "Source Sans Pro",
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .71,
                                              height: 12,
                                              child: DropdownButton(
                                                isExpanded: true,
                                                iconSize: 15,
                                                underline: Container(
                                                    child: Column(
                                                  children: [
                                                    Text(
                                                      "",
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xFFa5a5a5),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                                value: dropdownvalueForSociety,
                                                icon: Icon(
                                                    Icons.keyboard_arrow_down),
                                                items:
                                                    items.map((String items) {
                                                  return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(
                                                        items,
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: const Color(
                                                              0xFFa5a5a5),
                                                        ),
                                                      ));
                                                }).toList(),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    dropdownvalueForSociety =
                                                        newValue;
                                                    getTower(societyList[
                                                                items.indexOf(
                                                                        dropdownvalueForSociety) -
                                                                    1]
                                                            .id
                                                            .toString())
                                                        .then((value) {
                                                      if (value.length > 0)
                                                        towerList = value;
                                                      toweritems = [
                                                        'Select Tower'
                                                      ];
                                                      setState(() {
                                                        for (var each
                                                            in towerList) {
                                                          toweritems
                                                              .add(each.name);
                                                        }
                                                      });
                                                    });

                                                    dropdownvalueForTower =
                                                        'Select Tower';
                                                    dropdownvalueForFlaat =
                                                        'Select Flat no';
                                                  });
                                                },
                                              ),
                                            ),
                                            SizedBox(height: 25),
                                            FittedBox(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .34,
                                                    height: 12,
                                                    // height:MediaQuery.of(context).size.width * .05 ,
                                                    child: DropdownButton(
                                                      isExpanded: true,
                                                      iconSize: 15,
                                                      underline: Container(
                                                          child: Column(
                                                        children: [
                                                          Text(
                                                            "",
                                                            style: TextStyle(
                                                              color: const Color(
                                                                  0xFFa5a5a5),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                      value:
                                                          dropdownvalueForTower,
                                                      icon: Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items: toweritems
                                                          .map((String tower) {
                                                        return DropdownMenuItem(
                                                            value: tower,
                                                            child: Text(
                                                              tower,
                                                              style: TextStyle(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: const Color(
                                                                    0xFFa5a5a5),
                                                              ),
                                                            ));
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        if (dropdownvalueForFlaat !=
                                                            'Select Flat no') {
                                                          setState(() {
                                                            dropdownvalueForFlaat =
                                                                'Select Flat no';
                                                          });
                                                        }
                                                        dropdownvalueForTower =
                                                            newValue.toString();
                                                        setState(() {
                                                          getFlat(
                                                                  societyList[
                                                                          items.indexOf(dropdownvalueForSociety) -
                                                                              1]
                                                                      .id
                                                                      .toString(),
                                                                  towerList[
                                                                          toweritems.indexOf(dropdownvalueForTower) -
                                                                              1]
                                                                      .id
                                                                      .toString())
                                                              .then((value) {
                                                            if (value.length >
                                                                0)
                                                              flatList = value;
                                                            flatitems = [
                                                              'Select Flat no'
                                                            ];
                                                            setState(() {
                                                              for (var each
                                                                  in flatList) {
                                                                flatitems.add(
                                                                    each.name);
                                                              }
                                                            });
                                                          });
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  Container(
                                                    // margin: EdgeInsets.fromLTRB(
                                                    //     MediaQuery.of(context).size.height * .250,
                                                    //     MediaQuery.of(context).size.height * .329,
                                                    //     0,
                                                    //     0),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .34,
                                                    height: 12,
                                                    child: DropdownButton(
                                                      isExpanded: true,
                                                      iconSize: 15,
                                                      underline: Container(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 100),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              "",
                                                              style: TextStyle(
                                                                color: const Color(
                                                                    0xFFa5a5a5),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                      value:
                                                          dropdownvalueForFlaat,
                                                      icon: Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items: flatitems
                                                          .map((String flats) {
                                                        return DropdownMenuItem(
                                                            value: flats,
                                                            child: Text(
                                                              flats,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 11,
                                                                color: const Color(
                                                                    0xFFa5a5a5),
                                                              ),
                                                            ));
                                                      }).toList(),
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          dropdownvalueForFlaat =
                                                              newValue
                                                                  .toString();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .71,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .070,
                                              child: new TextFormField(
                                                controller: nameController,
                                                focusNode: myFocusNode2,
                                                style: TextStyle(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xFFa5a5a5),
                                                    fontSize: 12),
                                                cursorColor:
                                                    const Color(0xFFa5a5a5),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                    fillColor: Colors.white,
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: const Color(
                                                                0xFFa5a5a5))),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xFFa5a5a5)),
                                                    ),
                                                    border:
                                                        UnderlineInputBorder(),
                                                    labelText: 'Name',
                                                    labelStyle: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: myFocusNode2
                                                                .hasFocus
                                                            ? const Color(
                                                                0xFFa5a5a5)
                                                            : const Color(
                                                                0xFFa5a5a5))),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .71,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .070,
                                              child: new TextFormField(
                                                controller: emailTextFiled,
                                                focusNode: myFocusNode1,
                                                style: TextStyle(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xFFa5a5a5),
                                                    fontSize: 12),
                                                cursorColor:
                                                    const Color(0xFFa5a5a5),
                                                // inputFormatters: [
                                                //   new LengthLimitingTextInputFormatter(10),
                                                // ],
                                                keyboardType:
                                                    TextInputType.text,

                                                decoration: InputDecoration(
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: const Color(
                                                                0xFFa5a5a5))),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: const Color(
                                                              0xFFa5a5a5)),
                                                    ),
                                                    fillColor: Colors.white,
                                                    border:
                                                        UnderlineInputBorder(),
                                                    labelText: 'Email ID',
                                                    labelStyle: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: myFocusNode1
                                                                .hasFocus
                                                            ? const Color(
                                                                0xFFa5a5a5)
                                                            : const Color(
                                                                0xFFa5a5a5))),
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .71,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .070,
                                              child: new TextFormField(
                                                controller: mobileController,
                                                maxLength: 10,
                                                focusNode: myFocusNode,
                                                style: TextStyle(
                                                    height: 1.5,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xFFa5a5a5),
                                                    fontSize: 12),
                                                cursorColor:
                                                    const Color(0xFFa5a5a5),
                                                // inputFormatters: [
                                                //   new LengthLimitingTextInputFormatter(10),
                                                // ],
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                    counterText: '',
                                                    enabledBorder: UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: const Color(
                                                                0xFFa5a5a5))),
                                                    focusedBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: const Color(
                                                              0xFFa5a5a5)),
                                                    ),
                                                    fillColor: Colors.white,
                                                    border:
                                                        UnderlineInputBorder(),
                                                    labelText: 'Mobile Number',
                                                    labelStyle: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: myFocusNode
                                                                .hasFocus
                                                            ? const Color(
                                                                0xFFa5a5a5)
                                                            : const Color(
                                                                0xFFa5a5a5))),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              child: Column(
                                                children: [
                                                  FittedBox(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            "We will send you a One Time Password on this Mobile Number",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: const Color(
                                                                    0xFFa5a5a5)),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .010,
                                            ),
                                            FittedBox(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .65,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .055,
                                                    child: new TextFormField(
                                                      controller: dobcontroller,
                                                      autovalidateMode:
                                                          AutovalidateMode
                                                              .disabled,
                                                      enabled: false,
                                                      autofocus: false,
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: const Color(
                                                              0xFFa5a5a5),
                                                          fontSize: 12),
                                                      cursorColor: const Color(
                                                          0xFFa5a5a5),
                                                      // inputFormatters: [
                                                      //   new LengthLimitingTextInputFormatter(10),
                                                      // ],
                                                      decoration:
                                                          InputDecoration(
                                                              counterText: '',
                                                              enabledBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: const Color(
                                                                          0xFFa5a5a5))),
                                                              focusedBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: const Color(
                                                                        0xFFa5a5a5)),
                                                              ),
                                                              fillColor:
                                                                  Colors.white,
                                                              border:
                                                                  UnderlineInputBorder(),
                                                              hintText: '',
                                                              labelText:
                                                                  birthDateInString ==
                                                                          null
                                                                      ? "Dob"
                                                                      : '$birthDateInString',
                                                              labelStyle: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: myFocusNode
                                                                          .hasFocus
                                                                      ? const Color(
                                                                          0xFFa5a5a5)
                                                                      : const Color(
                                                                          0xFFa5a5a5))),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                      child: new Icon(
                                                          Icons.calendar_today),
                                                      onTap: () async {
                                                        myFocusNode3.unfocus();

                                                        final datePick =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    new DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    new DateTime(
                                                                        1900),
                                                                //lastDate: new DateTime(2100));
                                                                lastDate:
                                                                    new DateTime
                                                                        .now());
                                                        if (datePick != null &&
                                                            datePick !=
                                                                birthDate) {
                                                          setState(() {
                                                            birthDate =
                                                                datePick;
                                                            List months = [
                                                              'January',
                                                              'February',
                                                              'March',
                                                              'April',
                                                              'May',
                                                              'June',
                                                              'July',
                                                              'August',
                                                              'September',
                                                              'October',
                                                              'November',
                                                              'December'
                                                            ];
                                                            var current_mon =
                                                                birthDate.month;

                                                            isDateSelected =
                                                                true;
                                                            birthDateInString =
                                                                "${birthDate.day}${getDayOfMonthSuffix(birthDate.day)} ${months[current_mon - 1]} ${birthDate.year}";
                                                          });
                                                          print(
                                                              birthDateInString);
                                                        }
                                                      })
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .010,
                                            ),
                                            FittedBox(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .65,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .055,
                                                    child: new TextFormField(
                                                      controller:
                                                          annicontroller,
                                                      enabled: false,
                                                      focusNode: myFocusNode4,
                                                      style: TextStyle(
                                                          height: 1.5,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: const Color(
                                                              0xFFa5a5a5),
                                                          fontSize: 12),
                                                      cursorColor: const Color(
                                                          0xFFa5a5a5),
                                                      // inputFormatters: [
                                                      //   new LengthLimitingTextInputFormatter(10),
                                                      // ],
                                                      decoration:
                                                          InputDecoration(
                                                              counterText: '',
                                                              enabledBorder: UnderlineInputBorder(
                                                                  borderSide: BorderSide(
                                                                      color: const Color(
                                                                          0xFFa5a5a5))),
                                                              focusedBorder:
                                                                  UnderlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: const Color(
                                                                        0xFFa5a5a5)),
                                                              ),
                                                              fillColor:
                                                                  Colors.white,
                                                              border:
                                                                  UnderlineInputBorder(),
                                                              labelText: birthDateInString1 ==
                                                                      null
                                                                  ? "Anniversary"
                                                                  : '$birthDateInString1',
                                                              labelStyle: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: myFocusNode
                                                                          .hasFocus
                                                                      ? const Color(
                                                                          0xFFa5a5a5)
                                                                      : const Color(
                                                                          0xFFa5a5a5))),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                      child: new Icon(
                                                          Icons.calendar_today),
                                                      onTap: () async {
                                                        myFocusNode4.unfocus();
                                                        final datePick =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    new DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    new DateTime(
                                                                        1900),
                                                                //lastDate: new DateTime(2100));
                                                                lastDate:
                                                                    new DateTime
                                                                        .now());
                                                        if (datePick != null &&
                                                            datePick !=
                                                                birthDate) {
                                                          setState(() {
                                                            List months = [
                                                              'January',
                                                              'February',
                                                              'March',
                                                              'April',
                                                              'May',
                                                              'June',
                                                              'July',
                                                              'August',
                                                              'September',
                                                              'October',
                                                              'November',
                                                              'December'
                                                            ];
                                                            var current_mon =
                                                                birthDate.month;
                                                            birthDate =
                                                                datePick;
                                                            isDateSelected =
                                                                true;
                                                            birthDateInString1 =
                                                                "${birthDate.day}${getDayOfMonthSuffix(birthDate.day)} ${months[current_mon - 1]} ${birthDate.year}";
                                                          });
                                                          print(
                                                              birthDateInString1);
                                                        }
                                                      })
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .020,
                                            ),
                                            Text(
                                              "Gender",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFFa5a5a5),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 35,
                                                  width: 20,
                                                  child: Radio(
                                                      activeColor: const Color(
                                                          0xFFa5a5a5),
                                                      value: 0,
                                                      groupValue:
                                                          _radiovaluegender,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _radiovaluegender =
                                                              value;
                                                        });
                                                      }),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text("Male",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xFFa5a5a5))),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Container(
                                                  height: 35,
                                                  width: 20,
                                                  child: Radio(
                                                      activeColor: const Color(
                                                          0xFFa5a5a5),
                                                      value: 1,
                                                      groupValue:
                                                          _radiovaluegender,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _radiovaluegender =
                                                              value;
                                                        });
                                                      }),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Female",
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xFFa5a5a5),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "Type",
                                              style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFFa5a5a5),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 35,
                                                  width: 20,
                                                  child: Radio(
                                                      activeColor: const Color(
                                                          0xFFa5a5a5),
                                                      value: 0,
                                                      groupValue: _radiovalue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _radiovalue = value;
                                                          print(_radiovalue);
                                                        });
                                                      }),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text("Tenant",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xFFa5a5a5))),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Container(
                                                  height: 35,
                                                  width: 20,
                                                  child: Radio(
                                                      activeColor: const Color(
                                                          0xFFa5a5a5),
                                                      value: 1,
                                                      groupValue: _radiovalue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _radiovalue = value;
                                                        });
                                                      }),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text("Owner",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xFFa5a5a5))),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Container(
                                                  height: 35,
                                                  width: 20,
                                                  child: Radio(
                                                      activeColor: const Color(
                                                          0xFFa5a5a5),
                                                      value: 2,
                                                      groupValue: _radiovalue,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _radiovalue = value;
                                                        });
                                                      }),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text("Other",
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: const Color(
                                                            0xFFa5a5a5)))
                                              ],
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .013,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  height: 24,
                                                  width: 24,
                                                  child: Container(
                                                    child: Transform.scale(
                                                      scale: 0.9,
                                                      child: Checkbox(
                                                        activeColor:
                                                            const Color(
                                                                0xFF9a7712),
                                                        value: isChecked,
                                                        onChanged:
                                                            (bool value) {
                                                          setState(() {
                                                            isChecked = value;
                                                            print(isChecked);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Container(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "I agree to the",
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: const Color(
                                                                  0xFF9e9e9e),
                                                              fontFamily:
                                                                  "Source Sans Pro",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Alertbox_terms();
                                                        },
                                                        child: Container(
                                                          child: Text(
                                                            " Terms",
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: const Color(
                                                                    0xFFa18634),
                                                                fontFamily:
                                                                    "Source Sans Pro",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                          " &",
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              color: const Color(
                                                                  0xFF9e9e9e),
                                                              fontFamily:
                                                                  "Source Sans Pro",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Alertbox_terms();
                                                        },
                                                        child: Container(
                                                          child: Text(
                                                            " Conditions",
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: const Color(
                                                                    0xFFa18634),
                                                                fontFamily:
                                                                    "Source Sans Pro",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 25,
                                              // height: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Already have an account?",
                                          style: TextStyle(
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 10.0,
                                                  color: Colors.black,
                                                  offset: Offset(-3.0, 3.0),
                                                ),
                                              ],
                                              fontSize: 13,
                                              color: const Color(0xFFffffff),
                                              fontFamily: "Source Sans Pro",
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      FittedBox(
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)),
                                          ),
                                          child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    'loginRegistration');
                                              },
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 2,
                                                      bottom: 2),
                                                  child: Text(
                                                    "Sign in",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: const Color(
                                                            0xFFebb428),
                                                        fontFamily:
                                                            "Source Sans Pro",
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // SizedBox(width: 30,),
                              Positioned(
                                // bottom: -15,
                                bottom: -42,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 300.0),
                                            child: Container(
                                              // margin: EdgeInsets.fromLTRB(
                                              //   0,
                                              //   MediaQuery.of(context).size.height * .79,
                                              //   0,
                                              //   0,
                                              // ),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .2,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .2,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      const Color(0xFF8f7020),
                                                      const Color(0xFFb78a1a),
                                                    ],
                                                  ),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 7,
                                                  )),
                                              child: InkWell(
                                                child: new IconButton(
                                                  icon: new Icon(
                                                    Icons
                                                        .arrow_right_alt_outlined,
                                                    size: 40,
                                                  ),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    _register(context);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      }),
                  new Align(
                    child: loadingIndicator,
                    alignment: FractionalOffset.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Alertbox_terms() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              // overflow: Overflow.visible,
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  padding: EdgeInsets.all(5),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('''Use of ihmsclubs.com''',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('''${staticPageResponseModel.data[0].tC}''',
                          style: TextStyle(
                            fontSize: 15,
                          )),
//                           Text('''Use of ihmsclubs.com''',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold)),
//                       Text('''This site is owned and operated by Innovest Hospitality Management Services Pet Ltd By using ihmsclubs.com you agree to be legally bound by these terms, which shall take effect immediately on your first use of ihmsclubs.com If you do not agree to be legally bound by all the following terms please do not access and/or use ihmsclubs.com.

// No material from the site may be copied, reproduced, republished, uploaded, posed, transmitted, or distributed in any way, except that you may download one copy of the materials on any single computer for your non-commercial use only, provided that you keep intact all copyright and other proprietary notices. Modification of the materials or use of the materials for any other purpose is a violation of ihmsclubs.com. copyright and other proprietary rights. The use of any such material on any other web site or networked computer environment is prohibited. Except as otherwise indicated on this site and except for the trademarks, service marks and trade names of other companies that are displayed on this site, all trademarks, service marks and trade names are property of ihmsclubs.com.

// ihmsclubs.com. may change these terms at any time by posting changes online. Please review these terms regularly to ensure you are aware of any changes made by  ihmsclubs.com.

// Your continued use of  ihmsclubs.com. after changes are posted means you agree to be legally bound by these terms as updated and amended.

// In the event that you download any software from this, or any accompanying site, the software, including any files, images incorporated in or generated by the software, and data accompanying the software (collectively, the “Software”) are non-exclusively licensed to you by  ihmsclubs.com.''',
//                           style: TextStyle(
//                             fontSize: 15,
//                           )),
//                       Text('''Delivery Times.''',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold)),
//                       Text(
//                           '''Our aim is to meet a delivery window for our customers, agreed at the time of placing the order. Whilst we will do our utmost to meet this delivery time unfortunately there may be factors beyond our control that prevent us from meeting the time slot.

// We shall have no liability whatsoever for any delay or failure to deliver to you where such delay or failure is caused by a circumstance beyond our reasonable control. Such circumstances include, but are not limited to;
// • Unforeseen Traffic Delays
// • Accidents Causing Delays on the Service Route
// • Severe Weather Conditions.

// ''',
//                           style: TextStyle(
//                             fontSize: 15,
//                           )),
                      // Text('''Your Order Confirmation''',
                      //     style: TextStyle(
                      //         fontSize: 18, fontWeight: FontWeight.bold)),
//                       Text(
//                           '''Your Order Confirmation is a record of our agreement to deliver the products ordered and paid for in full. If someone else made the booking on your behalf, you agree that such person acted as your agent.

// Amendments to Orders

// Amendments to the order or delivery time can be made no later than 1 hour prior to the start of the delivery window booked.Amendments to the content of your order can be made up to 1 Hour before the delivery window begins.

// Amendments to the order must be made by phoning the Restaurant.

// The delivery time slot may be altered up to 1 hour before the start of your order window. The order can only be changed to a new time slot if it is available.

// ''',
//                           style: TextStyle(
//                             fontSize: 15,
//                           )),
                      // Text('''Customer Responsibilities''',
                      //     style: TextStyle(
                      //         fontSize: 18, fontWeight: FontWeight.bold)),
//                       Text(
//                           '''It is the customer responsibility to enter the delivery address in full to ensure the driver may locate the correct property for delivery. Failure to deliver due to incorrect address details will be charged in full.

// You must ensure that delivery can be made to the address during the selected window. If we are unable to make delivery at the given address in the selected time slot then we will deem the order cancelled at full cost.

// No rescheduling of time will be permitted.

// In the case of addresses that are irregular or difficult to locate, it is the responsibility of the customer to clearly mark special delivery instructions in the box required (Notes) Failure to do so may result in a delayed delivery, or the order being cancelled by ihmsclubs.com.

// ''',
//                           style: TextStyle(
//                             fontSize: 15,
//                           )),
//                       Text('''Trade marks and Copyright''',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold)),
//                       Text(
//                           '''The content and software on this site may be used as either or both an information and shopping resource. Any other use including reproduction, modification, distribution, transmission or republication of the content of this service is strictly prohibited. Amendments and Waivers to these terms and conditions

// None of our employees, agents, or representatives, has authority to alter, modify or waive any provision of these Conditions of order.

// Complaints or feedback: In the event that you are dissatisfied with the quality of any Products or the service provided by Restaurant, please consider providing feedback in the form of ratings, comments and reviews on the Website (together, “Reviews”) to reflect your experience. The Reviews are an important part of our quality control process.

// Estimated times for deliveries and collections are provided by the Restaurants and are only estimates. the Restaurant can not guarantee that Orders will be delivered or will be available for collection within the estimated times.

// By ordering from ihmsclubs.com. you accept the above terms and conditions.''',
//                           style: TextStyle(
//                             fontSize: 15,
//                           )),
                    ],
                  )),
                ),
                Positioned(
                  top: -40,
                  right: -35,
                  child: CircleAvatar(
                    child: Icon(Icons.close),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFFa18634),
                  ),
                )
              ],
            ),
          );
        });
  }
}
