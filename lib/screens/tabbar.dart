import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/SocialModel.dart';
import 'package:ihms/models/UserProfileResponseModel.dart';
import 'package:ihms/screens/Feedback_Screen.dart';
import 'package:ihms/screens/LoginRegistration.dart';
import 'package:ihms/screens/WhatsNew_Screen.dart';
import 'package:ihms/screens/about_screen.dart';
import 'package:ihms/screens/clubs.dart';
import 'package:ihms/screens/dashboard_screen.dart';
import 'package:ihms/screens/event.dart';
import 'package:ihms/screens/event_history_screen.dart';
import 'package:ihms/screens/privacy_policy_screen.dart';
import 'package:ihms/screens/terms_and_condition_screen.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flutter/cupertino.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'Account_Screen copy.dart';
import 'Services.dart';
import 'package:intl/intl.dart';

enum AppState {
  free,
  picked,
  cropped,
}

class Tabbar extends StatefulWidget {
  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  SocialModel socialModel;
  UserProfileResponseModel userProfileResponseModel;
  Future _loadevents;
  String text = '';
  String subject = '';
  List<String> imagePaths = [];
  // ignore: unused_field
  bool _isLoading = false;
  bool err = false;
  String msgErr = '';

  PickedFile _image;

  String base64Image;
  AppState state;
  File imageFile;
  File cameraFile;
  String profileImage;
  bool isLoading = true;
  // ignore: unused_field
  String _platformVersion = 'Unknown';

