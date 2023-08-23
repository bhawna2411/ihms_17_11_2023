// To parse this JSON data, do
//
//     final flatResponseModel = flatResponseModelFromJson(jsonString);

import 'dart:convert';

FlatResponseModel flatResponseModelFromJson(String str) =>
    FlatResponseModel.fromJson(json.decode(str));

String flatResponseModelToJson(FlatResponseModel data) =>
    json.encode(data.toJson());

class FlatResponseModel {
  FlatResponseModel({
    this.msg,
    this.error,
    this.data,
  });

  String msg;
  String error;
  List<FlatData> data;

  factory FlatResponseModel.fromJson(Map<String, dynamic> json) =>
      FlatResponseModel(
        msg: json["msg"] == null ? null : json["msg"],
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<FlatData>.from(
                json["data"].map((x) => FlatData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FlatData {
  FlatData({
    this.id,
    this.societyId,
    this.towerId,
    this.name,
    this.status,
    this.deleteStatus,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int societyId;
  int towerId;
  String name;
  String status;
  String deleteStatus;
  String rememberToken;
  String createdAt;
  String updatedAt;

  factory FlatData.fromJson(Map<String, dynamic> json) => FlatData(
        id: json["id"] == null ? null : json["id"],
        societyId: json["society_id"] == null ? null : json["society_id"],
        towerId: json["tower_id"] == null ? null : json["tower_id"],
        name: json["name"] == null ? null : json["name"],
        status: json["status"] == null ? null : json["status"],
        deleteStatus:
            json["delete_status"] == null ? null : json["delete_status"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "society_id": societyId == null ? null : societyId,
        "tower_id": towerId == null ? null : towerId,
        "name": name == null ? null : name,
        "status": status == null ? null : status,
        "delete_status": deleteStatus == null ? null : deleteStatus,
        "remember_token": rememberToken,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
