import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
//import 'dart:js';
//import 'dart:js';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ihms/models/ActivitiesResponseModel.dart';
import 'package:ihms/models/AmenitiesHistoryResponse.dart';
import 'package:ihms/models/AvailableSeatsResponseModel.dart';
import 'package:ihms/models/AmenitiesResponseModel.dart';
import 'package:ihms/models/BannerResponseModel.dart';
import 'package:ihms/models/ClubsResponseModel.dart';
import 'package:ihms/models/EventHistoryResponseModel.dart';
import 'package:ihms/models/EventsResponseModel.dart';
import 'package:ihms/models/FlatResponseModel.dart';
import 'package:ihms/models/ServiceHistoryResponseModel.dart';
import 'package:ihms/models/ServicesResponseModel.dart';
import 'package:ihms/models/SocialModel.dart';
import 'package:ihms/models/SocietyResponseModel.dart';
import 'package:ihms/models/SplaceResponseModel.dart';
import 'package:ihms/models/TowerResponseModel.dart';
import 'package:ihms/models/UserProfileResponseModel.dart';
import 'package:ihms/models/UsersResponseModel.dart';
import 'package:ihms/models/WhatsNewResponseModel.dart';
import 'package:ihms/screens/Feedback_Screen.dart';
import 'package:ihms/screens/Thankyou_join_activities.dart';
import 'package:ihms/screens/WhatsNew_Screen.dart';
import 'package:ihms/screens/tabbar.dart';
import 'package:ihms/screens/thankyou_screen.dart';
import 'package:ihms/utils.dart';
import 'package:ihms/string_resources.dart';
import 'package:jiffy/jiffy.dart';

import '../models/OrderIdResponse.dart';
import '../models/StaticPageResponseModel.dart';
import '../screens/seatsBooked.dart';
import 'endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

var ep = endpoints();

showLoader(con) {
  showDialog(
    context: con,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
          child: Container(
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width / 5,
              child: Lottie.asset("assets/images/loader.json")));
    },
  );
}

SplaceResponseModel splaceResponseModelFromJson(String str) =>
    SplaceResponseModel.fromJson(json.decode(str));

Future<SplaceResponseModel> getSplaceBackground() async {
  final response = await http.get(Uri.parse(ep.base_url + ep.splacescreen));
  var jsonData = json.decode(response.body);
  print(jsonData);
  if (response.statusCode == 200) {
    final splaceResponseModel = splaceResponseModelFromJson(response.body);
    return splaceResponseModel;
  } else {
    return SplaceResponseModel();
  }
}

BannerResponseModel bannerResponseModelFromJson(String str) =>
    BannerResponseModel.fromJson(json.decode(str));

Future<BannerResponseModel> getBanners() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userId = prefs.getString('id');
  final response =
      await http.get(Uri.parse(ep.base_url + ep.banner + "?user_id=" + userId));
  var jsonData = json.decode(response.body);

  if (response.statusCode == 200) {
    final bannerResponseModel = bannerResponseModelFromJson(response.body);
    return bannerResponseModel;
  } else {
    return BannerResponseModel();
  }
}

UsersResponseModel usersResponseModelFromJson(String str) =>
    UsersResponseModel.fromJson(json.decode(str));

Future<UsersResponseModel> getUsers() async {
  print("get users --- ");
  final response = await http.get(Uri.parse(ep.base_url + ep.users));
  var jsonData = json.decode(response.body);
  // print(jsonData);
  if (response.statusCode == 200) {
    final usersResponseModel = usersResponseModelFromJson(response.body);
    return usersResponseModel;
  } else {
    return UsersResponseModel();
  }
}

Future<EventsResponseModel> getEvents() async {
  print("calling get event api ---------------------------------------");
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userId = prefs.getString('id');
  final response =
      await http.get(Uri.parse(ep.base_url + ep.event + "?user_id=" + userId));
  print("url" + ep.base_url + ep.event + "?user_id=" + userId);

  var jsonData = json.decode(response.body);
  print("event data response is ======= ${response.body}");

  if (response.statusCode == 200) {
    try {
      final eventsResponseModel = eventsResponseModelFromJson(response.body);
      return eventsResponseModel;
    } catch (e) {
      print("error rajat" + e.toString());
      return EventsResponseModel();
    }
  } else {
    return EventsResponseModel();
  }
}

