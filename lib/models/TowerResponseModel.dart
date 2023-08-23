// To parse this JSON data, do
//
//     final towerResponseModel = towerResponseModelFromJson(jsonString);

import 'dart:convert';

TowerResponseModel towerResponseModelFromJson(String str) =>
    TowerResponseModel.fromJson(json.decode(str));

String towerResponseModelToJson(TowerResponseModel data) =>
    json.encode(data.toJson());

class TowerResponseModel {
  TowerResponseModel({
    this.msg,
    this.error,
    this.data,
  });

  String msg;
  String error;
  List<TowerData> data;

  factory TowerResponseModel.fromJson(Map<String, dynamic> json) =>
      TowerResponseModel(
        msg: json["msg"] == null ? null : json["msg"],
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<TowerData>.from(
                json["data"].map((x) => TowerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TowerData {
  TowerData({
    this.id,
    this.societyId,
    this.name,
    this.status,
    this.deleteStatus,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int societyId;
  String name;
  String status;
  String deleteStatus;
  String rememberToken;
  String createdAt;
  String updatedAt;

  factory TowerData.fromJson(Map<String, dynamic> json) => TowerData(
        id: json["id"] == null ? null : json["id"],
        societyId: json["society_id"] == null ? null : json["society_id"],
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
        "name": name == null ? null : name,
        "status": status == null ? null : status,
        "delete_status": deleteStatus == null ? null : deleteStatus,
        "remember_token": rememberToken,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
