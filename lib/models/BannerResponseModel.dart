// To parse this JSON data, do
//
//     final bannerResponseModel = bannerResponseModelFromJson(jsonString);

import 'dart:convert';

BannerResponseModel bannerResponseModelFromJson(String str) => BannerResponseModel.fromJson(json.decode(str));

String bannerResponseModelToJson(BannerResponseModel data) => json.encode(data.toJson());

class BannerResponseModel {
    BannerResponseModel({
        this.msg,
        this.error,
        this.data,
    });

    String msg;
    bool error;
    List<BannerData> data;

    factory BannerResponseModel.fromJson(Map<String, dynamic> json) => BannerResponseModel(
        msg: json["msg"] == null ? null : json["msg"],
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null ? null : List<BannerData>.from(json["data"].map((x) => BannerData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "error": error == null ? null : error,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class BannerData {
    BannerData({
        this.id,
        this.image,
        this.sortOrder,
        this.url,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String image;
    int sortOrder;
    String url;
    DateTime createdAt;
    DateTime updatedAt;

    factory BannerData.fromJson(Map<String, dynamic> json) => BannerData(
        id: json["id"] == null ? null : json["id"],
        image: json["image"] == null ? null : json["image"],
        sortOrder: json["sort_order"] == null ? null : json["sort_order"],
        url: json["url"] == null ? null : json["url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "image": image == null ? null : image,
        "sort_order": sortOrder == null ? null : sortOrder,
        "url": url == null ? null : url,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}









// class BannerResponseModel {
//   BannerResponseModel({
//     this.msg,
//     this.error,
//     this.result,
//   });

//   String msg;
//   bool error;
//   List<Results> result;

//   factory BannerResponseModel.fromJson(Map<String, dynamic> json) =>
//       BannerResponseModel(
//         msg: json["msg"] == null ? null : json["msg"],
//         error: json["error"] == null ? null : json["error"],
//         result: json["result"] == null
//             ? null
//             : List<Results>.from(
//                 json["result"].map((x) => Results.fromJson(x))),
//       );

//   List<Results> get data => null;

//   Map<String, dynamic> toJson() => {
//         "msg": msg == null ? null : msg,
//         "error": error == null ? null : error,
//         "result": result == null
//             ? null
//             : List<dynamic>.from(result.map((x) => x.toJson())),
//       };
// }

// class Results {
//   Results({
//     this.id,
//     this.image,
//     this.sortOrder,
//     this.url,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   String image;
//   int sortOrder;
//   String url;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory Results.fromJson(Map<String, dynamic> json) => Results(
//         id: json["id"] == null ? null : json["id"],
//         image: json["image"] == null ? null : json["image"],
//         sortOrder: json["sort_order"] == null ? null : json["sort_order"],
//         url: json["url"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id == null ? null : id,
//         "image": image == null ? null : image,
//         "sort_order": sortOrder == null ? null : sortOrder,
//         "url": url == null ? null : url,
//         "created_at": createdAt == null ? null : createdAt.toIso8601String(),
//         "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
//       };
// }