Future<AmenitiesResponseModel> getAmenities() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userId = prefs.getString('id');
  final response = await http
      .get(Uri.parse(ep.base_url + ep.amenities + "?user_id=" + userId));
  if (response.statusCode == 200) {
    final amenitiesResponseModel =
        amenitiesResponseModelFromJson(response.body);
    return amenitiesResponseModel;
  } else {
    return AmenitiesResponseModel();
  }
}

Future<ClubsResponseModel> getClubs() async {
  final response = await http.get(Uri.parse(ep.base_url + ep.clubs));
  var jsonData = json.decode(response.body);
  print("==============json club ==========================>>>>>{$jsonData}");
  print("status code club   ------    ${response.statusCode}");

  if (response.statusCode == 200) {
    ClubsResponseModel clubsResponseModel =
        clubsResponseModelFromJson(response.body);
    print("hiiiii");
    print("from api   ------    ${clubsResponseModel}");
    return clubsResponseModel;
  } else {
    print("else");
    return ClubsResponseModel();
  }
}

Future<ServicesResponseModel> getServices() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userId = prefs.getString('id');

  final response = await http
      .get(Uri.parse(ep.base_url + ep.services + "?user_id=" + userId));
  var jsonData = json.decode(response.body);
  // print("========================================>>>>>{$jsonData}");
  if (response.statusCode == 200) {
    final servicesResponseModel = servicesResponseModelFromJson(response.body);
    return servicesResponseModel;
  } else {
    return ServicesResponseModel();
  }
}

Future<EventHistoryResponseModel> getEventHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userId = prefs.getString('id');

  final response = await http
      .get(Uri.parse(ep.base_url + ep.eventhistory + "?user_id=" + userId));
  print(
      "calling event history api -----  ${ep.base_url + ep.eventhistory + "?user_id=" + userId}");

  var jsonData = json.decode(response.body);
  if (response.statusCode == 200) {
    final eventHistoryResponseModel =
        eventHistoryResponseModelFromJson(response.body);

    return eventHistoryResponseModel;
  } else {
    return EventHistoryResponseModel();
  }
}

Future<ServiceHistoryResponseModel> getServiceHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');
  final response = await http
      .get(Uri.parse(ep.base_url + ep.concierge + "?user_id=" + userId));
  if (response.statusCode == 200) {
    final serviceHistoryResponseModel =
        serviceHistoryResponseModelFromJson(response.body);

    return serviceHistoryResponseModel;
  } else {
    return ServiceHistoryResponseModel();
  }
}

Future<AmenitiesHistoryResponse> getAmenitiesHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');
  final response = await http
      .get(Uri.parse(ep.base_url + ep.amenitiesHistory + "?user_id=" + userId));
   print("response of amenity ==== ${response.statusCode}");
  if (response.statusCode == 200) {
    final amenitiesHistoryResponse =
        amenitiesHistoryResponseFromJson(response.body);

    return amenitiesHistoryResponse;
  } else {
    return AmenitiesHistoryResponse();
  }
}

Future<UserProfileResponseModel> userProfile() async {
  print("userProfile --------");
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userId = prefs.getString('id');
  // print("====== USER ID ====== + $userId");
  print("profile url is ---------- ${ep.base_url + ep.userProfile + userId}");
  final response =
      await http.get(Uri.parse(ep.base_url + ep.userProfile + userId));
  var jsonData = json.decode(response.body);
  // print(ep.base_url + ep.userProfile + userId);
  print("=====================PROFILE DATA===================>>>>>{$jsonData}");
  if (response.statusCode == 200) {
    final userProfileResponseModel =
        userProfileResponseModelFromJson(response.body);
    return userProfileResponseModel;
  } else {
    return UserProfileResponseModel();
  }
}

