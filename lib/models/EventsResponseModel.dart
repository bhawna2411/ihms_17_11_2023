// To parse this JSON data, do
//
//     final eventsResponseModel = eventsResponseModelFromJson(jsonString);

import 'dart:convert';

EventsResponseModel eventsResponseModelFromJson(String str) =>
    EventsResponseModel.fromJson(json.decode(str));

String eventsResponseModelToJson(EventsResponseModel data) =>
    json.encode(data.toJson());

class EventsResponseModel {
  EventsResponseModel({
    this.msg,
    this.error,
    this.data,
    this.switchVal
  });

  String msg;
  bool error;
  List<EventData> data;
  int switchVal;

  factory EventsResponseModel.fromJson(Map<String, dynamic> json) =>
      EventsResponseModel(
        msg: json["msg"] == null ? null : json["msg"],
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<EventData>.from(
                json["data"].map((x) => EventData.fromJson(x))),
                switchVal: json["switchVal"] == null ? null : json["switchVal"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
            "switchVal": switchVal == null ? null : switchVal,
      };
}

class EventData {
  EventData({
    this.id,
    this.name,
    this.image,
    this.description,
    this.location,
    this.date,
    this.time,
    this.start_date,
    this.end_date,
    this.start_time,
    this.end_time,
    this.labal,
    this.value,
    this.splitImage,
    this.type,
    this.tags,
    this.multislotTime,
    this.amount,
    this.amount_adult,
    this.amount_child,
    this.number_of_seats_available,
    this.url,
    this.status,
    this.participate_btn_status,
    this.multislot,
    this.participants,
  });

  

  int id;
  String name;
  String image;
  String description;
  String location;
  String date;
  String time;
  String start_date;
  String end_date;
  String start_time;
  String end_time;
  String labal;
  String value;
  String type;
  List<String> splitImage;
  List<String> tags;
  List<MultislotTime> multislotTime;
  String amount;
  String amount_adult;
  String amount_child;
  String number_of_seats_available;
  String url;
  String status;
  String participate_btn_status;
  int multislot;
  List<Participants> participants;
 
  factory EventData.fromJson(Map<String, dynamic> json) => EventData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? '' : json["name"],
        image: json["image"] == null ? '' : json["image"],
        splitImage:
            json["image"].split(",") == null ? null : json["image"].split(","),
        description: json["description"] == null ? '' : json["description"],
        location: json["location"] == null ? '' : json["location"],
        date: json["date"] == null ? '' : json["date"],
        time: json["time"] == null ? '' : json["time"],
        start_date: json["start_date"] == null ? '' : json["start_date"],
        end_date: json["end_date"] == null ? '' : json["end_date"],
        start_time: json["start_time"] == null ? '' : json["start_time"],
        end_time: json["end_time"] == null ? '' : json["end_time"],
        labal: json["labal"] == null ? null : json["labal"],
        value: json["value"] == null ? null : json["value"],
        type: json["type"] == null ? '' : json["type"],
        amount: json["amount"] == null ? "" : json["amount"],
        amount_adult:
            json["amount_adult"] == null ? "" : json["amount_adult"],
        amount_child:
            json["amount_child"] == null ? "" : json["amount_child"],
        number_of_seats_available: json["number_of_seats_available"] == null
            ? ""
            : json["number_of_seats_available"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"].map((x) => x)),
          multislotTime: List<MultislotTime>.from(json["multislot_time"].map((x) => MultislotTime.fromJson(x))),
        url: json["url"] == null ? '' : json["url"],
        status: json["status"] == null ? '1' : json["status"],
        participate_btn_status: json["participate_btn_status"] == null
            ? '1'
            : json["participate_btn_status"],
        multislot: json["multislot"] == null ? 0 : json["multislot"],
        participants: json["participants"] == null ? [] : List<Participants>.from(json["participants"].map((x) => Participants.fromJson(x))),
        
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? '' : name,
        "image": image == null ? '' : image,
        "description": description == null ? '' : description,
        "location": location == null ? '' : location,
        "date": date == null ? '' : date,
        "time": time == null ? '' : time,
        "start_date": start_date == null ? '' : start_date,
        "end_date": end_date == null ? '' : end_date,
        "start_time": start_time == null ? '' : start_time,
        "end_time": end_time == null ? '' : end_time,
        "labal": labal == null ? null : labal,
        "value": value == null ? null : value,
        "type": type == null ? "" : type,
        "amount": amount == null ? "" : amount,
        "amount_adult": amount_adult == null ? "" : amount_adult,
        "amount_child": amount_child == null ? "" : amount_child,
        "number_of_seats_available": number_of_seats_available == null
            ? ""
            : number_of_seats_available,
        "tags": tags == null ? [] : List<dynamic>.from(tags.map((x) => x)),
        "multislot_time": List<dynamic>.from(multislotTime.map((x) => x.toJson())),
        "url": url == null ? "" : url,
        "status": status == null ? "" : status,
        "participate_btn_status":
            participate_btn_status == null ? "" : participate_btn_status,
        "multislot": multislot == null ? 0 : multislot,
        "participants": List<Participants>.from(participants.map((x) => x == null ? null : x.toJson())),
      };

  bool startsWith(String text) {}
}

class MultislotTime {
    MultislotTime({
        this.startDate,
        this.endDate,
        this.participants,
        this.seatsAvailable,
    });

    String startDate;
    String endDate;
    List<ParticipantElement> participants;
    int seatsAvailable;

    factory MultislotTime.fromJson(Map<String, dynamic> json) => MultislotTime(
        startDate: json["start_date"],
        endDate: json["end_date"],
        participants: List<ParticipantElement>.from(json["participants"].map((x) => ParticipantElement.fromJson(x))),
        seatsAvailable: json["seats_available"],
    );

    Map<String, dynamic> toJson() => {
        "start_date": startDate,
        "end_date": endDate,
        "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
        "seats_available": seatsAvailable,
    };
}

class Participants {
    Participants({
        this.participantName,
        this.amount,
        this.totalseats,
    });

    String participantName;
    String amount;
    int totalseats;

    factory Participants.fromJson(Map<String, dynamic> json) => Participants(
        participantName: json["participant_name"],
        amount: json["amount"] == null ? "0" : json["amount"],
        totalseats : 0
    );

    Map<String, dynamic> toJson() => {
        "participant_name": participantName,
        "amount": amount == null ? "0" : amount,
    };
}

class ParticipantElement {
    ParticipantElement({
        this.mparticipantName,
        this.mamount,
        this.quantity,
    });

    String mparticipantName;
    String mamount;
    int quantity;

    factory ParticipantElement.fromJson(Map<String, dynamic> json) => ParticipantElement(
        mparticipantName: json["mparticipant_name"],
        mamount: json["mamount"] == null ? "0" : json["mamount"],
        quantity: 0,
    );

    Map<String, dynamic> toJson() => {
        "mparticipant_name": mparticipantName,
        "mamount": mamount == null ? "0" : mamount,
        // "quantity": quantity,
    };
}

