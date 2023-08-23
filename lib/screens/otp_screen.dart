import 'package:flutter/material.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:otp_text_field/otp_field.dart';


class Otp_screen extends StatefulWidget {
  @override
  String name,
      email,
      mobile,
      radiovalue,
      dob,
      anniversary,
      society,
      tower,
      flat;

  int type;

  int radiovaluegender;

  Otp_screen(
      this.name,
      this.email,
      this.mobile,
      this.radiovalue,
      this.radiovaluegender,
      this.dob,
      this.anniversary,
      this.society,
      this.tower,
      this.flat,
      this.type);
  _Otp_screenState createState() => _Otp_screenState();
}

class _Otp_screenState extends State<Otp_screen> {
  String otp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .9,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/a.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                //height: MediaQuery.of(context).size.height,
                height: MediaQuery.of(context).size.height * .755,
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
                            onPressed: () => {Navigator.pop(context)}),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.height * 0.00,
                    MediaQuery.of(context).size.height * 0.13,
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
                          height: MediaQuery.of(context).size.height * 0.67,
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.height * 0.03,
                                  MediaQuery.of(context).size.height * 0.02,
                                  MediaQuery.of(context).size.height * 0.00,
                                  MediaQuery.of(context).size.height * 0.00,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Your Phone!",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFd4b15b))),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.height * 0.03,
                                  MediaQuery.of(context).size.height * 0.01,
                                  MediaQuery.of(context).size.height * 0.00,
                                  MediaQuery.of(context).size.height * 0.00,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Enter your verification code",
                                        style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFd4b15b))),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Center(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height * 0.01,
                                    MediaQuery.of(context).size.height * 0.01,
                                    MediaQuery.of(context).size.height * 0.00,
                                    MediaQuery.of(context).size.height * 0.00,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 100,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/Group 3.png"),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Text("OTP Verification",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Color(0xFF96700f))),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                            "Enter OTP sent on your mobile no. xxx xxxx ${widget.mobile.substring(7)}",
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF5e7078))),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        // Text("01:56 Sec",
                                        //     style: TextStyle(
                                        //         fontSize: 13,
                                        //         fontWeight: FontWeight.bold,
                                        //         color: Color(0xFFb81111))),
                                        OTPTextField(
                                          length: 4,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          textFieldAlignment:
                                              MainAxisAlignment.spaceAround,
                                          style: TextStyle(fontSize: 17),
                                          onChanged: (pin) {
                                            print("Changed: " + pin);
                                            otp = pin;
                                          },
                                          onCompleted: (pin) {
                                            print("Completed: " + pin);
                                            otp = pin;
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        // Text("OTP has been re-sent sucessfully",
                                        //     style: TextStyle(
                                        //         fontSize: 10,
                                        //         fontWeight: FontWeight.bold,
                                        //         color: Color(0xFFd4b15b))),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        InkWell(
                                            onTap: () {
                                              print("adasdasdsa");
                                              sendotp(widget.mobile,
                                                  widget.type, context);
                                            },
                                            child: Text(
                                                "Did not received the OTP ?  Resend Code",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF5e7078)))),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Edit Mobile Number?",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF9d7612)))),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.20,
                  top: MediaQuery.of(context).size.height * 0.705,
                ),
                height: MediaQuery.of(context).size.height * .2,
                width: MediaQuery.of(context).size.width * .2,
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
                      submitotp(
                          widget.mobile,
                          otp,
                          context,
                          widget.radiovalue,
                          widget.radiovaluegender,
                          widget.dob,
                          widget.anniversary,
                          widget.name,
                          widget.email,
                          widget.society,
                          widget.tower,
                          widget.flat);
                    },
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
