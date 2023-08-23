import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/screens/tabbar.dart';
import '../apiconfig/apiConnections.dart';
import '../models/StaticPageResponseModel.dart';

class about_screen extends StatefulWidget {
  @override
  _MyHomePage4State createState() => _MyHomePage4State();
}

class _MyHomePage4State extends State<about_screen> {
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
    // setState(() {
    //   staticpage().then((value) {
    //     staticPageResponseModel = value;
    //     print(
    //         '---------aboutus----------${staticPageResponseModel.data[0].aboutUs}');
    //   });
    //   setState(() {});
    // });
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
                                                          "About IHMS",
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
                                                        //                                                 Text(
                                                        //                                                   '''IHMS (Innovest Hospitality & Management Services) started with one club in 2017 and has since grown to become one of the most  professional club management company in Delhi / NCR. We provide services to 10+clubs, while also managing various amenities, such as tennis, aquatics, fitness, food & beverage, lodging and more.

                                                        // At IHMS managed clubs, we create venues that are not simply “hot and trendy,” but rather essential to the very fabric of the complexes  and communities. Food & Beverage is a key ingredient in our hospitality and has always influenced the reputation of our clubs.

                                                        // Our mission is to make food and beverage the heart and soul of our clubs by thinking like restaurateurs and delivering an experience that is excellent, relevant and authentic. Our  philosophy regarding food and beverage consists of customizing each dining experience, commensurate with the personalized culture at each individual club – be it private, resort or daily fee. Our proprietary Food & Beverage Standards ensure that IHMS’ high level of quality remains consistent and our formula for success includes extensive corporate support through delivering extraordinary member and guest experiences, operational excellence and financial performance. In addition to the operational resources provided within IHMS’ club management services, clients utilize our design and development services that are specifically tailored to help clubs reimagine and refresh existing foodservice facilities, as well as develop new foodservice opportunities.

                                                        // We have grown our company by listening to and understanding the specific opportunities and challenges of our clients, then customizing our approach to achieve success together. This is accomplished by providing a foundation comprised of the best talent and resources in the industry and cultivating the creativity of our associates. Our successful culture, combined with 30+ years of experience, give us the opportunity to develop the strategies, resources and talent that allow our clients to excel in this competitive industry.
                                                        // Our operational expertise includes:
                                                        // ● Private club membership structure and strategy
                                                        // ● Club and amenities management
                                                        // ● Accounting/forecasting
                                                        // ● Budget analysis/capital expenditure optimization
                                                        // ● Strategic partnerships
                                                        // ● Community programs and event management''',
                                                        //                                                   style:
                                                        //                                                       GoogleFonts.sourceSansPro(
                                                        //                                                     textStyle: TextStyle(
                                                        //                                                         height: 1.5,
                                                        //                                                         fontSize: 15,
                                                        //                                                         fontWeight:
                                                        //                                                             FontWeight.w600,
                                                        //                                                         color:
                                                        //                                                             Color(0xFFcbb269)),
                                                        //                                                   ),
                                                        //                                                 ),
                                                        Text(
                                                          staticpageList[0]
                                                              .aboutUs,
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
