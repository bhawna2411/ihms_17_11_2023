// To parse this JSON data, do
//
//     final societyResponseModel = societyResponseModelFromJson(jsonString);

import 'dart:convert';

SocietyResponseModel societyResponseModelFromJson(String str) =>
    SocietyResponseModel.fromJson(json.decode(str));

String societyResponseModelToJson(SocietyResponseModel data) =>
    json.encode(data.toJson());

class SocietyResponseModel {
  SocietyResponseModel({
    this.msg,
    this.error,
    this.data,
  });

  String msg;
  bool error;
  List<SocietData> data;

  factory SocietyResponseModel.fromJson(Map<String, dynamic> json) =>
      SocietyResponseModel(
        msg: json["msg"] == null ? null : json["msg"],
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<SocietData>.from(
                json["data"].map((x) => SocietData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SocietData {
  SocietData({
    this.id,
    this.name,
    this.location,
    this.flats,
    this.towers,
    this.status,
    this.deleteStatus,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String location;
  int flats;
  int towers;
  String status;
  String deleteStatus;
  dynamic rememberToken;
  DateTime createdAt;
  DateTime updatedAt;

  factory SocietData.fromJson(Map<String, dynamic> json) => SocietData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        location: json["location"] == null ? null : json["location"],
        flats: json["flats"] == null ? null : json["flats"],
        towers: json["towers"] == null ? null : json["towers"],
        status: json["status"] == null ? null : json["status"],
        deleteStatus:
            json["delete_status"] == null ? null : json["delete_status"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "location": location == null ? null : location,
        "flats": flats == null ? null : flats,
        "towers": towers == null ? null : towers,
        "status": status == null ? null : status,
        "delete_status": deleteStatus == null ? null : deleteStatus,
        "remember_token": rememberToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