  loadevents() {
    _loadevents = userProfile();
    setState(() {
      socialurl().then((value) {
        socialModel = value;
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state = AppState.free;
    loadevents();
    socialurl();
  }

  whatsAppOpen() async {
    var whatsapp = "+918882212941";
    var whatsappURl_android =
        "https://api.whatsapp.com/send?phone=918882212941";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));
      }
    } else {
      await launch(whatsappURl_android);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool bottomTabbar = true;
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        DashboardScreen(),
        ServicesScreen(bottomTabbar),
        EventScreen(bottomTabbar),
        WhatsNewScreen(),
        clubs_screen(bottomTabbar),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "assets/images/home.png",
            alignment: Alignment.bottomCenter,
            fit: BoxFit.fill,
          ),
          title: ("HOME"),
          textStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
          activeColorPrimary: CupertinoColors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "assets/images/services.png",
            alignment: Alignment.bottomCenter,
            fit: BoxFit.fill,
          ),
          title: ("CONCIERGE"),
          textStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
          activeColorPrimary: CupertinoColors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "assets/images/event.png",
            alignment: Alignment.bottomCenter,
            fit: BoxFit.cover,
          ),
          // title: ("EVENTS/TICKETS"),
          title: ("ALL EVENTS"),
          textStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
          activeColorSecondary: Colors.black,
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "assets/images/account.png",
            alignment: Alignment.bottomCenter,
            fit: BoxFit.fill,
          ),
          title: ("WHAT'S NEW"),
          textStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
          activeColorPrimary: CupertinoColors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Image.asset(
            "assets/images/club.png",
            alignment: Alignment.bottomCenter,
            fit: BoxFit.fill,
          ),
          title: ("CLUBS"),
          textStyle: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
          ),
          activeColorPrimary: CupertinoColors.black,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    return Scaffold(
      drawer: FutureBuilder(
          future: _loadevents,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Column(children: [
                      SizedBox(
                        height: 200.0,
                        child: new DrawerHeader(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300 //Color(0xFFbb8d1d),
                              ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (state == AppState.free) {
                                    _showPicker();
                                  } else if (state == AppState.picked)
                                    _cropImage();
                                  else if (state == AppState.cropped)
                                    _clearImage();
                                },
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 3, color: Colors.grey.shade500),
                                    image: userProfileResponseModel.data != null
                                        ? DecorationImage(
                                            image: userProfileResponseModel
                                                        .data.image ==
                                                    ""
                                                ? imageFile != null
                                                    ? FileImage(imageFile)
                                                    : AssetImage(
                                                        "assets/images/profile.png")
                                                : NetworkImage(
                                                    userProfileResponseModel
                                                        .data.image),
                                            fit: BoxFit.fill,
                                          )
                                        : Container(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 32,
                                    width: 74,
                                    margin: EdgeInsets.only(right: 94),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/logo copy 3.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      "",
                                      // userProfileResponseModel.data.name,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.sourceSansPro(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 23,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      "",
                                      // userProfileResponseModel.data.email,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.sourceSansPro(
                                        textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Image.asset(
                                "assets/images/home.png",
                                height: 22,
                                width: 22,
                              ),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              title: Align(
                                child: Text(
                                  "Home",
                                  style: GoogleFonts.sourceSansPro(
                                    textStyle: TextStyle(
                                      color: Color(0xFF555555),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                alignment: Alignment(-1.2, 0),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                            Divider(
                              indent: 20,
                              endIndent: 20,
                              height: 1,
                            ),
                            ListTile(
                              leading: Image.asset(
                                "assets/images/about.png",
                                height: 22,
                                width: 22,
                              ),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              title: Align(
                                child: Text(
                                  "About IHMS",
                                  style: GoogleFonts.sourceSansPro(
                                    textStyle: TextStyle(
                                      color: Color(0xFF555555),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                alignment: Alignment(-1.3, 0),
                              ),
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => about_screen()));
                              },
                            ),
                            Divider(
                              indent: 20,
                              endIndent: 20,
                              height: 1,
                            ),
                            ListTile(
                              leading: Image.asset(
                                "assets/images/services.png",
                                height: 22,
                                width: 22,
                              ),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              title: Align(
                                child: Text(
                                  "Concierge Services",
                                  style: GoogleFonts.sourceSansPro(
                                    textStyle: TextStyle(
                                      color: Color(0xFF555555),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                alignment: Alignment(-1.2, 0),
                              ),
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ServicesScreen(!bottomTabbar)));
                              },
                            ),
                            Divider(
                              indent: 20,
                              endIndent: 20,
                              height: 1,
                            ),
                            ListTile(
                              leading: Image.asset(
                                "assets/images/club.png",
                                height: 22,
                                width: 22,
                              ),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              title: Align(
                                child: Text(
                                  "Clubs",
                                  style: GoogleFonts.sourceSansPro(
                                    textStyle: TextStyle(
                                      color: Color(0xFF555555),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                alignment: Alignment(-1.2, 0),
                              ),
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            clubs_screen(!bottomTabbar)));
                              },
                            ),
                            Divider(
                              indent: 20,
                              endIndent: 20,
                              height: 1,
                            ),
                            ListTile(
                              leading: Icon(Icons.calendar_today,
                                  color: Color(0xFFc0a155)),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              title: Text(
                                "My Bookings",
                                style: GoogleFonts.sourceSansPro(
                                  textStyle: TextStyle(
                                    color: Color(0xFF555555),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EventHistoryScreen()));
                              },
                            ),
                            Divider(
                              indent: 20,
                              endIndent: 20,
                              height: 1,
                            ),
                            ListTile(
                              leading: Icon(Icons.calendar_today,
                                  color: Color(0xFFc0a155)),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              title: Text(
                                // "Events/Tickets",
                                "All Event",
                                style: GoogleFonts.sourceSansPro(
                                  textStyle: TextStyle(
                                    color: Color(0xFF555555),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EventScreen(!bottomTabbar)));
                              },
                            ),
                            Divider(
                              indent: 20,
                              endIndent: 20,
                              height: 1,
                            ),
                            ListTile(
                              leading: Icon(Icons.feedback,
                                  color: Color(0xFFc0a155)),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              title: Text(
                                "Suggestion/Feedback",
                                style: GoogleFonts.sourceSansPro(
                                  textStyle: TextStyle(
                                    color: Color(0xFF555555),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FeedbackScreen()));
                              },
                            ),
                            Divider(
                              indent: 20,
                              endIndent: 20,
                              height: 1,
                            ),
                            ListTile(
                              leading: Image.asset(
                                "assets/images/logout.png",
                                height: 22,
                                width: 22,
                              ),
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              title: Align(
                                child: Text(
                                  "Logout",
                                  style: GoogleFonts.sourceSansPro(
                                    textStyle: TextStyle(
                                      color: Color(0xFF555555),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                alignment: Alignment(-1.2, 0),
                              ),
                              onTap: () async {
                                SharedPreferences sp =
                                    await SharedPreferences.getInstance();
                                var gender = sp.getString('gender');
                                var society = sp
                                    .getString('society')
                                    .replaceAll(' ', '_');
                                var dob;
                                if (sp.getString('dob') != "") {
                                  if (sp.getString('dob').contains('/')) {
                                    var dataa = DateFormat('MM/dd/yyyy')
                                        .parse(sp.getString('dob'));
                                    var aa =
                                        Jiffy(dataa).format('do MMMM yyyy');
                                    dob = aa.replaceAll(' ', '_');
                                  } else {
                                    dob = sp
                                        .getString('dob')
                                        .replaceAll(' ', '_');
                                  }
                                } else {
                                  dob = "1st_January_2023";
                                }
                                var firebaseMessaging =
                                    FirebaseMessaging.instance;
                                firebaseMessaging.unsubscribeFromTopic(
                                    gender == null || gender == ""
                                        ? "Male"
                                        : gender);
                                firebaseMessaging.unsubscribeFromTopic(society);
                                firebaseMessaging.unsubscribeFromTopic(dob);

                                sp.clear();

                                Navigator.of(context, rootNavigator: true)
                                    .pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoginRegistration()),
                                );
                              },
                            ),
                            Divider(
                              indent: 20,
                              endIndent: 20,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0xFFf5d993),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                child: Text(
                              "Connect with us",
                              style: GoogleFonts.sourceSansPro(
                                textStyle: TextStyle(
                                  color: Color(0xFF000000),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            )),
                            GestureDetector(
                              onTap: () {},
                              child: Image(
                                width: MediaQuery.of(context).size.width * 0.10,
                                image: AssetImage("assets/images/facebook.png"),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                const url = 'https://twitter.com';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              },
                              child: Image(
                                width: MediaQuery.of(context).size.width * 0.10,
                                image:
                                    AssetImage("assets/images/instagram.png"),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // ignore: unnecessary_statements
                                socialModel.data[0].youtube;
                              },
                              child: Image(
                                width: MediaQuery.of(context).size.width * 0.10,
                                image: AssetImage("assets/images/youtube.png"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              );
            } else {
              if (snapshot.connectionState == ConnectionState.waiting) {
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
                userProfileResponseModel = snapshot.data;

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.80,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.white,
                      child: Column(children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: new DrawerHeader(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300 //Color(0xFFbb8d1d),
                                ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (state == AppState.free) {
                                      _showPicker();
                                    } else if (state == AppState.picked)
                                      _cropImage();
                                    else if (state == AppState.cropped)
                                      _clearImage();
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 3,
                                          color: Colors.grey.shade500),
                                      image: DecorationImage(
                                          image: imageFile != null
                                              ? FileImage(imageFile)
                                              : userProfileResponseModel
                                                          .data.image ==
                                                      ""
                                                  ? AssetImage(
                                                      "assets/images/profile.png")
                                                  : NetworkImage(
                                                      userProfileResponseModel
                                                          .data.image),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 38,
                                      width: 140,
                                      margin: EdgeInsets.only(right: 94),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/logo copy 3.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        userProfileResponseModel.data.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.sourceSansPro(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 23,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Container(
                                      width: 200,
                                      child: Text(
                                        userProfileResponseModel.data.email,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.sourceSansPro(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    //   SizedBox(
                                    //   height:
                                    //       MediaQuery.of(context).size.height *
                                    //           0.01,
                                    // ),
                                    Container(
                                      width: 250,
                                      child: Row(
                                        children: [
                                          Text(
                                            "UID - ",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.sourceSansPro(
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            userProfileResponseModel.data.uid,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.sourceSansPro(
                                              textStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Image.asset(
                                    "assets/images/home.png",
                                    height: 22,
                                    width: 22,
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  title: Text("Home",
                                      style: GoogleFonts.sourceSansPro(
                                        textStyle: TextStyle(
                                          color: Color(0xFF555555),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      )),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 1,
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    "assets/images/about.png",
                                    height: 22,
                                    width: 22,
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  title: Text("About IHMS",
                                      style: GoogleFonts.sourceSansPro(
                                        textStyle: TextStyle(
                                          color: Color(0xFF555555),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      )),
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                about_screen()));
                                  },
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 1,
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    "assets/images/services.png",
                                    height: 22,
                                    width: 22,
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  title: Text("Concierge Services",
                                      style: GoogleFonts.sourceSansPro(
                                        textStyle: TextStyle(
                                          color: Color(0xFF555555),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      )),
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                ServicesScreen(!bottomTabbar)));
                                  },
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 1,
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    "assets/images/club.png",
                                    height: 22,
                                    width: 22,
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  title: Text(
                                    "Clubs",
                                    style: GoogleFonts.sourceSansPro(
                                      textStyle: TextStyle(
                                        color: Color(0xFF555555),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                clubs_screen(!bottomTabbar)));
                                  },
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 1,
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    "assets/images/account.png",
                                    height: 22,
                                    width: 22,
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  title: Text(
                                    "Profile",
                                    style: GoogleFonts.sourceSansPro(
                                      textStyle: TextStyle(
                                        color: Color(0xFF555555),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                AccountScreenCopy()));
                                  },
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 1,
                                ),
                                ListTile(
                                  leading: Icon(Icons.calendar_today,
                                      color: Color(0xFFc0a155)),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  title: Text(
                                    "All Events",
                                    style: GoogleFonts.sourceSansPro(
                                      textStyle: TextStyle(
                                        color: Color(0xFF555555),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                EventScreen(!bottomTabbar)));
                                  },
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 1,
                                ),
                                ListTile(
                                  leading: Icon(Icons.calendar_today,
                                      color: Color(0xFFc0a155)),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  title: Text(
                                    "My Bookings",
                                    style: GoogleFonts.sourceSansPro(
                                      textStyle: TextStyle(
                                        color: Color(0xFF555555),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                EventHistoryScreen()));
                                  },
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 1,
                                ),
                                ListTile(
                                  leading: Icon(Icons.feedback_outlined,
                                      color: Color(0xFFc0a155)),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  title: Text(
                                    "Suggestion/Feedback",
                                    style: GoogleFonts.sourceSansPro(
                                      textStyle: TextStyle(
                                        color: Color(0xFF555555),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                FeedbackScreen()));
                                  },
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 1,
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    "assets/images/about.png",
                                    height: 22,
                                    width: 22,
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  title: Text("Privacy Policy",
                                      style: GoogleFonts.sourceSansPro(
                                        textStyle: TextStyle(
                                          color: Color(0xFF555555),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      )),
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                PrivacyPolicyScreen()));
                                  },
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 1,
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    "assets/images/about.png",
                                    height: 22,
                                    width: 22,
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  title: Text("Terms and conditions",
                                      style: GoogleFonts.sourceSansPro(
                                        textStyle: TextStyle(
                                          color: Color(0xFF555555),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                        ),
                                      )),
                                  onTap: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                TermsAndConditionScreen()));
                                  },
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 1,
                                ),
                                ListTile(
                                  leading: Image.asset(
                                    "assets/images/logout.png",
                                    height: 22,
                                    width: 22,
                                  ),
                                  dense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  title: Text(
                                    "Logout",
                                    style: GoogleFonts.sourceSansPro(
                                      textStyle: TextStyle(
                                        color: Color(0xFF555555),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    SharedPreferences sp =
                                        await SharedPreferences.getInstance();
                                    var gender = sp.getString('gender');
                                    var society = sp
                                        .getString('society')
                                        .replaceAll(' ', '_');
                                    var dob;
                                    if (sp.getString('dob') != "") {
                                      if (sp.getString('dob').contains('/')) {
                                        var dataa = DateFormat('MM/dd/yyyy')
                                            .parse(sp.getString('dob'));
                                        var aa =
                                            Jiffy(dataa).format('do MMMM yyyy');
                                        dob = aa.replaceAll(' ', '_');
                                      } else {
                                        dob = sp
                                            .getString('dob')
                                            .replaceAll(' ', '_');
                                      }
                                    } else {
                                      dob = "1st_January_2023";
                                    }

                                    var firebaseMessaging =
                                        FirebaseMessaging.instance;
                                    firebaseMessaging.unsubscribeFromTopic(
                                        gender == null || gender == ""
                                            ? "Male"
                                            : gender);
                                    firebaseMessaging
                                        .unsubscribeFromTopic(society);
                                    firebaseMessaging.unsubscribeFromTopic(dob);

                                    sp.clear();

                                    Navigator.of(context, rootNavigator: true)
                                        .pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginRegistration()),
                                    );
                                  },
                                ),
                                Divider(
                                  indent: 20,
                                  endIndent: 20,
                                  height: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _onShare(context);
                              },
                              child: Container(
                                  height: 30,
                                  width: 75,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(
                                          color: Colors.black, width: 0.3)),
                                  child: Center(
                                      child: Text(
                                    "Share App",
                                    style: TextStyle(fontSize: 12),
                                  ))),
                            ),
                            GestureDetector(
                              onTap: () {
                                whatsAppOpen();
                              },
                              child: Container(
                                height: 30,
                                width: 190,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    border: Border.all(
                                        color: Colors.black, width: 0.3)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                      image: AssetImage(
                                          "assets/images/whatsapp.png"),
                                    ),
                                    SizedBox(width: 5),
                                    Text("Message Us on WhatsApp",
                                        style: TextStyle(fontSize: 12))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.10,
                          width: MediaQuery.of(context).size.width,
                          color: Color(0xFFf5d993),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  child: Text(
                                "Connect with us",
                                style: GoogleFonts.sourceSansPro(
                                  textStyle: TextStyle(
                                    color: Color(0xFF000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                  ),
                                ),
                              )),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (await canLaunch(
                                        socialModel.data[0].facebook)) {
                                      await launch(
                                          socialModel.data[0].facebook);
                                    } else {
                                      throw 'Could not launch';
                                    }
                                  },
                                  child: Image(
                                    width: MediaQuery.of(context).size.width *
                                        0.10,
                                    image: AssetImage(
                                        "assets/images/facebook.png"),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(
                                      socialModel.data[0].instagram)) {
                                    await launch(socialModel.data[0].instagram);
                                  } else {
                                    throw 'Could not launch';
                                  }
                                },
                                child: Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.10,
                                  image:
                                      AssetImage("assets/images/instagram.png"),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (await canLaunch(
                                      'https://www.youtube.com/channel/UCfP2YvNzFVPLeRyN6sH0Xdw/')) {
                                    await launch(
                                        'https://www.youtube.com/channel/UCfP2YvNzFVPLeRyN6sH0Xdw/');
                                  } else {
                                    throw 'Could not launch';
                                  }
                                },
                                child: Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.10,
                                  image:
                                      AssetImage("assets/images/youtube.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                );
              }
            }
          }),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style15, // Choose the nav bar style with this property.
      ),
    );
  }

  _showPicker() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _pickImage();

                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    setState(() {});

    PermissionStatus status = await Permission.camera.status;
    if (status.isPermanentlyDenied) return openAppSettings();
    status = await Permission.camera.request();
    if (status.isDenied) return;

    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 10);

    setState(() {
      _image = image;
      File selected = File(_image.path);
      List<int> imageBytes = selected.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      imageFile = File(_image.path);
    });
    _cropImage();
  }

  Future<Null> _pickImage() async {
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 10);

    _image = image;

    setState(() {
      _image = image;
      File selected = File(_image.path);
      List<int> imageBytes = selected.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      imageFile = File(_image.path);
      //  uploadImage(image);
    });
    _cropImage();
  }

  // Crop Image
  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Cropper',
      ),
    );
    if (croppedFile != null) {
      imageFile = croppedFile;
      List<int> imageBytes = imageFile.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      uploadImage(base64Image, context);
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    _image = null;
    setState(() {
      state = AppState.free;
    });
  }

  _onShare(BuildContext context) async {
    final RenderBox box = context.findRenderObject() as RenderBox;

    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          text:
              """IHMS Club App is a must-have for you to be on top of what's happening at your Club. Download the app to know more 
      
https://ihmsclubs.com/ihms-app""",
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(
          """IHMS Club App is a must-have for you to be on top of what's happening at your Club. Download the app to know more 
      
https://ihmsclubs.com/ihms-app""",
          subject: subject,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }
}
