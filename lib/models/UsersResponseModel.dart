// To parse this JSON result, do
//
//     final usersResponseModel = usersResponseModelFromJson(jsonString);

import 'dart:convert';

UsersResponseModel usersResponseModelFromJson(String str) =>
    UsersResponseModel.fromJson(json.decode(str));

String usersResponseModelToJson(UsersResponseModel result) =>
    json.encode(result.toJson());

class UsersResponseModel {
  UsersResponseModel({
    this.msg,
    this.error,
    this.result,
  });

  String msg;
  bool error;
  List<Result> result;

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) =>
      UsersResponseModel(
        msg: json["msg"] == null ? null : json["msg"],
        error: json["error"] == null ? null : json["error"],
        result: json["result"] == null
            ? null
            : List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "error": error == null ? null : error,
        "result": result == null
            ? null
            : List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.gender,
    this.society,
    this.towerNumber,
    this.flatNumber,
    this.emailVerifiedAt,
    this.otp,
    this.otpVerifyStatus,
    this.status,
    this.userType,
    this.password,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.adminVerify,
    this.deleteStatus,
  });

  int id;
  String name;
  String email;
  String mobile;
  dynamic gender;
  String society;
  String towerNumber;
  String flatNumber;
  dynamic emailVerifiedAt;
  dynamic otp;
  String otpVerifyStatus;
  String status;
  String userType;
  dynamic password;
  dynamic rememberToken;
  DateTime createdAt;
  DateTime updatedAt;
  String adminVerify;
  String deleteStatus;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        gender: json["gender"],
        society: json["society"] == null ? null : json["society"],
        towerNumber: json["tower_number"] == null ? null : json["tower_number"],
        flatNumber: json["flat_number"] == null ? null : json["flat_number"],
        emailVerifiedAt: json["email_verified_at"],
        otp: json["otp"],
        otpVerifyStatus: json["otp_verify_status"] == null
            ? null
            : json["otp_verify_status"],
        status: json["status"] == null ? null : json["status"],
        userType: json["user_type"] == null ? null : json["user_type"],
        password: json["password"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        adminVerify: json["admin_verify"] == null ? null : json["admin_verify"],
        deleteStatus:
            json["delete_status"] == null ? null : json["delete_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "mobile": mobile == null ? null : mobile,
        "gender": gender,
        "society": society == null ? null : society,
        "tower_number": towerNumber == null ? null : towerNumber,
        "flat_number": flatNumber == null ? null : flatNumber,
        "email_verified_at": emailVerifiedAt,
        "otp": otp,
        "otp_verify_status": otpVerifyStatus == null ? null : otpVerifyStatus,
        "status": status == null ? null : status,
        "user_type": userType == null ? null : userType,
        "password": password,
        "remember_token": rememberToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "admin_verify": adminVerify == null ? null : adminVerify,
        "delete_status": deleteStatus == null ? null : deleteStatus,
      };
}