Future<ActivitiesResponseModel> getActivities() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userId = prefs.getString('id');
  final response = await http
      .get(Uri.parse(ep.base_url + ep.activities + "?user_id=" + userId));
  var jsonData = json.decode(response.body);
  // print("========================================>>>>>{$jsonData}");
  if (response.statusCode == 200) {
    final activitesResponseModel =
        activitiesResponseModelFromJson(response.body);
    return activitesResponseModel;
  } else {
    return ActivitiesResponseModel();
  }
}

Future<SocietyResponseModel> getSociety() async {
  // print("getSociety ------  ");
  final response = await http.get(Uri.parse(ep.base_url + ep.society));
  var jsonData = json.decode(response.body);
  print('getSociety jsonData--------------------$jsonData');
  if (response.statusCode == 200) {
    final societyResponseModel = societyResponseModelFromJson(response.body);
    return societyResponseModel;
  } else {
    return SocietyResponseModel();
  }
}

Future<WhatsNewResponseModel> whatspdf() async {
  print("calling whatspdf  --------------------------");
  CircularProgressIndicator();
   SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');
  final response = await http.get(Uri.parse(ep.base_url + ep.whatsnew + "?user_id=" + userId));
  var jsonData = json.decode(response.body);
  print("response whats new ------------ $jsonData");
  if (response.statusCode == 200) {
    final whatsNewResponseModel = whatsNewResponseModelFromJson(response.body);
    return whatsNewResponseModel;
  } else {
    return WhatsNewResponseModel();
  }
}

Future<List<TowerData>> getTower(String societyId) async {
  // print("get tower");
  final response = await http.post(
    Uri.parse(ep.base_url + ep.tower),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "society_id": societyId,
    }),
  );
  print(
      "calling get tower api --- ${ep.base_url + ep.tower}  with societyId $societyId ");

  var jsonData = json.decode(response.body);
  print("get tower api data ---- $jsonData");

  if (response.statusCode == 200) {
    final towerResponseModel = towerResponseModelFromJson(response.body);
    return towerResponseModel.data;
  } else {
    return [];
  }
}

Future<SocialModel> socialurl() async {
  CircularProgressIndicator();
  final response = await http.get(Uri.parse(ep.base_url + ep.social_url));
  var jsonData = json.decode(response.body);
  print(jsonData);
  print(response);
  if (response.statusCode == 200) {
    final SocialModel = socialModelFromJson(response.body);
    return SocialModel;
  } else {
    return SocialModel();
  }
}

Future<StaticPageResponseModel> staticpage() async {
  // CircularProgressIndicator();
  final response = await http.get(Uri.parse(ep.base_url + ep.static_page));
  var jsonData = json.decode(response.body);
  print(jsonData);
  print(response);
  if (response.statusCode == 200) {
    final StaticPageResponseModel =
        staticPageResponseModelFromJson(response.body);
    return StaticPageResponseModel;
  } else {
    return StaticPageResponseModel();
  }
}

Future<List<FlatData>> getFlat(String societyId, String towerId) async {
  // print("get flat");
  final response = await http.post(
    Uri.parse(ep.base_url + ep.flat),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{"society_id": societyId, "tower_id": towerId}),
  );
  print(
      "calling get flat api --- ${ep.base_url + ep.flat}  with societyId $societyId and towerId $towerId");

  var jsonData = json.decode(response.body);
  print("get flat api data ---- $jsonData");
  if (response.statusCode == 200) {
    final flatResponseModel = flatResponseModelFromJson(response.body);
    return flatResponseModel.data;
  } else {
    return [];
  }
}

