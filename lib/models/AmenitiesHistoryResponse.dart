// To parse this JSON data, do
//
//     final amenitiesHistoryResponse = amenitiesHistoryResponseFromJson(jsonString);

import 'dart:convert';

AmenitiesHistoryResponse amenitiesHistoryResponseFromJson(String str) => AmenitiesHistoryResponse.fromJson(json.decode(str));

String amenitiesHistoryResponseToJson(AmenitiesHistoryResponse data) => json.encode(data.toJson());

class AmenitiesHistoryResponse {
    String msg;
    bool error;
    List<AmenitiesHistory> data;

    AmenitiesHistoryResponse({
        this.msg,
        this.error,
        this.data,
    });

    factory AmenitiesHistoryResponse.fromJson(Map<String, dynamic> json) => AmenitiesHistoryResponse(
        msg: json["msg"],
        error: json["error"],
        data: json["data"] == null ? [] : List<AmenitiesHistory>.from(json["data"].map((x) => AmenitiesHistory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "msg": msg,
        "error": error,
        "data": data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AmenitiesHistory {
    String payType;
    String amenitiesName;
    String locaton;
    String slotStartTime;
    String slotEndTime;
    int bookingId;
     DateTime bookingDate;

    AmenitiesHistory({
        this.payType,
        this.amenitiesName,
        this.locaton,
        this.slotStartTime,
        this.slotEndTime,
        this.bookingId,
        this.bookingDate,
    });

    factory AmenitiesHistory.fromJson(Map<String, dynamic> json) => AmenitiesHistory(
        payType: json["pay_type"],
        amenitiesName: json["amenities_name"],
        locaton: json["Locaton"],
        slotStartTime: json["slot_start_time"],
        slotEndTime: json["slot_end_time"],
        bookingId: json["booking_id"],
        bookingDate: json["booking_date"] == null ? null : DateTime.parse(json["booking_date"]),
    );

    Map<String, dynamic> toJson() => {
        "pay_type": payType,
        "amenities_name": amenitiesName,
        "Locaton": locaton,
        "slot_start_time": slotStartTime,
        "slot_end_time": slotEndTime,
        "booking_id": bookingId,
    };
}

enum AmenitiesName {
    BANQUET,
    TEST
}

final amenitiesNameValues = EnumValues({
    "Banquet": AmenitiesName.BANQUET,
    "test": AmenitiesName.TEST
});

enum Locaton {
    FIRST_FLOOR_VIP_CLUB_GROUND_FLOOR_ELEVATE_CLUB,
    JAIPURT
}

final locatonValues = EnumValues({
    "First Floor, VIP Club \u000d\nGround Floor, Elevate Club": Locaton.FIRST_FLOOR_VIP_CLUB_GROUND_FLOOR_ELEVATE_CLUB,
    "jaipurt": Locaton.JAIPURT
});

enum PayType {
    NON_PAID
}

final payTypeValues = EnumValues({
    "non-paid": PayType.NON_PAID
});

enum SlotEndTime {
    EMPTY,
    THE_20230802300_PM,
    THE_20230807200
}

final slotEndTimeValues = EnumValues({
    "": SlotEndTime.EMPTY,
    "2023-08-02 3:00 PM": SlotEndTime.THE_20230802300_PM,
    "2023-08-07 2:00": SlotEndTime.THE_20230807200
});

enum SlotStartTime {
    EMPTY,
    THE_20230802200_PM,
    THE_20230807100
}

final slotStartTimeValues = EnumValues({
    "": SlotStartTime.EMPTY,
    "2023-08-02 2:00 PM": SlotStartTime.THE_20230802200_PM,
    "2023-08-07 1:00": SlotStartTime.THE_20230807100
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
