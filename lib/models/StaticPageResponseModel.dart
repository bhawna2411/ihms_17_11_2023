// To parse this JSON data, do
//
//     final staticPageResponseModel = staticPageResponseModelFromJson(jsonString);

import 'dart:convert';

StaticPageResponseModel staticPageResponseModelFromJson(String str) =>
    StaticPageResponseModel.fromJson(json.decode(str));

String staticPageResponseModelToJson(StaticPageResponseModel data) =>
    json.encode(data.toJson());

class StaticPageResponseModel {
  StaticPageResponseModel({
    this.msg,
    this.error,
    this.data,
  });

  String msg;
  bool error;
  List<Staticdata> data;

  factory StaticPageResponseModel.fromJson(Map<String, dynamic> json) =>
      StaticPageResponseModel(
        msg: json["msg"] == null ? null : json["msg"],
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<Staticdata>.from(
                json["data"].map((x) => Staticdata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Staticdata {
  Staticdata({
    this.id,
    this.aboutUs,
    this.privacyPolicy,
    this.tC,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String aboutUs;
  String privacyPolicy;
  String tC;
  DateTime createdAt;
  DateTime updatedAt;

  factory Staticdata.fromJson(Map<String, dynamic> json) => Staticdata(
        id: json["id"] == null ? null : json["id"],
        aboutUs: json["about_us"] == null ? null : json["about_us"],
        privacyPolicy:
            json["privacy_policy"] == null ? null : json["privacy_policy"],
        tC: json["t&c"] == null ? null : json["t&c"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "about_us": aboutUs == null ? null : aboutUs,
        "privacy_policy": privacyPolicy == null ? null : privacyPolicy,
        "t&c": tC == null ? null : tC,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
