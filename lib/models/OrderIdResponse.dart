// To parse this JSON data, do
//
//     final orderIdResponse = orderIdResponseFromJson(jsonString);

import 'dart:convert';

OrderIdResponse orderIdResponseFromJson(String str) => OrderIdResponse.fromJson(json.decode(str));

String orderIdResponseToJson(OrderIdResponse data) => json.encode(data.toJson());

class OrderIdResponse {
    OrderIdResponse({
        this.orderId,
        this.success,
        this.txnid,
    });

    String orderId;
    bool success;
    dynamic txnid;

    factory OrderIdResponse.fromJson(Map<String, dynamic> json) => OrderIdResponse(
        orderId: json["orderId"],
        success: json["success"],
        txnid: json["txnid"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "success": success,
        "txnid": txnid,
    };
}