void login(String mobile, String otp, BuildContext context) async {
  // showLoader(context);
  String token = await FirebaseMessaging.instance.getToken();
  print("token $token");

  final response = await http.post(
    Uri.parse(ep.base_url + ep.login),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "mobile": mobile,
      "password_otp": otp,
      "type": 0,
      "appkey": token,
    }),
  );

  print("=======LOGIN=======>>>> + ${response.body}");

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    showToast(
      jsonData['msg'].toString(),
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = jsonData['token'];
    var id = jsonData['id'].toString();
    prefs.setString('token', token);
    prefs.setString('id', id);

    prefs.setString('gender', jsonData['gender'] ?? "");
    prefs.setString('society', jsonData['society'] ?? "");
    prefs.setString('tempsociety', jsonData['society'] ?? "");
    prefs.setString('dob', jsonData['dob'] ?? "");
    prefs.setBool('is_logged_in', true);

    var gender = prefs.getString('gender');
    var society = prefs.getString('society').replaceAll(' ', '_');
    var dob;
    if (prefs.getString('dob') != "") {
      if (prefs.getString('dob').contains('/')) {
        var dataa = DateFormat('MM/dd/yyyy').parse(prefs.getString('dob'));
        var aa = Jiffy(dataa).format('do MMMM yyyy');
        dob = aa.replaceAll(' ', '_');
      } else {
        dob = prefs.getString('dob').replaceAll(' ', '_');
      }
    } else {
      dob = "1st_January_2023";
    }

      var firebaseMessaging = FirebaseMessaging.instance;
    
    firebaseMessaging
        .subscribeToTopic(gender == null || gender == "" ? "Male" : gender);
    firebaseMessaging.subscribeToTopic(society);
    firebaseMessaging.subscribeToTopic(dob);

    Navigator.pop(context);
    if (jsonData['error'] == false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("id", jsonData['id'].toString());
      Navigator.pushNamed(context, 'tabbar');
    } else {
      Navigator.pop(context);
    }
  } else {
    showToast(
      "Something Went Wrong ",
    );

    Navigator.pop(context);
  }
}

void uploadImage(String userImage, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userId = prefs.getString('id');
  print("====== USER ID ====== + $userId");

  final response = await http.post(
    Uri.parse(ep.base_url + ep.imageUploadUser),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "user_id": userId,
      "image": userImage,
    }),
  );

  print("=======UPLOAD IMAGE=======>>>> + ${response.body}");

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    print(jsonData);
    showToast(
      jsonData['msg'].toString(),
    );
    Navigator.pop(context);
  } else {
    showToast(
      "Something Went Wrong ",
    );
    Navigator.pop(context);
  }
}

Future<String> sendotp(String mobile, int type, BuildContext context) async {
  showLoader(context);
  final response = await http.post(
    Uri.parse(ep.base_url + ep.sendotp),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"mobile": mobile, "type": type}),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    print(jsonData);
    Fluttertoast.showToast(
        msg: jsonData['msg'].toString(),
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black, //ColorRes.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
    if (jsonData['error'].toString() == "true") {
      return "false";
    } else {
      return "true";
    }
  } else {
    Fluttertoast.showToast(
        msg: "Something Went Wrong ",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black, //ColorRes.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
    return "false";
  }
}

void submitotp(
    String mobile,
    String otp,
    BuildContext context,
    String radiovalue,
    int radiovaluegender,
    String dob,
    String anniversary,
    String name,
    String email,
    String society,
    String tower,
    String flat) async {
  showLoader(context);
  final response = await http.post(
    Uri.parse(ep.base_url + ep.submitotp),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{"mobile": mobile, "otp": otp}),
  );
  print("final data----------${response.statusCode}");
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    print(jsonData);
    Fluttertoast.showToast(
        msg: jsonData['msg'].toString(),
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black, //ColorRes.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
    print("final data----------${jsonData['msg']}");
    if (jsonData['msg'].toString() == "OTP Verification Success") {
      register(
        name,
        email,
        mobile,
        society,
        tower,
        flat,
        context,
        radiovalue,
        radiovaluegender,
        dob,
        anniversary,
      );
    }
  } else {
    Fluttertoast.showToast(
        msg: "Something Went Wrong ",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black, //ColorRes.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
  }
}

