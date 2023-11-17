import 'package:flutter/material.dart';
import 'package:ihms/models/WhatsNewResponseModel.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WhatsNewDetailScreen extends StatefulWidget {
  WhatsNewResponseModel clubsResponseModel;
  Datumwhatsnew whatsnewList;
  WhatsNewDetailScreen(this.whatsnewList);
  @override
  _WhatsNewDetailScreenState createState() => _WhatsNewDetailScreenState();
}

class _WhatsNewDetailScreenState extends State<WhatsNewDetailScreen> {
  @override
  void initState() {
    super.initState();
  }
  final space = SizedBox(height: 10);
  _launchURL(url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff203040),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(18.0, 18.0, 0.0, 10.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 12,
                          child: Center(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.arrow_back),
                              color: Color(0xff203040),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                            child: Image.network(
                              widget.whatsnewList.innerImage,
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(11.0, 0, 11.0, 0),
                      child: Column(
                        children: [
                          Text(
                            widget.whatsnewList.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(height: 20),
                          Text(
                            widget.whatsnewList.description,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 60),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                              _launchURL(widget.whatsnewList.url);
                          });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                const Color(0xFFb48919),
                                const Color(0xFF9a7210),
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(70.0)),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Learn More",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                    fontSize: 12,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
