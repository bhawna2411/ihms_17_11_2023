import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/FlatResponseModel.dart';
import 'package:ihms/models/SocietyResponseModel.dart';
import 'package:ihms/models/TowerResponseModel.dart';
import 'package:ihms/models/UserProfileResponseModel.dart';
import 'package:ihms/screens/tabbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreenCopy extends StatefulWidget {
  @override
  _AccountScreenCopyState createState() => _AccountScreenCopyState();
}

class _AccountScreenCopyState extends State<AccountScreenCopy> {
  SocietyResponseModel societyResponseModel;
  List<SocietData> societyList;
  List<TowerData> towerList;
  List<FlatData> flatList;
  Future _loadSocieties;
  final TextEditingController societyController = TextEditingController();
  final TextEditingController towerController = TextEditingController();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobcontroller = TextEditingController();
  final TextEditingController anniversarycontroller = TextEditingController();

  UserProfileResponseModel userProfileResponseModel =
      UserProfileResponseModel();
  bool isLoading = false;
  Future _loadevents;
  // Future _loadUserDetails;
  _editRequest(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    print("====== USER ID ====== + $userId");
    if (nameController.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter name"),
      ));
    } else if (emailController.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter email"),
      ));
    } else if (mobileController.text.trim() == '' ||
        mobileController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter valid mobile number"),
      ));
    } else if (dobcontroller.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter dob"),
      ));
    } else if (anniversarycontroller.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter anniversary"),
      ));
    } else {
      setState(() {
        isLoading = true;
      });

      editProfile(
        societyList[items.indexOf(dropdownvalueForSociety) - 1].id.toString(),
        towerList[toweritems.indexOf(dropdownvalueForTower) - 1].id.toString(),
        flatList[flatitems.indexOf(dropdownvalueForFlat) - 1].id.toString(),
        nameController.text,
        emailController.text,
        mobileController.text,
        dobcontroller.text,
        anniversarycontroller.text,
        userId,
       societyList[items.indexOf(dropdownvalueForSociety) - 1].name.toString(),
        context,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    loadevents();
    super.initState();
  }

  bool _load = false;
  // FocusNode myFocusNode = new FocusNode();
  // FocusNode myFocusNode1 = new FocusNode();
  // FocusNode myFocusNode2 = new FocusNode();
  // FocusNode myFocusNode3 = new FocusNode();

  String dropdownvalueForSociety = 'Select Society & Location';
  String dropdownvalueForTower = 'Select Tower';
  String dropdownvalueForFlat = 'Select Flat no';

  // int selectedSocietyIndex = 30;
  // int selectedTowerIndex = 30;
  // int selectedFlatIndex = 30;
  var items = [
    'Select Society & Location',
  ];
  var societyItems = [
    'Select Society & Location',
  ];
  var toweritems = ['Select Tower'];
  var flatitems = ['Select Flat no'];
  // bool _loading = false;

  loadevents() {
    _loadSocieties = getSociety();

    // _loadUserDetails = userProfile();

    userProfile().then((value) {
      userProfileResponseModel = value;
      print("OBJECT ${value.data.name}");
      if (userProfileResponseModel != null) {
        nameController.text = userProfileResponseModel.data.name;
        mobileController.text = userProfileResponseModel.data.mobile;
        emailController.text = userProfileResponseModel.data.email;
        dobcontroller.text = userProfileResponseModel.data.dob;
        anniversarycontroller.text = userProfileResponseModel.data.anniversary;

        print("+++++++++++++++++++++++++++++++++++++++++++++++");

        print(userProfileResponseModel.data);
      }
      setState(() {});
    });

    Timer(Duration(seconds: 2), () {
      getSociety().then((value) {
        societyList = value.data;
        items = [];
        items.add("Select Society & Location");
        print('----------------societyList-----------------$societyList');
        for (var each in societyList) {
          items.add(each.name);
          if (each.id.toString() == userProfileResponseModel.data.society) {
            print("------ society  ${each.name}");
            setState(() {
              dropdownvalueForSociety = each.name;
              print("------ dropdownvalueForSociety  $dropdownvalueForSociety");
            });
          }
        }

        getTower(societyList[items.indexOf(dropdownvalueForSociety) - 1]
                .id
                .toString())
            .then((value) {
          if (value.length > 0) towerList = value;
          toweritems = ['Select Tower'];
          for (var each in towerList) {
            toweritems.add(each.name);
            // print("**********************************");
            // print(each.id.toString());
            // print(userProfileResponseModel.data.towerNumber);
            // print(toweritems);
            if (each.id.toString() ==
                userProfileResponseModel.data.towerNumber) {
              print("------ tower  ${each.name}");
              setState(() {
                dropdownvalueForTower = each.name;
              });
            }
          }

          getFlat(
                  societyList[items.indexOf(dropdownvalueForSociety) - 1]
                      .id
                      .toString(),
                  towerList[toweritems.indexOf(dropdownvalueForTower) - 1]
                      .id
                      .toString())
              .then((value) {
            if (value.length > 0) flatList = value;
            flatitems = ['Select Flat no'];

            for (var each in flatList) {
              flatitems.add(each.name);
              if (each.id.toString() ==
                  userProfileResponseModel.data.flatNumber) {
                print("-------- flat ${each.name}");
                setState(() {
                  dropdownvalueForFlat = each.name;
                });
              }
            }
          });
        });
      });
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          // FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Stack(
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
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.00,
                    MediaQuery.of(context).size.height * 0.06,
                    MediaQuery.of(context).size.height * 0.00,
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Text(
                    "USER PROFILE",
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
              ),
              // Card(
              //   margin: EdgeInsets.fromLTRB(
              //       MediaQuery.of(context).size.width * .065,
              //       MediaQuery.of(context).size.width * .45,
              //       0,
              //       0),
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(30.0),
              //   ),
              //   elevation: 5,
              //   child: Container(
              //     //height: 502,
              //     //width: 358,
              //     //color: Colors.white,
              //     width: MediaQuery.of(context).size.width * .87,
              //     height: MediaQuery.of(context).size.height * .68,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.all(Radius.circular(40)),
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              FutureBuilder(
                  future: _loadSocieties,
                  builder: (context, snapshot) {
                    societyItems = [];
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.height * 0.00,
                              MediaQuery.of(context).size.height * 0.5,
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
                      print(
                          "============================profile screen++++++++++++++++++++++++");

                      print(dobcontroller.text);

                      print(societyResponseModel = snapshot.data);

                      print(societyResponseModel = snapshot.data);
                      societyList = societyResponseModel.data;
                      societyItems.add("Select Society & Location");
                      // print(
                      //     '----------------societyList-----------------$societyList');
                      for (var each in societyList) {
                        societyItems.add(each.name);
                        // if (each.id.toString() ==
                        //     userProfileResponseModel.data.society) {
                        //   dropdownvalueForSociety = each.name;
                        // }
                      }
                      // getTower(societyList[
                      //             items.indexOf(dropdownvalueForSociety) - 1]
                      //         .id
                      //         .toString())
                      //     .then((value) {
                      //   if (value.length > 0) towerList = value;
                      //   toweritems = ['Select Tower'];
                      //   for (var each in towerList) {
                      //     toweritems.add(each.name);
                      //     // print("**********************************");
                      //     // print(each.id.toString());
                      //     // print(userProfileResponseModel.data.towerNumber);
                      //     // print(toweritems);
                      //     if (each.id.toString() ==
                      //         userProfileResponseModel.data.towerNumber) {
                      //       print("------  ${each.name}");
                      //       // setState(() {
                      //       dropdownvalueForTower = each.name;
                      //       // });
                      //     }
                      //   }

                      //   // dropdownvalueForTower = toweritems[int.parse(
                      //   //     userProfileResponseModel.data.towerNumber)];

                      //   getFlat(
                      //           societyList[
                      //                   items.indexOf(dropdownvalueForSociety) -
                      //                       1]
                      //               .id
                      //               .toString(),
                      //           towerList[toweritems
                      //                       .indexOf(dropdownvalueForTower) -
                      //                   1]
                      //               .id
                      //               .toString())
                      //       .then((value) {
                      //     if (value.length > 0) flatList = value;
                      //     flatitems = ['Select Flat no'];

                      //     for (var each in flatList) {
                      //       flatitems.add(each.name);
                      //       if (each.id.toString() ==
                      //           userProfileResponseModel.data.flatNumber) {
                      //         print("-------- flat ${each.name}");
                      //         // setState(() {
                      //         dropdownvalueForFlat = each.name;
                      //         // });
                      //       }
                      //     }

                      //     // dropdownvalueForFlat = flatitems[int.parse(
                      //     //     userProfileResponseModel.data.flatNumber)];
                      //   });
                      // });

                      return Container(
                        margin: EdgeInsets.fromLTRB(20,
                            MediaQuery.of(context).size.height * .25, 20, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Profile Details",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: const Color(0xFFb38b3c),
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .005,
                              ),
                              Text(
                                "Edit and manage your account details.",
                                style: TextStyle(
                                    fontSize: 11,
                                    color: const Color(0xFFa3906b),
                                    fontFamily: "Source Sans Pro",
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .009,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .74,
                                padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                child: DropdownButton(
                                  isExpanded: true,
                                  iconSize: 15,
                                  underline: Container(
                                      child: Column(
                                    children: [
                                      Text(
                                        "",
                                        style: TextStyle(
                                          color: const Color(0xFFa5a5a5),
                                        ),
                                      )
                                    ],
                                  )),
                                  value: dropdownvalueForSociety,
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFFa5a5a5),
                                          ),
                                        ));
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      dropdownvalueForSociety = newValue;
                                      print(
                                          '--------------dropdownvalueForSociety--------------$dropdownvalueForSociety');
                                      getTower(societyList[items.indexOf(
                                                      dropdownvalueForSociety) -
                                                  1]
                                              .id
                                              .toString())
                                          .then((value) {
                                        if (value.length > 0) towerList = value;
                                        toweritems = ['Select Tower'];
                                        setState(() {
                                          for (var each in towerList) {
                                            toweritems.add(each.name);
                                          }
                                          print(
                                              "toweritems -------   $toweritems");
                                        });
                                      });

                                      dropdownvalueForTower = 'Select Tower';
                                      dropdownvalueForFlat = 'Select Flat no';
                                    });
                                  },
                                ),
                                // DropdownButton(
                                //   isExpanded: true,
                                //   iconSize: 15,
                                //   underline: Container(
                                //       child: Column(
                                //     children: [
                                //       Text(
                                //         "",
                                //         style: TextStyle(
                                //           color: const Color(0xFFa5a5a5),
                                //         ),
                                //       )
                                //     ],
                                //   )),
                                //   value: dropdownvalueForSociety,
                                //   icon: Icon(Icons.keyboard_arrow_down),
                                //   items: items.map((String items) {
                                //     return DropdownMenuItem(
                                //         value: items,
                                //         child: Text(
                                //           items,
                                //           style: TextStyle(
                                //             fontSize: 11,
                                //             fontWeight: FontWeight.w500,
                                //             color: const Color(0xFFa5a5a5),
                                //           ),
                                //         ));
                                //   }).toList(),
                                //   onChanged: (newValue) {
                                //     // setState(() {
                                //     //   dropdownvalueForSociety = newValue;
                                //     //   getTower(societyList[items.indexOf(
                                //     //                   dropdownvalueForSociety) -
                                //     //               1]
                                //     //           .id
                                //     //           .toString())
                                //     //       .then((value) {
                                //     //     if (value.length > 0)
                                //     //       towerList = value;
                                //     //     toweritems = ['Select Tower'];
                                //     //     setState(() {
                                //     //       for (var each in towerList) {
                                //     //         toweritems.add(each.name);
                                //     //       }
                                //     //     });
                                //     //   });
                                //     //   dropdownvalueForFlat = 'Select Flat no';
                                //     // });
                                //   },
                                // ),
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
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
                                                color: const Color(0xFFa5a5a5),
                                              ),
                                            )
                                          ],
                                        )),
                                        value: dropdownvalueForTower,
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        items: toweritems.map((String tower) {
                                          return DropdownMenuItem(
                                              value: tower,
                                              child: Text(
                                                tower,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      const Color(0xFFa5a5a5),
                                                ),
                                              ));
                                        }).toList(),
                                        onChanged: (newValue) {
                                          if (dropdownvalueForFlat !=
                                              'Select Flat no') {
                                            setState(() {
                                              dropdownvalueForFlat =
                                                  'Select Flat no';
                                            });
                                          }
                                          dropdownvalueForTower = newValue;
                                          setState(() {
                                            getFlat(
                                                    societyList[items.indexOf(
                                                                dropdownvalueForSociety) -
                                                            1]
                                                        .id
                                                        .toString(),
                                                    towerList[toweritems.indexOf(
                                                                dropdownvalueForTower) -
                                                            1]
                                                        .id
                                                        .toString())
                                                .then((value) {
                                              if (value.length > 0)
                                                flatList = value;
                                              flatitems = ['Select Flat no'];
                                              setState(() {
                                                for (var each in flatList) {
                                                  flatitems.add(each.name);
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
                                      width: MediaQuery.of(context).size.width *
                                          .34,
                                      height: 12,
                                      child: DropdownButton(
                                        isExpanded: true,
                                        iconSize: 15,
                                        underline: Container(
                                            child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 100),
                                          child: Column(
                                            children: [
                                              Text(
                                                "",
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFFa5a5a5),
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                        value: dropdownvalueForFlat,
                                        icon: Icon(Icons.keyboard_arrow_down),
                                        items: flatitems.map((String flats) {
                                          return DropdownMenuItem(
                                              value: flats,
                                              child: Text(
                                                flats,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11,
                                                  color:
                                                      const Color(0xFFa5a5a5),
                                                ),
                                              ));
                                        }).toList(),
                                        onChanged: (newValue) {
                                          setState(() {
                                            dropdownvalueForFlat =
                                                newValue.toString();
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
                                width: MediaQuery.of(context).size.width * .71,
                                height:
                                    MediaQuery.of(context).size.height * .078,
                                child: new TextFormField(
                                  // enabled: false,
                                  controller: nameController,
                                  // focusNode: myFocusNode2,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      // enabledBorder: UnderlineInputBorder(
                                      //     borderSide: BorderSide(
                                      //         color: const Color(0xFFa5a5a5))),
                                      // focusedBorder: UnderlineInputBorder(
                                      //   borderSide: BorderSide(
                                      //       color: Color(0xFFa5a5a5)),
                                      // ),
                                      // border: UnderlineInputBorder(),
                                      labelText: 'Name',
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          // color: myFocusNode2.hasFocus
                                          //     ? const Color(0xFFa5a5a5)
                                          //     : const Color(0xFFa5a5a5))),
                                          color: const Color(0xFFa5a5a5))),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .013,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .71,
                                height:
                                    MediaQuery.of(context).size.height * .077,
                                child: new TextFormField(
                                  enabled: false,
                                  controller: emailController,
                                  // focusNode: myFocusNode1,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  // inputFormatters: [
                                  //   new LengthLimitingTextInputFormatter(10),
                                  // ],
                                  keyboardType: TextInputType.text,

                                  decoration: InputDecoration(
                                      // enabledBorder: UnderlineInputBorder(
                                      //     borderSide: BorderSide(
                                      //         color: const Color(0xFFa5a5a5))),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFFa5a5a5)),
                                      ),
                                      fillColor: Colors.white,
                                      border: UnderlineInputBorder(),
                                      labelText: 'Email ID',
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          // color: myFocusNode1.hasFocus
                                          //     ? const Color(0xFFa5a5a5)
                                          //     : const Color(0xFFa5a5a5))),
                                          color: const Color(0xFFa5a5a5))),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .013,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .71,
                                height:
                                    MediaQuery.of(context).size.height * .077,
                                child: new TextFormField(
                                  enabled: false,
                                  controller: mobileController,
                                  maxLength: 10,
                                  // focusNode: myFocusNode,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  // inputFormatters: [
                                  //   new LengthLimitingTextInputFormatter(10),
                                  // ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      // enabledBorder: UnderlineInputBorder(
                                      //     borderSide: BorderSide(
                                      //         color: const Color(0xFFa5a5a5))),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFFa5a5a5)),
                                      ),
                                      fillColor: Colors.white,
                                      border: UnderlineInputBorder(),
                                      labelText: 'Mobile Number',
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          // color: myFocusNode.hasFocus
                                          //     ? const Color(0xFFa5a5a5)
                                          //     : const Color(0xFFa5a5a5))),
                                          color: const Color(0xFFa5a5a5))),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .013,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .71,
                                height:
                                    MediaQuery.of(context).size.height * .077,
                                child: new TextFormField(
                                  controller: dobcontroller,
                                  // focusNode: myFocusNode3,
                                  enabled: false,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  // inputFormatters: [
                                  //   new LengthLimitingTextInputFormatter(10),
                                  // ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      // enabledBorder: UnderlineInputBorder(
                                      //     borderSide: BorderSide(
                                      //         color: const Color(0xFFa5a5a5))),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFFa5a5a5)),
                                      ),
                                      fillColor: Colors.white,
                                      border: UnderlineInputBorder(),
                                      labelText: 'DOB',
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          // color: myFocusNode.hasFocus
                                          //     ? const Color(0xFFa5a5a5)
                                          //     : const Color(0xFFa5a5a5))),
                                          color: const Color(0xFFa5a5a5))),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .013,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .71,
                                height:
                                    MediaQuery.of(context).size.height * .077,
                                child: new TextFormField(
                                  // enabled: false,
                                  controller: anniversarycontroller,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  // inputFormatters: [
                                  //   new LengthLimitingTextInputFormatter(10),
                                  // ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      // enabledBorder: UnderlineInputBorder(
                                      //     borderSide: BorderSide(
                                      //         color: const Color(0xFFa5a5a5))),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFFa5a5a5)),
                                      ),
                                      fillColor: Colors.white,
                                      border: UnderlineInputBorder(),
                                      labelText: 'Anniversary',
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFa5a5a5))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
              Positioned(
                left: 150,
                bottom: 50,
                child: InkWell(
                  onTap: () {
                    print("click.....................");
                    _editRequest(context);
                  },
                  child: Center(
                    child: Container(
                      width: 80,
                      height: 80,
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
                      child: Icon(
                        Icons.arrow_right_alt_outlined,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   // margin: EdgeInsets.fromLTRB(
              //   //     MediaQuery.of(context).size.height * .250,
              //   //     MediaQuery.of(context).size.height * .365,
              //   //     0,
              //   //     0),
              //   width: MediaQuery.of(context).size.width * .34,
              //   child: DropdownButton(
              //     isExpanded: true,
              //     iconSize: 15,
              //     underline: Container(
              //         child: Padding(
              //       padding: const EdgeInsets.only(top: 100),
              //       child: Column(
              //         children: [
              //           Text(
              //             "",
              //             style: TextStyle(
              //               color: const Color(0xFFa5a5a5),
              //             ),
              //           )
              //         ],
              //       ),
              //     )),
              //     value: dropdownvalueForFlat,
              //     icon: Icon(Icons.keyboard_arrow_down),
              //     items: flatitems.map((String flats) {
              //       return DropdownMenuItem(
              //           value: flats,
              //           child: Text(
              //             flats,
              //             style: TextStyle(
              //               fontWeight: FontWeight.w500,
              //               fontSize: 11,
              //               color: const Color(0xFFa5a5a5),
              //             ),
              //           ));
              //     }).toList(),
              //     onChanged: (newValue) {
              //       setState(() {
              //         dropdownvalueForFlat = newValue.toString();
              //       });
              //     },
              //   ),
              // ),

              // new Align(
              //   child: loadingIndicator,
              //   alignment: FractionalOffset.center,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