void editProfile(
    String society,
    String towerNumber,
    String flatNumber,
    String name,
    String email,
    String mobile,
    String dob,
    String anniversary,
    String userId,
    // int id,
    String socityName,
    String profession,
    String gender,
    String education,
    String areaOfInterest,
    int ihmsMembership,
    BuildContext context) async {
  print("network ihmsmembership ==== $ihmsMembership");
  final response = await http.post(
    Uri.parse(ep.base_url + ep.userprofileupdate),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "society": society,
      "towerNumber": towerNumber,
      "flatNumber": flatNumber,
      "name": name,
      "email": email,
      "mobile": mobile,
      "dob": dob,
      "anniversary": anniversary,
      "id": userId,
      // "id": id,
      "profession": profession,
      "gender": gender,
      "education": education,
      "area_of_interest": areaOfInterest,
      "ihms_membership": ihmsMembership
    }),
  );
  // print('--------------response.body------------------${response.body}');
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('editProfile society -------------------$society ');
    print('editProfile socityName -------------------$socityName');
    prefs.setString('society', socityName ?? "");
    print('editProfile jsonData -------------------$jsonData');
    Navigator.pushNamed(context, 'tabbar');
    showToast(jsonData['msg']);
  }
}

Future<bool> switchUserSociety(bool switchValue, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');
  var society = prefs.getString('tempsociety');
  print("switchValue ======= $switchValue");
  print("society ======= $society");

  final response = await http.post(
    Uri.parse(ep.base_url + ep.switchUserSociety),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "user_id": userId,
      "switch_value": switchValue,
      "society": society,
    }),
  );

  print("response.body ----- ${response.body}");
  var jsonData = json.decode(response.body);
  if (response.statusCode == 200) {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('updatedsociety');
    prefs.setString('updatedsociety', jsonData["data"] ?? "");
    var user_society = prefs.getString('updatedsociety');

    updatedSociety.value = jsonData["data"] ?? "";
    print("updated society ======= $user_society");
    print("society is ======= ${jsonData["data"]}");
    showToast(jsonData['msg']);
  }
  return true;
}

void addTransaction(
    String bookingDate,
    String userid,
    String order_id,
    String transaction_id,
    int amount,
    String paymentstatus,
    // int id,
    BuildContext context,
    int eventId,
    String _UserId,
    String seatsBooks,
    String _startDate,
    String _endDate,
    int nonPaid,
    List<dynamic> newCategory
    ) async {
  showLoader(context);
  print("This is payment process data");
  print("---UserId---  $userid");
  print("---order_id---  $order_id");
  print("---transaction_id---  $transaction_id");
  print("---amount---  $amount");
  print("---paymentstatus---  $paymentstatus");
  print("---seatsBooks---  $seatsBooks");
  print("---_startDate---  $_startDate");
  print("---_endDate---  $_endDate");

  final response = await http.post(
    Uri.parse(ep.base_url + ep.addtransaction),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "userid": userid,
      "order_id": order_id,
      "transaction_id": transaction_id,
      "amount": amount,
      "paymentstatus": paymentstatus,
      "event_id": eventId.toString(),
      "paid_seat": seatsBooks
      // "id": id,
    }),
  );
  // print('--------------response.body------------------${response.body}');
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);

    print("jsonData: ${jsonData}");
    if (jsonData['success'] == false) {
      print("jsonData:$jsonData ");
    } else {
      eventparticipate(
          bookingDate,
          "0",
          "0",
          eventId,
          _UserId.toString(),
          amount.toString(),
          context,
          seatsBooks.toString(),
          _startDate,
          _endDate,
          nonPaid,
          newCategory
          );
    }

    // jsonData['success:']

  }
}

Future<OrderIdResponse> generateOrderIdRequest(
    int amount, String userId, String paymentby, BuildContext context) async {
  final response = await http.post(
    Uri.parse(ep.base_url + ep.generateId),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "amount": amount,
      "userid": userId,
      "paymentby": "razorpay"
    }),
  );
  print(
      "OrderId request response ------------------------------------ ${response.body}");
  if (response.statusCode == 200) {
    print("payment success");
    OrderIdResponse orderIdResponse = orderIdResponseFromJson(response.body);
    return orderIdResponse;
  } else {
    return OrderIdResponse();
  }
}

