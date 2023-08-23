// To parse this JSON data, do
//
//     final eventHistoryResponseModel = eventHistoryResponseModelFromJson(jsonString);

import 'dart:convert';

EventHistoryResponseModel eventHistoryResponseModelFromJson(String str) =>
    EventHistoryResponseModel.fromJson(json.decode(str));

String eventHistoryResponseModelToJson(EventHistoryResponseModel data) =>
    json.encode(data.toJson());

class EventHistoryResponseModel {
  EventHistoryResponseModel({
    this.msg,
    this.error,
    this.data,
  });

  String msg;
  bool error;
  List<EventHistory> data;

  factory EventHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      EventHistoryResponseModel(
        msg: json["msg"] == null ? null : json["msg"],
        error: json["error"] == null ? null : json["error"],
        data: json["data"] == null
            ? null
            : List<EventHistory>.from(
                json["data"].map((x) => EventHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "msg": msg == null ? null : msg,
        "error": error == null ? null : error,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class EventHistory {
  EventHistory({
    this.id,
    this.userName,
    this.societyId,
    this.type,
    this.name,
    this.image,
    this.description,
    this.subtitle,
    this.priorityOrder,
    this.date,
    this.time,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.status,
    this.participateBtnStatus,
    this.deleteStatus,
    this.location,
    this.url,
    this.tags,
    this.multislot,
    // this.multislotTime,
    this.participants,
    this.numberOfSeatsAvailable,
    this.amountAdult,
    this.amountChild,
    this.tax,
    this.eventType,
    this.noOfChild,
    this.noOfAdult,
    this.eventJoinDate,
    this.ticket,
    this.amount,
    this.event_start_date,
    this.event_end_date,
    this.booking_id,
    this.multislotTime,
  });

  int id;
  String userName;
  String societyId;
  String type;
  String name;
  String image;
  String description;
  dynamic subtitle;
  int priorityOrder;
  String date;
  String time;
  DateTime startDate;
  DateTime endDate;
  String startTime;
  String endTime;
  String status;
  String participateBtnStatus;
  String deleteStatus;
  String location;
  String url;
  String tags;
  int multislot;
  // String multislotTime;
  // String participants;
  List<DatumParticipant> participants;
  String numberOfSeatsAvailable;
  String amountAdult;
  String amountChild;
  String tax;
  String eventType;
  String noOfChild;
  String noOfAdult;
  DateTime eventJoinDate;
  String ticket;
  int amount;
  String event_start_date;
  String event_end_date;
  int booking_id;
  List<MultislotTime> multislotTime;


  factory EventHistory.fromJson(Map<String, dynamic> json) => EventHistory(
        id: json["id"] == null ? null : json["id"],
        userName: json["user_name"] == null ? null : json["user_name"],
        societyId: json["society_id"] == null ? null : json["society_id"],
        type: json["type"] == null ? null : json["type"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        description: json["description"] == null ? null : json["description"],
        subtitle: json["subtitle"] == null ? null : json["subtitle"],
        priorityOrder:
            json["priority_order"] == null ? null : json["priority_order"],
        date: json["date"] == null ? null : json["date"],
        time: json["time"] == null ? null : json["time"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        status: json["status"] == null ? null : json["status"],
        participateBtnStatus: json["participate_btn_status"] == null
            ? null
            : json["participate_btn_status"],
        deleteStatus:
            json["delete_status"] == null ? null : json["delete_status"],
        location: json["location"] == null ? null : json["location"],
        url: json["url"] == null ? null : json["url"],
        tags: json["tags"] == null ? null : json["tags"],
        multislot: json["multislot"] == null ? null : json["multislot"],
        // multislotTime:
            // json["multislot_time"] == null ? null : json["multislot_time"],
        // participants:
        //     json["participants"] == null ? null : json["participants"],
        participants: json["participants"] == null ? [] : List<DatumParticipant>.from(json["participants"].map((x) => DatumParticipant.fromJson(x))),
        numberOfSeatsAvailable: json["number_of_seats_available"] == null
            ? null
            : json["number_of_seats_available"],
        amountAdult: json["amount_adult"] == null ? null : json["amount_adult"],
        amountChild: json["amount_child"] == null ? null : json["amount_child"],
        tax: json["tax"] == null ? null : json["tax"],
        eventType: json["event_type"] == null ? null : json["event_type"],
        noOfChild: json["no_of_child"] == null ? null : json["no_of_child"],
        noOfAdult: json["no_of_adult"] == null ? null : json["no_of_adult"],
        eventJoinDate: json["event_join_date"] == null
            ? null
            : DateTime.parse(json["event_join_date"]),
        ticket: json["ticket"] == null ? null : json["ticket"],
        amount: json["amount"] == null ? null : json["amount"],
        event_start_date: json["event_start_date"] == null ? null : json["event_start_date"],
        event_end_date: json["event_end_date"] == null ? null : json["event_end_date"],
        booking_id: json["booking_id"] == null ? null : json["booking_id"],
        multislotTime: List<MultislotTime>.from(json["multislot_time"].map((x) => MultislotTime.fromJson(x))),

      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_name": userName == null ? null : userName,
        "society_id": societyId == null ? null : societyId,
        "type": type == null ? null : type,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
        "description": description == null ? null : description,
        "subtitle": subtitle,
        "priority_order": priorityOrder == null ? null : priorityOrder,
        "date": date == null ? null : date,
        "time": time == null ? null : time,
        "start_date": startDate == null
            ? null
            : "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date": endDate == null
            ? null
            : "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
        "status": status == null ? null : status,
        "participate_btn_status":
            participateBtnStatus == null ? null : participateBtnStatus,
        "delete_status": deleteStatus == null ? null : deleteStatus,
        "location": location == null ? null : location,
        "url": url == null ? null : url,
        "tags": tags == null ? null : tags,
        "multislot": multislot == null ? null : multislot,
        // "multislot_time": multislotTime == null ? null : multislotTime,
        // "participants": participants == null ? null : participants,
        "participants": participants == null ? [] : List<dynamic>.from(participants.map((x) => x.toJson())),
        "number_of_seats_available":
            numberOfSeatsAvailable == null ? null : numberOfSeatsAvailable,
        "amount_adult": amountAdult == null ? null : amountAdult,
        "amount_child": amountChild == null ? null : amountChild,
        "tax": tax == null ? null : tax,
        "event_type": eventType == null ? null : eventType,
        "no_of_child": noOfChild == null ? null : noOfChild,
        "no_of_adult": noOfAdult == null ? null : noOfAdult,
        "event_join_date":
            eventJoinDate == null ? null : eventJoinDate.toIso8601String(),
            "event_start_date": event_start_date == null ? null : event_start_date,
            "event_end_date": event_end_date == null ? null : event_end_date,
            "booking_id": booking_id == null ? null : booking_id,
            "multislot_time": List<dynamic>.from(multislotTime.map((x) => x.toJson())),

      };
      
}
class MultislotTime {
    MultislotTime({
         this.startDate,
         this.endDate,
         this.participants,
         this.seatsAvailable,
    });

    DateTime startDate;
    DateTime endDate;
    List<MultislotTimeParticipant> participants;
    int seatsAvailable;

    factory MultislotTime.fromJson(Map<String, dynamic> json) => MultislotTime(
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        participants: List<MultislotTimeParticipant>.from(json["participants"].map((x) => MultislotTimeParticipant.fromJson(x))),
        seatsAvailable: json["seats_available"],
    );

    Map<String, dynamic> toJson() => {
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
        "seats_available": seatsAvailable,
    };
}

class MultislotTimeParticipant {
    MultislotTimeParticipant({
        this.mparticipantName,
        this.mamount,
    });

    String mparticipantName;
    String mamount;

    factory MultislotTimeParticipant.fromJson(Map<String, dynamic> json) => MultislotTimeParticipant(
        mparticipantName: json["mparticipant_name"],
        mamount: json["mamount"],
    );

    Map<String, dynamic> toJson() => {
        "mparticipant_name": mparticipantName,
        "mamount": mamount,
    };
}
class Participant {
    Participant({
        this.mparticipantName,
        this.mamount,
    });

    String mparticipantName;
    String mamount;

    factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        mparticipantName: json["mparticipant_name"],
        mamount: json["mamount"],
    );

    Map<String, dynamic> toJson() => {
        "mparticipant_name": mparticipantName,
        "mamount": mamount,
    };
    
}
class DatumParticipant {
    DatumParticipant({
        this.participantName,
        this.amount,
    });

    String participantName;
    String amount;

    factory DatumParticipant.fromJson(Map<String, dynamic> json) => DatumParticipant(
        participantName: json["participant_name"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "participant_name": participantName,
        "amount": amount,
    };
}