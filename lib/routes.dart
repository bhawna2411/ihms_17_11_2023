import 'package:flutter/material.dart';
import 'package:ihms/screens/LoginRegistration.dart';
import 'package:ihms/screens/login_details.dart';
import 'package:ihms/screens/tabbar.dart';
import 'package:ihms/screens/thankyou_screen.dart';

class Routes {
  var routes = <String, WidgetBuilder>{
    // '/profile': (BuildContext context) => ProfileScreen(),
    'loginRegistration': (BuildContext context) => LoginRegistration(),
    'tabbar': (BuildContext context) => Tabbar(),
    'register': (BuildContext context) => LoginDetails(),
    'thankyou': (BuildContext context) => ThankyouScreen(),
    //'thankyoujoin': (BuildContext context) => ThankyouJoinACtivitiesScreen(),

    //'otpScreen': (BuildContext context) => Otp_screen(),
  };
}