void bookRequest(
    String servicename,
    String mobile,
    String email,
    String comment,
    String name,
    int serviceId,
    String userId,
    BuildContext context) async {
  print("service comment ==== $comment");
  final response = await http.post(
    Uri.parse(ep.base_url + ep.bookService),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "mobile": mobile,
      "email": email,
      "description": comment,
      "name": name,
      "service_id": serviceId,
      "user_id": userId
    }),
  );
  print(
      "book request response ------------------------------------ ${response.body}");
  print(
      "book request status code ------------------------------------ ${response.statusCode}");

  if (response.statusCode == 200) {
    print("booking has been successfully done");
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => ThankyouJoinACtivitiesScreen(
            "Your request for $servicename service has been received. Our team will contact you shortly.")));
  }
}

// Future<String> bookRequest(
//     String servicename,
//     String mobile,
//     String email,
//     String comment,
//     String name,
//     int serviceId,
//     String userId,
//     BuildContext context) async {
//   // showLoader(context);
//   final response = await http.post(
//     Uri.parse(ep.base_url + ep.bookService),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{
//       "mobile": mobile,
//       "email": email,
//       "description": comment,
//       "name": name,
//       "service_id": serviceId,
//       "user_id": userId
//     }),
//   );
//   if (response.statusCode == 200) {
//     print("booking has been successfully done");
//     Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
//         builder: (context) => ThankyouJoinACtivitiesScreen(
//             "Your request for $servicename service has been received. Our team will contact you shortly.")));
//   }
// }

void eventparticipate(
    String bookingDate,
    String adultCount,
    String childCount,
    int eventId,
    String evenName,
    String totalamount,
    BuildContext context,
    String noOfParticipants,
    String startDate,
    String endDate,
    int nonpaid,
     List<dynamic> newCategoryy
    ) async {

      print("newCategoryy non paid ============ $newCategoryy");
  showLoader(context);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');
   String jsonString = jsonEncode(newCategoryy);
  final response = await http.post(
    Uri.parse(ep.base_url + ep.participateEvents),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "event_id": eventId,
      "no_of_participants": noOfParticipants,
      "start_date": startDate,
      "end_date": endDate,
      "user_id": int.parse(userId),
      "totalamount": totalamount,
      "nonpaid": nonpaid,
      "booking_date": bookingDate,
      "category":jsonString
    }),
  );
  var data = json.decode(response.body);

  if (response.statusCode == 200) {
    String message = data['msg'];
    bool error = data['error'];
    if (error) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.yellow,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Registration success",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.yellow,
          fontSize: 16.0);
      Navigator.pop(context);
      Navigator.of(context, rootNavigator: false).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => ThankyouJoinACtivitiesScreen(
                  "Your request for $evenName participation has been received. If more family members are keen to participate, please click on participate button again! .")),
          (route) => false);
    }
  }
}

void amenityParticipate(
  String amenityName,
  int amenityId,
  String payType,
  String bookingType,
  String slotStartTime,
  String slotEndTime,
  String orderId,
  String transactionId,
  int amount,
  int bookSeat,
  String paymentStatus,
  BuildContext context,
  String comment,
) async {
  showLoader(context);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');
  final response = await http.post(
    Uri.parse(ep.base_url + ep.amenityParticipate),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: json.encode({
      "amenity_id": amenityId,
      "user_id": int.parse(userId),
      "pay_type": payType,
      "booking_type": bookingType,
      "slot_start_time": slotStartTime,
      "slot_end_time": slotEndTime,
      "order_id": orderId,
      "transaction_id": transactionId,
      "amount": amount,
      "book_seat": bookSeat,
      "payment_status": paymentStatus,
      "description": comment
    }),
  );
  print("res of amenity ====== ${response.body}");
  var data = json.decode(response.body);
  print("data====== ${data}");
  if (response.statusCode == 200) {
    String message = data['msg'];
    bool error = data['error'];
    if (error) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.yellow,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Registration success",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.amber,
          textColor: Colors.yellow,
          fontSize: 16.0);
      Navigator.pop(context);
      Navigator.of(context, rootNavigator: false).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => ThankyouJoinACtivitiesScreen(
                  "Your request for $amenityName participation has been received.")),
          (route) => false);
    }
  }
}

