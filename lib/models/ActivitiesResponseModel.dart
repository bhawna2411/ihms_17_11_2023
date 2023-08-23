// To parse this JSON data, do
//
//     final activitiesResponseModel = activitiesResponseModelFromJson(jsonString);

import 'dart:convert';

ActivitiesResponseModel activitiesResponseModelFromJson(String str) => ActivitiesResponseModel.fromJson(json.decode(str));

String activitiesResponseModelToJson(ActivitiesResponseModel data) => json.encode(data.toJson());

class ActivitiesResponseModel {
    ActivitiesResponseModel({
        this.msg,
        this.error,
        this.data,
    });

    String msg;
    bool error;
    List<Result> data;

    factory ActivitiesResponseModel.fromJson(Map<String, dynamic> json) => ActivitiesResponseModel(
        msg: json["msg"] == null ? null : json["msg"],
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : List<Result>.from(json["data"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "error": error == null ? null : error,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        this.id,
        this.name,
        this.image,
        this.icon,
        this.description,
        this.url,
        this.location,
        this.showtags,
    });

    int id;
    String name;
    String image;
    String icon;
    String description;
    String url;
    String location;
    List<String> showtags;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        icon: json["icon"] == null ? null : json["icon"],
        description: json["description"] == null ? null : json["description"],
        url: json["url"] == null ? null : json["url"],
        location: json["location"] == null ? null : json["location"],
        showtags: json["showtags"] == null ? null : List<String>.from(json["showtags"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
        "icon": icon == null ? null : icon,
        "description": description == null ? null : description,
        "url": url == null ? null : url,
        "location": location == null ? null : location,
        "showtags": showtags == null ? null : List<dynamic>.from(showtags.map((x) => x)),
    };
}










// // To parse this JSON data, do
// //
// //     final amenitiesResponseModel = amenitiesResponseModelFromJson(jsonString);

// import 'dart:convert';

// ActivitiesResponseModel activitiesResponseModelFromJson(String str) =>
//     ActivitiesResponseModel.fromJson(json.decode(str));

// String activitiesResponseModelToJson(ActivitiesResponseModel data) =>
//     json.encode(data.toJson());

// class ActivitiesResponseModel {
//   ActivitiesResponseModel({
//     this.msg,
//     this.error,
//     this.data,
//   });

//   String msg;
//   bool error;
//   List<Result> data;

//   factory ActivitiesResponseModel.fromJson(Map<String, dynamic> json) =>
//       ActivitiesResponseModel(
//         msg: json["msg"],
//         error: json["error"],
//         data: List<Result>.from(json["data"].map((x) => Result.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "msg": msg,
//         "error": error,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class Result {
//   Result(
//       {this.name,
//       this.image,
//       this.icon,
//       this.description,
//       this.location,
//       this.url});

//   String name;
//   String image;
//   String icon;
//   String description;
//   String location;
//   String url;

//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//       name: json["name"],
//       image: json["image"],
//       icon: json["icon"],
//       description: json["description"],
//       location: json["location"],
//       url: json["url"]);

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "image": image,
//         "icon": icon,
//         "description": description,
//         "location": location,
//         "url": url,
//       };
// }
