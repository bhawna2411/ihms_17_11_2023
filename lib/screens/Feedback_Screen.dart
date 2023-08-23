import 'package:flutter/material.dart';
import 'package:ihms/apiconfig/apiConnections.dart';
import 'package:ihms/screens/tabbar.dart';
import '../utils.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController feedbackController = TextEditingController();

  feedback() {
    if (feedbackController.text.trim() == '') {
      showToast(
        'Please Enter Feedback',
      );
    } else {
      sendfeedback(feedbackController.text, context);
    }
  }

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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg_color.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                // gradient: Utils().getGradientColor(),
                ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 223,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: Color(0xFF96700f),
                          borderRadius: BorderRadius.circular(25)
                          // boxShadow: BorderRadius.circular(25)
                          ),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                                color: Color(0xFFc0a155),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    topLeft: Radius.circular(25))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Enter your Feedback below",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                // Icon(Icons.keyboard_arrow_down_outlined, color: ColorRes.whiteColor)
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                            // height: 150,
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 10, bottom: 10),
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextField(
                              controller: feedbackController,
                              maxLines: 8,
                              textInputAction: TextInputAction.newline,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                    left: 20, bottom: 10, top: 0, right: 20),
                                hintText: "Enter Text",
                                // hintStyle: TextStyle(color: ColorRes.whiteColor, fontWeight: FontWeight.w500, fontSize: 14)
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        //sendfeedback(feedbackController.text, context);
                        feedback();
                      },
                      child: Container(
                        height: 56,
                        width: 156,
                        margin: EdgeInsets.only(top: 35, bottom: 25),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFc0a155),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("submit",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
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
        ],
      ),
    ));
  }
}