void register(
    String name,
    String email,
    String mobile,
    String society,
    String tower,
    String flat,
    BuildContext context,
    String radiovalue,
    int radiovaluegender,
    String dobb,
    String anniversery) async {
  // showLoader(context);
  // var bodData = jsonEncode(<String, dynamic>{
  //   "name": name,
  //   "email": email,
  //   'mobile': mobile,
  //   'society': society,
  //   'tower': tower,
  //   'flat': flat,
  //   'user_role': radiovalue,
  //   'dob': dob,
  //   'anniversary': anniversery,
  //   'gender': radiovaluegender == 0 ? "Male" : "Female"
  // });
  // print(bodData);
  String token = await FirebaseMessaging.instance.getToken();
  print("token $token");

  SharedPreferences prefs = await SharedPreferences.getInstance();

  final response = await http.post(
    Uri.parse(ep.base_url + ep.register),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "name": name,
      "email": email,
      'mobile': mobile,
      'society': society,
      'tower': tower,
      'flat': flat,
      'user_role': radiovalue,
      'dob': dobb,
      'anniversary': anniversery,
      'gender': radiovaluegender == 0 ? "Male" : "Female",
      "appkey": token,
    }),
  );
  print('hiregister');
  print('calling register api ------ ${ep.base_url + ep.register}');

  print("=======REGISTER=======>>>> + ${response.body}");

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    Fluttertoast.showToast(
        msg: jsonData['msg'].toString(),
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black, //ColorRes.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    print("jsonDatajsonData $jsonData");
    print(jsonData["id"]);
    print("societysociety ${jsonData["society"]}");

    prefs.setString('gender', radiovaluegender == 0 ? "Male" : "Female");
    prefs.setString('society', jsonData["society"] ?? "");
    prefs.setString('tempSociety', jsonData["society"] ?? "");
    prefs.setString('dob', dobb);

    var gender = prefs.getString('gender');
    var society = prefs.getString('society').replaceAll(' ', '_');
    var dob = prefs.getString('dob').replaceAll(' ', '_');

    // print("register gender ${gender == null ? "Male" : gender}");
    // print("register society $society");
    // print("register dob ${Jiffy(dob).format('do MMMM yyyy')}");

    await FirebaseMessaging.instance
        .subscribeToTopic(gender == null ? "Male" : gender);
    await FirebaseMessaging.instance.subscribeToTopic(society);
    await FirebaseMessaging.instance.subscribeToTopic(dob);
    // await FirebaseMessaging.instance
    //     .subscribeToTopic(Jiffy(dob).format('do MMMM yyyy'));

    // Navigator.pop(context);
    print(jsonData);
    if (jsonData['error'] == false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print("get token");
      print(jsonData['token']);
      prefs.setString(StringRes.token, jsonData['token']);
      prefs.setString("id", jsonData['id'].toString());
      print("====== REGISTER ID ======= + $jsonData['id']");
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, 'tabbar');
      });
    }
  } else {
    Fluttertoast.showToast(
        msg: "Something Went Wrong ",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
  }
}

void paidregister(int eventID, String eventName, BuildContext context,
    String startDate, String endDate, int noOfParticipants) async {
  showLoader(context);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');

  final response = await http.post(
    Uri.parse(ep.base_url + ep.participate),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "user_id": userId,
      "event_id": eventID.toString(),
      "no_of_participants": noOfParticipants,
      "start_date": startDate,
      "end_date": endDate,
    }),
  );
  print("-----------------------------${response}");
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    print(jsonData);
    showToast(
      jsonData['msg'].toString(),
    );

    Navigator.of(context, rootNavigator: false).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => ThankyouJoinACtivitiesScreen(
                "Your request for $eventName participation has been received. If more family members are keen to participate, please click on participate button again! .")),
        (route) => false);

    // Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(MaterialPageRoute(
    //     builder: (context) => ThankyouJoinACtivitiesScreen(
    //         "Your request for $eventName participation has been received. If more family members are keen to participate, please click on participate button again! ."))); //Seats will be alloted to you once it gets approved.")));

  } else {
    // showToast(
    //   "Something Went Wrong ",
    // );
    Navigator.pop(context);
  }
}

