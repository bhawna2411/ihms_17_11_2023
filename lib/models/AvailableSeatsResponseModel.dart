// To parse this JSON data, do
//
//     final availableSeatsResponseModel = availableSeatsResponseModelFromJson(jsonString);

import 'dart:convert';

AvailableSeatsResponseModel availableSeatsResponseModelFromJson(String str) => AvailableSeatsResponseModel.fromJson(json.decode(str));

String availableSeatsResponseModelToJson(AvailableSeatsResponseModel data) => json.encode(data.toJson());

class AvailableSeatsResponseModel {
    AvailableSeatsResponseModel({
        this.msg,
        this.error,
        this.data,
    });

    String msg;
    String error;
    List<AvailableSeat> data;

    factory AvailableSeatsResponseModel.fromJson(Map<String, dynamic> json) => AvailableSeatsResponseModel(
        msg: json["msg"],
        error: json["error"],
        data: List<AvailableSeat>.from(json["data"].map((x) => AvailableSeat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AvailableSeat {
    AvailableSeat({
        this.numberOfSeatsAvailable,
    });

    String numberOfSeatsAvailable;

    factory AvailableSeat.fromJson(Map<String, dynamic> json) => AvailableSeat(
        numberOfSeatsAvailable: json["number_of_seats_available"],
    );

    Map<String, dynamic> toJson() => {
        "number_of_seats_available": numberOfSeatsAvailable,
    };
}
