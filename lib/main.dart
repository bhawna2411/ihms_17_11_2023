import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ihms/screens/amenities_book_slot.dart';
import 'package:ihms/screens/amenities_booking_type.dart';
import 'package:ihms/screens/splash_screen.dart';
import 'package:ihms/routes.dart';
import 'package:ihms/screens/whatsnew_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      print(sp.getString('token'));
      isLoggedIn = sp.getString('token').isNotEmpty ?? false;
      print("check value of isloggedin");
      print(isLoggedIn);
    });
    

  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child);
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: splash_screen(),
      // home: AmenitiesBookingType(),
      // home: AmenitiesBookSlot(),

      routes: Routes().routes,
    );
  }
}
