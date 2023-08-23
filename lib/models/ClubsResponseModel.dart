// To parse this JSON data, do
//
//     final clubsResponseModel = clubsResponseModelFromJson(jsonString);

import 'dart:convert';

ClubsResponseModel clubsResponseModelFromJson(String str) =>
    ClubsResponseModel.fromJson(json.decode(str));

String clubsResponseModelToJson(ClubsResponseModel data) =>
    json.encode(data.toJson());

class ClubsResponseModel {
  ClubsResponseModel({
    this.msg,
    this.error,
    this.data,
  });

  String msg;
  String error;
  List<Datumclub> data;

  factory ClubsResponseModel.fromJson(Map<String, dynamic> json) =>
      ClubsResponseModel(
        msg: json["msg"],
        error: json["error"],
        data: List<Datumclub>.from(
            json["data"].map((x) => Datumclub.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datumclub {
  Datumclub({
    this.id,
    this.icon,
    this.name,
    this.shortDescription,
    this.backgroundImage,
    this.about,
    this.gallery,
    this.location,
    this.phone,
    this.learn_more,
    this.url,
  });

  int id;
  String icon;
  String name;
  String shortDescription;
  String backgroundImage;
  String about;
  List<String> gallery;
  String location;
  String phone;
  int learn_more;
  String url;
  factory Datumclub.fromJson(Map<String, dynamic> json) => Datumclub(
      id: json["id"],
      icon: json["icon"],
      name: json["name"],
      shortDescription: json["short_description"],
      backgroundImage: json["background_image"],
      about: json["about"],
      gallery: List<String>.from(json["gallery"].map((x) => x)),
      location: json["location"],
      phone: json["phone"] == null ? null : json["phone"],
      learn_more: json["learn_more"],
      url: json["url"] == null ? null : json["url"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "icon": icon,
        "name": name,
        "short_description": shortDescription,
        "background_image": backgroundImage,
        "about": about,
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "location": location,
        "phone": phone == null ? null : phone,
        "learn_more": learn_more,
        "url": url
      };
}
