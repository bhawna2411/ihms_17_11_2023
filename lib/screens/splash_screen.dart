import 'package:flutter/material.dart';
import 'package:ihms/models/SplaceResponseModel.dart';
import 'package:ihms/screens/login_details.dart';
import 'package:ihms/screens/tabbar.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splash_screen extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<splash_screen> {
  Future navigateToLoginDetails(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginDetails()));
  }

  SplaceResponseModel splaceResponse;
  bool isLoggedIn = false;
  String getValueOfToken = "";
  void loadSplaceBackground() async {
    splaceResponse = await getSplaceBackground();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      getValueOfToken = sp.getString('token');
      print(getValueOfToken);
      if (getValueOfToken == null || getValueOfToken == "") {
        loadSplaceBackground();
      } else {
        Navigator.of(context, rootNavigator: true)
            .pushReplacement(MaterialPageRoute(builder: (context) => Tabbar()));
      }
    });
  }

  FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: splaceResponse == null
                      ? AssetImage("assets/images/background.png")
                      : NetworkImage(splaceResponse.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.height * 0.585, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Shape 6 copy 7.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .08,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/Shape 6 copy 9.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 280,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 148,
                      width: 148,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/chat.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 75),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: FittedBox(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/logo copy 3.png"),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .250,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Text("Welcome",
                                  style: TextStyle(
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0,
                                          color: Colors.black,
                                          offset: Offset(-3.0, 3.0),
                                        ),
                                      ],
                                      fontWeight: FontWeight.w400,
                                      fontSize: 28,
                                      color: Color(0xFFffffff))),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("to IHMS Clubs",
                                style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                        offset: Offset(-3.0, 3.0),
                                      ),
                                    ],
                                    fontWeight: FontWeight.w400,
                                    fontSize: 28,
                                    color: Color(0xFFffffff))),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .031,
                            ),
                            Text("___________",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Color(0xFFba8e1c))),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .05,
                            ),
                            Text("Innovest Hospitality &",
                                style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                        offset: Offset(-3.0, 3.0),
                                      ),
                                    ],
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Color(0xFFffffff))),
                            Text("Management Services",
                                style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                        offset: Offset(-3.0, 3.0),
                                      ),
                                    ],
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Color(0xFFffffff))),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 8,
                                width: 13,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40.0),
                                  ),
                                  color: const Color(0xFFefc353),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: 7,
                                width: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .018,
                        ),
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              navigateToLoginDetails(context);
                            },
                            child: Container(
                              height: 45,
                              width: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                                color: Color(0xFFefc353),
                              ),
                              child: Center(
                                child: Text("GET STARTED",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 19,
                                        color: Color(0xFFffffff))),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .015,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Copyright © 2021 All Right Reserved",
                                style: TextStyle(
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black,
                                        offset: Offset(-3.0, 3.0),
                                      ),
                                    ],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Color(0xFFffffff))),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .020,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
