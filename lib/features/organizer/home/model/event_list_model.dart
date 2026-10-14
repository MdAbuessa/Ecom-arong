import 'dart:convert';

class EventListModel {
  bool? success;
  int? code;
  String? message;
  Data? data;
  String? timestamp;

  EventListModel({
    this.success,
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  EventListModel copyWith({
    bool? success,
    int? code,
    String? message,
    Data? data,
    String? timestamp,
  }) => EventListModel(
    success: success ?? this.success,
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
    timestamp: timestamp ?? this.timestamp,
  );

  factory EventListModel.fromRawJson(String str) =>
      EventListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EventListModel.fromJson(Map<String, dynamic> json) => EventListModel(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "data": data?.toJson(),
    "timestamp": timestamp,
  };
}

class Data {
  List<Event>? events;

  Data({this.events});

  Data copyWith({List<Event>? events}) => Data(events: events ?? this.events);

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    events: json["events"] == null
        ? []
        : List<Event>.from(json["events"]!.map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "events": events == null
        ? []
        : List<dynamic>.from(events!.map((x) => x.toJson())),
  };
}

class Event {
  String? slug;
  String? title;
  String? location;
  dynamic ticketPrice;
  String? status;
  DateTime? startDate;
  DateTime? endDate;
  int? totalParticipant;
  int? completeParcentage;

  Event({
    this.slug,
    this.title,
    this.location,
    this.ticketPrice,
    this.status,
    this.startDate,
    this.endDate,
    this.totalParticipant,
    this.completeParcentage,
  });

  Event copyWith({
    String? slug,
    String? title,
    String? location,
    dynamic ticketPrice,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    int? totalParticipant,
    int? completeParcentage,
  }) => Event(
    slug: slug ?? this.slug,
    title: title ?? this.title,
    location: location ?? this.location,
    ticketPrice: ticketPrice ?? this.ticketPrice,
    status: status ?? this.status,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    totalParticipant: totalParticipant ?? this.totalParticipant,
    completeParcentage: completeParcentage ?? this.completeParcentage,
  );

  factory Event.fromRawJson(String str) => Event.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    slug: json["slug"],
    title: json["title"],
    location: json["location"],
    ticketPrice: json["ticket_price"],
    status: json["status"],
    startDate: json["start_date"] == null
        ? null
        : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    totalParticipant: json["total_participant"],
    completeParcentage: json["complete_parcentage"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "title": title,
    "location": location,
    "ticket_price": ticketPrice,
    "status": status,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "total_participant": totalParticipant,
    "complete_parcentage": completeParcentage,
  };
}
