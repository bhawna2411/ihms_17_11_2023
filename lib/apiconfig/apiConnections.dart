import 'dart:async';
import 'dart:convert';
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
  final response = await http.get(Uri.parse(ep.base_url + ep.users));
  if (response.statusCode == 200) {
    final usersResponseModel = usersResponseModelFromJson(response.body);
    return usersResponseModel;
  } else {
    return UsersResponseModel();
  }
}

Future<EventsResponseModel> getEvents() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userId = prefs.getString('id');
  final response =
      await http.get(Uri.parse(ep.base_url + ep.event + "?user_id=" + userId));


  if (response.statusCode == 200) {
    try {
      final eventsResponseModel = eventsResponseModelFromJson(response.body);
      return eventsResponseModel;
    } catch (e) {
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

  if (response.statusCode == 200) {
    ClubsResponseModel clubsResponseModel =
        clubsResponseModelFromJson(response.body);
    return clubsResponseModel;
  } else {
    return ClubsResponseModel();
  }
}

Future<ServicesResponseModel> getServices() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userId = prefs.getString('id');

  final response = await http
      .get(Uri.parse(ep.base_url + ep.services + "?user_id=" + userId));
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
  if (response.statusCode == 200) {
    final amenitiesHistoryResponse =
        amenitiesHistoryResponseFromJson(response.body);

    return amenitiesHistoryResponse;
  } else {
    return AmenitiesHistoryResponse();
  }
}

Future<UserProfileResponseModel> userProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var userId = prefs.getString('id');
  final response =
      await http.get(Uri.parse(ep.base_url + ep.userProfile + userId));
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
  if (response.statusCode == 200) {
    final activitesResponseModel =
        activitiesResponseModelFromJson(response.body);
    return activitesResponseModel;
  } else {
    return ActivitiesResponseModel();
  }
}

Future<SocietyResponseModel> getSociety() async {
  final response = await http.get(Uri.parse(ep.base_url + ep.society));
  if (response.statusCode == 200) {
    final societyResponseModel = societyResponseModelFromJson(response.body);
    return societyResponseModel;
  } else {
    return SocietyResponseModel();
  }
}

Future<WhatsNewResponseModel> whatspdf() async {
  CircularProgressIndicator();
   SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');
  final response = await http.get(Uri.parse(ep.base_url + ep.whatsnew + "?user_id=" + userId));
  if (response.statusCode == 200) {
    final whatsNewResponseModel = whatsNewResponseModelFromJson(response.body);
    return whatsNewResponseModel;
  } else {
    return WhatsNewResponseModel();
  }
}

Future<List<TowerData>> getTower(String societyId) async {
  final response = await http.post(
    Uri.parse(ep.base_url + ep.tower),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "society_id": societyId,
    }),
  );
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
  if (response.statusCode == 200) {
    final socialModel = socialModelFromJson(response.body);
    return socialModel;
  } else {
    return SocialModel();
  }
}

Future<StaticPageResponseModel> staticpage() async {
  // CircularProgressIndicator();
  final response = await http.get(Uri.parse(ep.base_url + ep.static_page));
  if (response.statusCode == 200) {
    final staticPageResponseModel =
        staticPageResponseModelFromJson(response.body);
    return staticPageResponseModel;
  } else {
    return StaticPageResponseModel();
  }
}

Future<List<FlatData>> getFlat(String societyId, String towerId) async {
  final response = await http.post(
    Uri.parse(ep.base_url + ep.flat),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, dynamic>{"society_id": societyId, "tower_id": towerId}),
  );
  if (response.statusCode == 200) {
    final flatResponseModel = flatResponseModelFromJson(response.body);
    return flatResponseModel.data;
  } else {
    return [];
  }
}

