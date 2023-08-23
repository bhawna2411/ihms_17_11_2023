// To parse this JSON data, do
//
//     final socialModel = socialModelFromJson(jsonString);

import 'dart:convert';

SocialModel socialModelFromJson(String str) => SocialModel.fromJson(json.decode(str));

String socialModelToJson(SocialModel data) => json.encode(data.toJson());

class SocialModel {
    SocialModel({
        this.msg,
        this.error,
        this.data,
    });

    String msg;
    bool error;
    List<Datum> data;

    factory SocialModel.fromJson(Map<String, dynamic> json) => SocialModel(
        msg: json["msg"],
        error: json["error"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.facebook,
        this.instagram,
        this.youtube,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String facebook;
    String instagram;
    String youtube;
    DateTime createdAt;
    DateTime updatedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        youtube: json["youtube"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "facebook": facebook,
        "instagram": instagram,
        "youtube": youtube,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
