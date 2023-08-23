// To parse this JSON data, do
//
//     final serviceHistoryResponseModel = serviceHistoryResponseModelFromJson(jsonString);

import 'dart:convert';

ServiceHistoryResponseModel serviceHistoryResponseModelFromJson(String str) => ServiceHistoryResponseModel.fromJson(json.decode(str));

String serviceHistoryResponseModelToJson(ServiceHistoryResponseModel data) => json.encode(data.toJson());

class ServiceHistoryResponseModel {
    String msg;
    bool error;
    List<ServiceHistory> data;

    ServiceHistoryResponseModel({
        this.msg,
        this.error,
        this.data,
    });

    factory ServiceHistoryResponseModel.fromJson(Map<String, dynamic> json) => ServiceHistoryResponseModel(
        msg: json["msg"],
        error: json["error"],
        data: json["data"] == null ? [] : List<ServiceHistory>.from(json["data"].map((x) => ServiceHistory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "error": error,
        "data": data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ServiceHistory {
    String conciergeservicesName;
    int bookingId;
    DateTime bookingDate;

    ServiceHistory({
        this.conciergeservicesName,
        this.bookingId,
        this.bookingDate,
    });

    factory ServiceHistory.fromJson(Map<String, dynamic> json) => ServiceHistory(
        conciergeservicesName: json["conciergeservices_name"] == null ? "" : json["conciergeservices_name"],
        bookingId: json["booking_id"],
        bookingDate: json["booking_date"] == null ? null : DateTime.parse(json["booking_date"]),
    );

    Map<String, dynamic> toJson() => {
        "conciergeservices_name": conciergeservicesName == null ? "" : conciergeservicesName,
        "booking_id": bookingId,
        "booking_date": bookingDate?.toIso8601String(),
    };
}