void login(String mobile, String otp, BuildContext context) async {
  String token = await FirebaseMessaging.instance.getToken();

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

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
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
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    Fluttertoast.showToast(
        msg: jsonData['msg'].toString(),
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black, //ColorRes.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.pop(context);
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
    String socityName,
    String profession,
    String gender,
    String education,
    String areaOfInterest,
    int ihmsMembership,
    BuildContext context) async {
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
      "profession": profession,
      "gender": gender,
      "education": education,
      "area_of_interest": areaOfInterest,
      "ihms_membership": ihmsMembership
    }),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('society', socityName ?? "");
    Navigator.pushNamed(context, 'tabbar');
    showToast(jsonData['msg']);
  }
}

Future<bool> switchUserSociety(bool switchValue, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');
  var society = prefs.getString('tempsociety');

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
  var jsonData = json.decode(response.body);
  if (response.statusCode == 200) {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('updatedsociety');
    prefs.setString('updatedsociety', jsonData["data"] ?? "");

    updatedSociety.value = jsonData["data"] ?? "";
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
    }),
  );
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    if (jsonData['success'] == false) {
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
  if (response.statusCode == 200) {
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

  if (response.statusCode == 200) {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (context) => ThankyouJoinACtivitiesScreen(
            "Your request for $servicename service has been received. Our team will contact you shortly.")));
  }
}


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
  String token = await FirebaseMessaging.instance.getToken();

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

  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    Fluttertoast.showToast(
        msg: jsonData['msg'].toString(),
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black, //ColorRes.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);

    prefs.setString('gender', radiovaluegender == 0 ? "Male" : "Female");
    prefs.setString('society', jsonData["society"] ?? "");
    prefs.setString('tempSociety', jsonData["society"] ?? "");
    prefs.setString('dob', dobb);

    var gender = prefs.getString('gender');
    var society = prefs.getString('society').replaceAll(' ', '_');
    var dob = prefs.getString('dob').replaceAll(' ', '_');

    await FirebaseMessaging.instance.subscribeToTopic(gender == null ? "Male" : gender);
    await FirebaseMessaging.instance.subscribeToTopic(society);
    await FirebaseMessaging.instance.subscribeToTopic(dob);
    if (jsonData['error'] == false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(StringRes.token, jsonData['token']);
      prefs.setString("id", jsonData['id'].toString());
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
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    showToast(
      jsonData['msg'].toString(),
    );

    Navigator.of(context, rootNavigator: false).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => ThankyouJoinACtivitiesScreen(
                "Your request for $eventName participation has been received. If more family members are keen to participate, please click on participate button again! .")),
        (route) => false);

  } else {
    Navigator.pop(context);
  }
}

Future<AvailableSeatsResponseModel> availableSeat(
  int eventID,
  BuildContext context,
) async {
  final response = await http.post(
    Uri.parse(ep.base_url + ep.availableSeat),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "event_id": eventID,
    }),
  );
  if (response.statusCode == 200) {
    final availableSeatsResponseModel =
        availableSeatsResponseModelFromJson(response.body);
    return availableSeatsResponseModel;
  } else {
    return AvailableSeatsResponseModel();
  }
}

void pendingeventrequest(
  int eventID,
  String eventName,
  int totalseat,
  String startdate,
  String enddate,
  BuildContext context,
) async {
  showLoader(context);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('id');
  final response = await http.post(
    Uri.parse(ep.base_url + ep.pendingrequest),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "user_id": userId,
      "event_id": eventID.toString(),
      "no_of_participants": totalseat,
      "start_date":
          DateFormat('yyyy-MM-dd').format(DateTime.parse(startdate.trim())),
      "end_date":
          DateFormat('yyyy-MM-dd').format(DateTime.parse(enddate.trim()))
    }),
  );
  if (response.statusCode == 200) {
    Fluttertoast.showToast(
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
    Fluttertoast.showToast(
        msg: "Thank You For Your Feedback",
        toastLength: Toast.LENGTH_LONG,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orange, //ColorRes.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
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
  final response = await http.get(Uri.parse(ep.base_url + ep.viewCount));
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
  if (response.statusCode == 200) {
    print('hit click count');   
  } else {
    print('click count error');
  }
}