Future<AvailableSeatsResponseModel> availableSeat(
  int eventID,
  BuildContext context,
) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');

  print("=======API CALL=======>>>> + ${ep.base_url + ep.availableSeat}");
  print("=======eventID=======>>>> + ${eventID}");
  final response = await http.post(
    Uri.parse(ep.base_url + ep.availableSeat),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "event_id": eventID,
    }),
  );
  print("=======AvailableSeat response=======>>>> + ${response.body}");
  if (response.statusCode == 200) {
    print(
        "==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ==== ====");
    print(eventID);
    final availableSeatsResponseModel =
        availableSeatsResponseModelFromJson(response.body);
    return availableSeatsResponseModel;
  } else {
    return AvailableSeatsResponseModel();
  }
}

void pendingeventrequest(
  int eventID,
  // int adultCount,
  // int childCount,
  String eventName,
  // String dropdownvalueFortime,
  int totalseat,
  String startdate,
  String enddate,
  BuildContext context,
) async {
  print("hiiiii");

  showLoader(context);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');
  var dataa = startdate.trim();
  print("event id is $eventID");
  print("event name is $eventName");
  print("userId is $userId");
  print("start_date is ${dataa}werewrwer");
  print("end_date is ${enddate.trim()}sdfdsf");
  // var sdate = DateFormat('yyyy-MM-dd').format(DateTime.parse(startdate));
  final response = await http.post(
    Uri.parse(ep.base_url + ep.pendingrequest),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "user_id": userId,
      "event_id": eventID.toString(),
      // "no_of_adult": adultCount.toString(),
      // "no_of_child": childCount.toString(),
      // "multislot_time": dropdownvalueFortime.toString(),
      "no_of_participants": totalseat,
      "start_date":
          DateFormat('yyyy-MM-dd').format(DateTime.parse(startdate.trim())),
      "end_date":
          DateFormat('yyyy-MM-dd').format(DateTime.parse(enddate.trim()))
    }),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    print(jsonData);
    Fluttertoast.showToast(
        // msg: "All Seats are occupied we will contact you soon",
        msg: "All Slots are occupied we will contact you soon",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.amber, //ColorRes.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => SeatsBookedScreen(
            "Your request for $eventName participation has been on pending . All Seats are occupied we will contact you soon ."))); //Seats will be alloted to you once it gets approved.")));
  } else {
    Fluttertoast.showToast(
        msg: "Something Went Wrong ",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black, //ColorRes.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
  }
}

void sendfeedback(String feedback, BuildContext context) async {
  showLoader(context);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userId = prefs.getString('id');
  final response = await http.post(
    Uri.parse(ep.base_url + ep.sendfeedback),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "feedback": feedback,
      "user_id": userId,
    }),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    print(jsonData);
    print(jsonData["msg"]);
    Fluttertoast.showToast(
        msg: "Thank You For Your Feedback",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orange, //ColorRes.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    //Navigator.pop(context);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => FeedbackScreen()));
  } else {
    Fluttertoast.showToast(
        msg: "Something Went Wrong ",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black, //ColorRes.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
  }
}

Future<void> viewCountApi() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');
  final response = await http.get(Uri.parse(ep.base_url + ep.viewCount));
  print("view response ================ ${response.body}");
  if (response.statusCode == 200) {
    print('hit view count');
  } else {
    print('view count error');
  }
}

Future<void> clickCountApi(int bannerId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');
  final response = await http.get(
      Uri.parse(ep.base_url + ep.clickCount + "?id=" + bannerId.toString() + "&user_id=" + userId.toString()));
  print("banner response ================ ${response.statusCode}");
  print(ep.base_url + ep.clickCount + "?id=" + bannerId.toString() + "&user_id=" + userId.toString());
  if (response.statusCode == 200) {
    print('hit click count');   
  } else {
    print('click count error');
  }
}
