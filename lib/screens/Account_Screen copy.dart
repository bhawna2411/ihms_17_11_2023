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
  final TextEditingController professionController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController areaOfInterestController =
      TextEditingController();

  String _radiovaluegender;
  int _radiovalueIhmsmembership;

  UserProfileResponseModel userProfileResponseModel =
      UserProfileResponseModel();
  bool isLoading = false;
  Future _loadevents;
  // Future _loadUserDetails;

  _editRequest(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    if (nameController.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter name"),
      ));
    }
    //
    else if (towerController.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter Tower"),
      ));
    } else if (flatController.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter Flat"),
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
    } else {
      setState(() {
        isLoading = true;
      });
      editProfile(
        societyList[items.indexOf(dropdownvalueForSociety) - 1].id.toString(),
        towerController.text,
        flatController.text,
        nameController.text,
        emailController.text,
        mobileController.text,
        dobcontroller.text,
        anniversarycontroller.text,
        userId,
        societyList[items.indexOf(dropdownvalueForSociety) - 1].name.toString(),
        professionController.text,
        _radiovaluegender,
        educationController.text,
        areaOfInterestController.text,
        _radiovalueIhmsmembership,
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
  String dropdownvalueForSociety = 'Select Club Location or Site Location';
  String dropdownvalueForTower = 'Select Tower';
  String dropdownvalueForFlat = 'Select Flat no';
  var items = [
    'Select Club Location or Site Location',
  ];
  var societyItems = [
    'Select Club Location or Site Location',
  ];
  var toweritems = ['Select Tower'];
  var flatitems = ['Select Flat no'];
  loadevents() {
    _loadSocieties = getSociety();

    userProfile().then((value) {
      userProfileResponseModel = value;
      if (userProfileResponseModel != null) {
        nameController.text = userProfileResponseModel.data.name;
        // societyController.text = userProfileResponseModel.data.society;
        towerController.text = userProfileResponseModel.data.towerNumber;
        flatController.text = userProfileResponseModel.data.flatNumber;
        mobileController.text = userProfileResponseModel.data.mobile;
        emailController.text = userProfileResponseModel.data.email;
        dobcontroller.text = userProfileResponseModel.data.dob;
        anniversarycontroller.text = userProfileResponseModel.data.anniversary;
        _radiovaluegender = userProfileResponseModel.data.gender;
        professionController.text = userProfileResponseModel.data.profession;
        educationController.text = userProfileResponseModel.data.education;
        areaOfInterestController.text =
            userProfileResponseModel.data.areaOfInterest;
        _radiovalueIhmsmembership =
            userProfileResponseModel.data.ihmsMembership;
      }
      setState(() {});
    });

    Timer(Duration(seconds: 2), () {
      getSociety().then((value) {
        societyList = value.data;
        items = [];
        items.add("Select Club Location or Site Location");
        for (var each in societyList) {
          items.add(each.name);
          if (each.id.toString() == userProfileResponseModel.data.society) {
            setState(() {
              dropdownvalueForSociety = each.name;
              societyController.text = each.name;
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
            if (each.id.toString() ==
                userProfileResponseModel.data.towerNumber) {
              setState(() {
                dropdownvalueForTower = each.name;
                towerController.text = each.name;
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
                setState(() {
                  dropdownvalueForFlat = each.name;
                  flatController.text = each.name;
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
        onTap: () {},
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.9,
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
                height: MediaQuery.of(context).size.height * 1.15,
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
                    MediaQuery.of(context).size.height * 0.06,
                    MediaQuery.of(context).size.height * 0.00,
                    MediaQuery.of(context).size.height * 0.00,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: new IconButton(
                          icon: new Icon(
                            Icons.arrow_back,
                            size: 20,
                          ),
                          color: Color(0xFF203040),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Tabbar()));
                          },
                        ),
                      ),
                      Text(
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
                      InkWell(
                        child: new IconButton(
                          icon: new Icon(
                            Icons.arrow_back,
                            size: 20,
                          ),
                          color: Colors.transparent,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )),
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
                      societyResponseModel = snapshot.data;
                      societyList = societyResponseModel?.data;
                      societyItems.add("Select Club Location or Site Location");
                      if (societyList != null) {
                        for (var each in societyList) {
                          societyItems.add(each.name);
                        }
                      }
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
                                padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
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
                                    onChanged: null),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .35,
                                    child: new TextFormField(
                                      controller: towerController,
                                      style: TextStyle(
                                          height: 1.5,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFa5a5a5),
                                          fontSize: 12),
                                      cursorColor: const Color(0xFFa5a5a5),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFa5a5a5)),
                                          ),
                                          border: UnderlineInputBorder(),
                                          labelText: 'Your Address Line 1',
                                          labelStyle: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFFa5a5a5))),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .34,
                                    child: new TextFormField(
                                      controller: flatController,
                                      style: TextStyle(
                                          height: 1.5,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFa5a5a5),
                                          fontSize: 12),
                                      cursorColor: const Color(0xFFa5a5a5),
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xFFa5a5a5)),
                                          ),
                                          border: UnderlineInputBorder(),
                                          labelText: 'Your Address Line 2',
                                          labelStyle: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFFa5a5a5))),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .71,
                                height:
                                    MediaQuery.of(context).size.height * .078,
                                child: new TextFormField(
                                  controller: nameController,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFa5a5a5)),
                                      ),
                                      border: UnderlineInputBorder(),
                                      labelText: 'Name',
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
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
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
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
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      counterText: '',
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
                                  enabled: false,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      counterText: '',
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
                                  controller: anniversarycontroller,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      counterText: '',
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
                              Container(
                                width: MediaQuery.of(context).size.width * .71,
                                height:
                                    MediaQuery.of(context).size.height * .078,
                                child: new TextFormField(
                                  controller: professionController,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFa5a5a5)),
                                      ),
                                      border: UnderlineInputBorder(),
                                      labelText: 'Profession',
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFa5a5a5))),
                                ),
                              ),
                              SizedBox(height: 10),
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
                                        activeColor: const Color(0xFFa5a5a5),
                                        value: "Male",
                                        groupValue: _radiovaluegender,
                                        onChanged: (value) {
                                          setState(() {
                                            _radiovaluegender = value;
                                          });
                                        }),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Male",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFa5a5a5))),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 20,
                                    child: Radio(
                                        activeColor: const Color(0xFFa5a5a5),
                                        value: "Female",
                                        groupValue: _radiovaluegender,
                                        onChanged: (value) {
                                          setState(() {
                                            _radiovaluegender = value;
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
                                      color: const Color(0xFFa5a5a5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .71,
                                height:
                                    MediaQuery.of(context).size.height * .078,
                                child: new TextFormField(
                                  controller: educationController,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFa5a5a5)),
                                      ),
                                      border: UnderlineInputBorder(),
                                      labelText: 'Education',
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFa5a5a5))),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .71,
                                height:
                                    MediaQuery.of(context).size.height * .078,
                                child: new TextFormField(
                                  controller: areaOfInterestController,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                      fontSize: 12),
                                  cursorColor: const Color(0xFFa5a5a5),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFFa5a5a5)),
                                      ),
                                      border: UnderlineInputBorder(),
                                      labelText: 'Area of interest',
                                      labelStyle: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFa5a5a5))),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "IHMS Membership",
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
                                        activeColor: const Color(0xFFa5a5a5),
                                        value: 1,
                                        groupValue: _radiovalueIhmsmembership,
                                        onChanged: (value) {
                                          setState(() {
                                            _radiovalueIhmsmembership = value;
                                          });
                                        }),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Interested",
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFa5a5a5))),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Container(
                                    height: 35,
                                    width: 20,
                                    child: Radio(
                                        activeColor: const Color(0xFFa5a5a5),
                                        value: 0,
                                        groupValue: _radiovalueIhmsmembership,
                                        onChanged: (value) {
                                          setState(() {
                                            _radiovalueIhmsmembership = value;
                                          });
                                        }),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Not Interested",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFFa5a5a5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
              Positioned(
                // left: 170,
                left: MediaQuery.of(context).size.width * 0.4,
                // bottom: 50,
                bottom: MediaQuery.of(context).size.height * 0.098,
                child: InkWell(
                  onTap: () {
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
            ],
          ),
        ),
      ),
    );
  }
}
