// To parse this JSON data, do
//
//     final amenitiesResponseModel = amenitiesResponseModelFromJson(jsonString);

import 'dart:convert';

AmenitiesResponseModel amenitiesResponseModelFromJson(String str) =>
    AmenitiesResponseModel.fromJson(json.decode(str));

String amenitiesResponseModelToJson(AmenitiesResponseModel data) =>
    json.encode(data.toJson());

class AmenitiesResponseModel {
  AmenitiesResponseModel({
    this.msg,
    this.error,
    this.data,
  });

  String msg;
  bool error;
  List<Datumm> data;

  factory AmenitiesResponseModel.fromJson(Map<String, dynamic> json) =>
      AmenitiesResponseModel(
        msg: json["msg"],
        error: json["error"],
        data: List<Datumm>.from(json["data"].map((x) => Datumm.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datumm {
  Datumm({
    this.id,
    this.name,
    this.image,
    this.icon,
    this.description,
    this.location,
    this.amenityPayType,
    this.bookingType,
    this.slot
  });

  int id;
  String name;
  String image;
  String icon;
  String description;
  String location;
  String amenityPayType;
  String bookingType;
  List<SlotElement> slot;

  factory Datumm.fromJson(Map<String, dynamic> json) => Datumm(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        icon: json["icon"],
        description: json["description"],
        location: json["location"],
        amenityPayType: json["amenity_pay_type"] == "" ?  "none" :  json["amenity_pay_type"] == null ? "none" : json["amenity_pay_type"] ,
        bookingType: json["booking_type"] == "" ? "Single" : json["booking_type"] == "" ? "Single" : json["booking_type"],
        slot:  json["slot"] == null ? [] : List<SlotElement>.from(json["slot"].map((x) => SlotElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id":id,
        "name": name,
        "image": image,
        "icon": icon,
        "description": description,
        "location": location,
        "amenityPayType": amenityPayType == "" ? "none" : amenityPayType == null ? "none" :amenityPayType,
        "bookingType": bookingType == "" ? "Single" : bookingType == null ? "Single" : bookingType,
        "slot": List<SlotElement>.from(slot.map((x) => x == null ? null : x.toJson())),

      };
}

class SlotElement {
    String multislotStarttime;
    String multislotEndtime;
    String multislotNumberofseats;
    String multislotAmount;
    bool checkbox;

    SlotElement({
        this.multislotStarttime,
        this.multislotEndtime,
        this.multislotNumberofseats,
        this.multislotAmount,
        this.checkbox
    });

    factory SlotElement.fromJson(Map<String, dynamic> json) => SlotElement(
        multislotStarttime: json["multislot_starttime"] == null ? "" : json["multislot_starttime"],
        multislotEndtime: json["multislot_endtime"] == null ? "" : json["multislot_endtime"],
        multislotNumberofseats: json["multislot_numberofseats"] == null ? "" : json["multislot_numberofseats"],
        multislotAmount: json["multislot_amount"]  == null ? "" : json["multislot_amount"],
        checkbox: false
    );

    Map<String, dynamic> toJson() => {
        "multislot_starttime": multislotStarttime == null ? "" : multislotStarttime,
        "multislot_endtime": multislotEndtime == null ? "" : multislotEndtime,
        "multislot_numberofseats": multislotNumberofseats == null ? "" : multislotNumberofseats,
        "multislot_amount": multislotAmount == null ? "" : multislotAmount,
        "checkbox": false
    };
}
