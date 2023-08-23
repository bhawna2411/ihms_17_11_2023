// To parse this JSON data, do
//
//     final amenitiesResponseModel = amenitiesResponseModelFromJson(jsonString);

import 'dart:convert';

ServicesResponseModel servicesResponseModelFromJson(String str) =>
    ServicesResponseModel.fromJson(json.decode(str));

String servicesResponseModelToJson(ServicesResponseModel data) =>
    json.encode(data.toJson());

class ServicesResponseModel {
  ServicesResponseModel({
    this.msg,
    this.error,
    this.data,
  });

  String msg;
  bool error;
  List<Data> data;

  factory ServicesResponseModel.fromJson(Map<String, dynamic> json) =>
      ServicesResponseModel(
        msg: json["msg"],
        error: json["error"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  Data({
    this.id,
    this.name,
    this.image,
    this.icon,
    this.description,
  });

  int id;
  String name;
  String image;
  String icon;
  String description;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        icon: json["icon"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id":id,
        "name": name,
        "image": image,
        "icon": icon,
        "description": description,
      };
}
