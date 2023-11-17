import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/FlatResponseModel.dart';
import 'package:ihms/models/SocietyResponseModel.dart';
import 'package:ihms/models/TowerResponseModel.dart';
import 'package:ihms/models/UserProfileResponseModel.dart';
import 'package:ihms/screens/tabbar.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  SocietyResponseModel societyResponseModel;
  List<SocietData> societyList;
  List<TowerData> towerList;
  List<FlatData> flatList;
  Future _loadSocieties;

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobcontroller = TextEditingController();
  final TextEditingController anniversarycontroller = TextEditingController();

  UserProfileResponseModel userProfileResponseModel;

  Future _loadevents;
  Future _loadUserDetails;

  loadevents() {
    _loadSocieties = getSociety();
    _loadUserDetails = userProfile();

    setState(() {
      userProfile().then((value) {
        userProfileResponseModel = value;
        setState(() {});
      });
      _loadSocieties = getSociety();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadevents();
    super.initState();
  }

  bool _load = false;
  String dropdownvalueForSociety = 'Select Society & Location';
  String dropdownvalueForTower = 'Select Tower';
  String dropdownvalueForFlat = 'Select Flat no';
  var items = [
    'Select Society & Location',
  ];
  var toweritems = ['Select Tower'];
  var flatitems = ['Select Flat no'];

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
              FutureBuilder(
                  future: _loadSocieties,
                  builder: (context, snapshot) {
                    items = [];

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
                      if (userProfileResponseModel != null) {
                        nameController.text =
                            userProfileResponseModel.data.name;
                        mobileController.text =
                            userProfileResponseModel.data.mobile;
                        emailController.text =
                            userProfileResponseModel.data.email;
                        dobcontroller.text = userProfileResponseModel.data.dob;
                        anniversarycontroller.text =
                            userProfileResponseModel.data.anniversary;
                      }
                      societyList = societyResponseModel.data;
                      items.add("Select Society & Location");
                      for (var each in societyList) {
                        items.add(each.name);
                        if (each.id.toString() ==
                            userProfileResponseModel.data.society) {
                          dropdownvalueForSociety = each.name;
                        }
                      }
                      getTower(societyList[
                                  items.indexOf(dropdownvalueForSociety) - 1]
                              .id
                              .toString())
                          .then((value) {
                        if (value.length > 0) towerList = value;
                        toweritems = ['Select Tower'];

                        for (var each in towerList) {
                          toweritems.add(each.name);

                          if (each.id.toString() ==
                              userProfileResponseModel.data.towerNumber) {
                            dropdownvalueForTower = each.name;

                            setState(() {});
                          }
                        }

                        getFlat(
                                societyList[
                                        items.indexOf(dropdownvalueForSociety) -
                                            1]
                                    .id
                                    .toString(),
                                towerList[toweritems
                                            .indexOf(dropdownvalueForTower) -
                                        1]
                                    .id
                                    .toString())
                            .then((value) {
                          if (value.length > 0) flatList = value;
                          flatitems = ['Select Flat no'];

                          for (var each in flatList) {
                            flatitems.add(each.name);
                            if (each.id.toString() ==
                                userProfileResponseModel.data.flatNumber) {
                              dropdownvalueForFlat = each.name;

                              setState(() {});
                            }
                          }
                        });
                      });

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
                                width: MediaQuery.of(context).size.width * .71,
                                padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                child: Text(
                                  dropdownvalueForSociety,
                                  style: TextStyle(
                                    color: const Color(0xFFa5a5a5),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                    width:
                                        MediaQuery.of(context).size.width * .34,
                                    child: Text(
                                      dropdownvalueForTower,
                                      style: TextStyle(
                                        color: const Color(0xFFa5a5a5),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 13),
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 10, 10, 10),
                                      width: MediaQuery.of(context).size.width *
                                          .34,
                                      child: Text(
                                        dropdownvalueForFlat,
                                        style: TextStyle(
                                          color: const Color(0xFFa5a5a5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      counterText: '',
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xFFa5a5a5)),
                                      ),
                                      fillColor: Colors.white,
                                      border: UnderlineInputBorder(),
                                      labelText: 'Anniversarysdad',
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
                  onTap: () {},
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
