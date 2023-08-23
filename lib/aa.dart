import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/models/UserProfileResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Booking_Screen extends StatefulWidget {
  String image;
  int id;
  String servicename;
  Booking_Screen(this.image, this.id, this.servicename);

  @override
  _ThankyouScreenState createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<Booking_Screen> {
  FocusNode myFocusNode = new FocusNode();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  bool isChecked = false;

  UserProfileResponseModel userProfileResponseModel;
  Future _loadevents;
  Future _getthanksdata;
  _bookARequest(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('id');
    print("====== USER ID ====== + $userId");
    if (mobileController.text.trim() == '' ||
        mobileController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter valid mobile number"),
      ));
    } else if (emailController.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter email"),
      ));
    } else if (nameController.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter name"),
      ));
    } else if (commentController.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter comment"),
      ));
    } else {
      bookRequest(
        widget.servicename,
        mobileController.text,
        emailController.text,
        commentController.text,
        nameController.text,
        widget.id,
        userId,
        context,
      );
    }
  }

  loadevents() {
    setState(() {
      _loadevents = userProfile().then((value) {
        userProfileResponseModel = value;
        print("OBJECT ${value.data.name}");
        setState(() {});
      });
    });
  }

  void initState() {
    // TODO: implement initState
    loadevents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              // Container(
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: NetworkImage(widget.image),
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              Container(
                height: 240,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage("assets/images/bg_color.png"),
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
                      Navigator.pop(context);
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
                    widget.servicename,
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
                  future: _loadevents,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (userProfileResponseModel != null) {
                        nameController.text =
                            userProfileResponseModel.data.name;
                        mobileController.text =
                            userProfileResponseModel.data.mobile;
                        emailController.text =
                            userProfileResponseModel.data.email;
                      }
                      return Center(
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.60,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .71,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .060,
                                        child: new TextFormField(
                                          style: TextStyle(
                                              height: 1.5,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFFa5a5a5),
                                              fontSize: 12),
                                          cursorColor: const Color(0xFFa5a5a5),
                                          keyboardType: TextInputType.text,
                                          controller: nameController,
                                          decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: const Color(
                                                              0xFFa5a5a5))),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFa5a5a5)),
                                              ),
                                              border: UnderlineInputBorder(),
                                              labelText: 'Name',
                                              labelStyle: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFcbb269),
                                              )),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .71,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .060,
                                        child: new TextFormField(
                                          style: TextStyle(
                                              height: 1.5,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFFa5a5a5),
                                              fontSize: 12),
                                          cursorColor: const Color(0xFFa5a5a5),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          controller: emailController,
                                          decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: const Color(
                                                              0xFFa5a5a5))),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFa5a5a5)),
                                              ),
                                              border: UnderlineInputBorder(),
                                              labelText: 'Email ID',
                                              labelStyle: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFcbb269),
                                              )),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .71,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .060,
                                        child: new TextFormField(
                                          maxLength: 10,
                                          keyboardType: TextInputType.number,
                                          controller: mobileController,
                                          style: TextStyle(
                                              height: 1.5,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFFa5a5a5),
                                              fontSize: 12),
                                          cursorColor: const Color(0xFFa5a5a5),
                                          decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              counterText: "",
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: const Color(
                                                              0xFFa5a5a5))),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFa5a5a5)),
                                              ),
                                              border: UnderlineInputBorder(),
                                              labelText: 'Mobile Number',
                                              labelStyle: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFcbb269),
                                              )),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                                "Provide your additional inputs ",
                                                style:
                                                    GoogleFonts.sourceSansPro(
                                                        textStyle: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFFcbb269)))),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(20.0),
                                        child: TextField(
                                          maxLines: 3,
                                          controller: commentController,
                                          style: TextStyle(
                                              height: 1.5,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFFa5a5a5),
                                              fontSize: 12),
                                          decoration: InputDecoration(
                                              labelText: 'Comment',
                                              alignLabelWithHint: true,
                                              labelStyle: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFcbb269),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFcbb269)),
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 2,
                                                  color: Color(0xFFcbb269),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                              )),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                          MediaQuery.of(context).size.height *
                                              0.00,
                                        ),
                                        child: Row(
                                          children: [
                                            Transform.scale(
                                                scale: 0.9, child: Text("")
                                                //  Checkbox(
                                                //   activeColor:
                                                //       const Color(0xFF9a7712),
                                                //   value: isChecked,
                                                //   onChanged: (bool value) {
                                                //     // This is where we update the state when the checkbox is tapped
                                                //     setState(() {
                                                //       isChecked = value;
                                                //       print(isChecked);
                                                //     });
                                                //   },
                                                // ),
                                                ),
                                            // Text("I agree to the",
                                            //     style:
                                            //         GoogleFonts.sourceSansPro(
                                            //       textStyle: TextStyle(
                                            //           fontSize: 13,
                                            //           color: const Color(
                                            //               0xFF9e9e9e),
                                            //           fontFamily:
                                            //               "Source Sans Pro",
                                            //           fontWeight:
                                            //               FontWeight.w500),
                                            //     )),
                                            // Text(" Terms",
                                            //     style:
                                            //         GoogleFonts.sourceSansPro(
                                            //       textStyle: TextStyle(
                                            //           fontSize: 13,
                                            //           color: const Color(
                                            //               0xFFa18634),
                                            //           fontFamily:
                                            //               "Source Sans Pro",
                                            //           fontWeight:
                                            //               FontWeight.bold),
                                            //     )),
                                            // Text(" &",
                                            //     style:
                                            //         GoogleFonts.sourceSansPro(
                                            //       textStyle: TextStyle(
                                            //           fontSize: 13,
                                            //           color: const Color(
                                            //               0xFF9e9e9e),
                                            //           fontFamily:
                                            //               "Source Sans Pro",
                                            //           fontWeight:
                                            //               FontWeight.w500),
                                            //     )),
                                            // Text(" Conditions",
                                            //     style:
                                            //         GoogleFonts.sourceSansPro(
                                            //       textStyle: TextStyle(
                                            //           fontSize: 13,
                                            //           color: const Color(
                                            //               0xFFa18634),
                                            //           fontFamily:
                                            //               "Source Sans Pro",
                                            //           fontWeight:
                                            //               FontWeight.bold),
                                            //     )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }),
              Center(
                child: Container(
                  height: 70,
                  width: 70,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.76,
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
                    border: Border.all(color: Colors.white, width: 5),
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
                        _bookARequest(context);
                        print('hello${_bookARequest(context)}');
                      },
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
