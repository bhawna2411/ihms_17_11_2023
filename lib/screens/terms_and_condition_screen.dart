import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/screens/tabbar.dart';
import '../apiconfig/apiConnections.dart';
import '../models/StaticPageResponseModel.dart';

class TermsAndConditionScreen extends StatefulWidget {
  @override
  _MyHomePage4State createState() => _MyHomePage4State();
}

class _MyHomePage4State extends State<TermsAndConditionScreen> {
  Future navigateToTabbar(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Tabbar()));
  }

  final space = SizedBox(height: 10);
  Future _loadStaticPages;
  List<Staticdata> staticpageList;
  StaticPageResponseModel staticPageResponseModel;

  FocusNode myFocusNode = new FocusNode();
  loadevents() {
    _loadStaticPages = staticpage();
  }

  @override
  void initState() {
    super.initState();

    loadevents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
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
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.height * 0.00,
                MediaQuery.of(context).size.height * 0.24,
                MediaQuery.of(context).size.height * 0.00,
                MediaQuery.of(context).size.height * 0.00,
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: ExactAssetImage("assets/images/bg_color.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        textDirection: TextDirection.rtl,
                        fit: StackFit.loose,
                        // overflow: Overflow.visible,
                        clipBehavior: Clip.hardEdge,
                        children: <Widget>[
                          SingleChildScrollView(
                            child: FutureBuilder(
                                future:_loadStaticPages ,
                                builder: (context, snapshot) {
                                  // items = [];
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else {
                                    staticPageResponseModel = snapshot.data;
                                    staticpageList =
                                        staticPageResponseModel.data;
                                    return Container(
                                      margin: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.height *
                                            0.00,
                                        MediaQuery.of(context).size.height *
                                            0.10,
                                        MediaQuery.of(context).size.height *
                                            0.00,
                                        MediaQuery.of(context).size.height *
                                            0.00,
                                      ),
                                      child: Column(
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            //elevation: 3,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(40.0),
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20,
                                                    left: 30,
                                                    right: 20),
                                                child: Column(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Terms and Condition",
                                                          style: GoogleFonts
                                                              .sourceSansPro(
                                                            textStyle: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xFFcbb269)),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Text(
                                                          staticpageList[0]
                                                              .tC,
                                                          style: GoogleFonts
                                                              .sourceSansPro(
                                                            textStyle: TextStyle(
                                                                height: 1.5,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xFFcbb269)),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: InkWell(
                      child: new IconButton(
                        icon: new Icon(
                          Icons.arrow_back,
                          size: 20,
                        ),
                        color: Color(0xFF203040),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
