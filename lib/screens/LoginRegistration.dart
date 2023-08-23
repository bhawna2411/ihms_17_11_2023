import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ihms/screens/login_details.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/utils.dart';

class LoginRegistration extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginRegistration> {
  Future navigateToLoginDetails(context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginDetails()));
  }

  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  int type = 0;

  _getOtp(BuildContext context) {
    if (mobileController.text.trim() == '' ||
        mobileController.text.length < 10) {
      showToast(
        'Enter Valid Mobile Number',
      );
    } else {
      sendotp(mobileController.text, type, context);
    }
  }

  _login(BuildContext context) {
    if (mobileController.text.trim() == '' ||
        mobileController.text.length < 10) {
      showToast(
        'Enter Valid Mobile Number',
      );
    } else if (otpController.text.trim() == '' ||
        otpController.text.length < 4) {
      showToast(
        'Enter Valid Otp ',
      );
    } else {
      login(mobileController.text, otpController.text, context);
    }
  }

  FocusNode myFocusNode = new FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/login.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/k.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.14,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo copy 3.png"),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.40,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.31,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 25, bottom: 7, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Text(
                        "Welcome back!",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF455a64)),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.00,
                      ),
                      Text(
                        "Login to your existing account of IHMS clubs",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFebb428),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextField(
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            controller: mobileController,
                            cursorColor: Color(0xFF96700f),
                            decoration: const InputDecoration(
                              counterText: '',
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFdddddd)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF96700f)),
                              ),
                              labelText: 'Mobile Number',
                              labelStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF96700f),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),

                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: TextField(
                                  maxLength: 4,
                                  keyboardType: TextInputType.number,
                                  controller: otpController,
                                  cursorColor: Color(0xFF96700f),
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    // enabledBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //       color: Color(0xFFdddddd)),
                                    // ),
                                    // focusedBorder: UnderlineInputBorder(
                                    //   borderSide: BorderSide(
                                    //       color: Color(0xFF96700f)),
                                    // ),
                                    // hintText: "OTP",
                                    // hintStyle: TextStyle(
                                    //     fontSize: 17,
                                    //     color: Color(0xFF455a64),
                                    //     fontWeight: FontWeight.w400),
                                    labelText: 'OTP',
                                    labelStyle: TextStyle(
                                        fontSize: 17,
                                        color: Color(0xFF455a64),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _getOtp(context);
                                },
                                child: Text(
                                  "Get Otp",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFd4b15b)),
                                ),
                              )
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: Color(0xFFdddddd),
                          ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.80,
                          //   height: MediaQuery.of(context).size.height * 0.02,
                          //   margin: EdgeInsets.fromLTRB(
                          //     MediaQuery.of(context).size.height * 0.00,
                          //     MediaQuery.of(context).size.height * 0.05,
                          //     MediaQuery.of(context).size.height * 0.00,
                          //     MediaQuery.of(context).size.height * 0.00,
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(
                          //         "OTP",
                          //         style: TextStyle(
                          //             fontSize: 14, color: Color(0xFFbdbdbd)),
                          //       ),
                          //       Text(
                          //         "Get Otp",
                          //         style: TextStyle(
                          //             fontSize: 12,
                          //             fontWeight: FontWeight.bold,
                          //             color: Color(0xFFd4b15b)),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.90,
                // height: MediaQuery.of(context).size.height * 0.35,
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.92,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFffffff),
                        )),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.02,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, 'register');
                          },
                          child: Center(
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                              ),
                            ),
                          )),
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
                  top: MediaQuery.of(context).size.height * 0.71,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xFF9f7811),
                      const Color(0xFF9e770f),
                    ],
                  ),
                  border: Border.all(color: Colors.white, width: 7),
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  child: new IconButton(
                    icon: new Icon(
                      Icons.arrow_right_alt_outlined,
                      size: 40,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      _login(context);
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
