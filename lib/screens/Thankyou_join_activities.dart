import 'package:flutter/material.dart';
import 'package:ihms/screens/tabbar.dart';


class ThankyouJoinACtivitiesScreen extends StatefulWidget {
  final String name;

  const ThankyouJoinACtivitiesScreen(this.name);

  @override
  _ThankYouJoinActivityScreenState createState() =>
      _ThankYouJoinActivityScreenState();
}

class _ThankYouJoinActivityScreenState
    extends State<ThankyouJoinACtivitiesScreen> {
  FocusNode myFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: (){
           Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => Tabbar()));
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/dashboard_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.height * 0.00,
                MediaQuery.of(context).size.height * 0.24,
                MediaQuery.of(context).size.height * 0.00,
                MediaQuery.of(context).size.height * 0.00,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage("assets/images/bg_color.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.height * 0.00,
                  MediaQuery.of(context).size.height * 0.20,
                  MediaQuery.of(context).size.height * 0.00,
                  MediaQuery.of(context).size.height * 0.00,
                ),
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 10,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.60,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.20,
                              width: MediaQuery.of(context).size.width * 0.35,
                              margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.height * 0.00,
                                MediaQuery.of(context).size.height * 0.10,
                                MediaQuery.of(context).size.height * 0.00,
                                MediaQuery.of(context).size.height * 0.00,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/thumbs-up.png"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                              },
                              child: Text("THANK YOU !",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      color: Color(0xFF96700f))),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(widget.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width * .2,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.61,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xFFb48919),
                      const Color(0xFF9a7210),
                    ],
                  ),
                  border: Border.all(color: Colors.white, width: 7),
                  shape: BoxShape.circle,
                  color: Colors.brown,
                ),
                child: InkWell(
                  child: new IconButton(
                    icon: new Icon(
                      Icons.arrow_right_alt_outlined,
                      size: 40,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, "tabbar");
                    },
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
