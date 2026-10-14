import 'dart:convert';

class EventDetailsModel {
  bool? success;
  int? code;
  String? message;
  Data? data;
  String? timestamp;

  EventDetailsModel({
    this.success,
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  EventDetailsModel copyWith({
    bool? success,
    int? code,
    String? message,
    Data? data,
    String? timestamp,
  }) => EventDetailsModel(
    success: success ?? this.success,
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
    timestamp: timestamp ?? this.timestamp,
  );

  factory EventDetailsModel.fromRawJson(String str) =>
      EventDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) =>
      EventDetailsModel(
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
  String? slug;
  String? title;
  String? description;
  String? type;
  Category? category;
  String? distanceMeters;
  DateTime? startDate;
  DateTime? endDate;
  String? locationName;
  String? latitude;
  String? longitude;
  String? coverUrl;
  bool? autoAssignRaceBib;
  String? status;
  String? visibility;
  List<RequiredAttendeeInfo>? requiredAttendeeInfo;
  int? reminder;
  bool? hasRecurrence;
  Organization? organization;
  List<Ticket>? tickets;
  int? totalParticipant;
  int? completeParcentage;
  List<Section>? sections;

  Data({
    this.slug,
    this.title,
    this.description,
    this.type,
    this.category,
    this.distanceMeters,
    this.startDate,
    this.endDate,
    this.locationName,
    this.latitude,
    this.longitude,
    this.coverUrl,
    this.autoAssignRaceBib,
    this.status,
    this.visibility,
    this.requiredAttendeeInfo,
    this.reminder,
    this.hasRecurrence,
    this.organization,
    this.tickets,
    this.totalParticipant,
    this.completeParcentage,
    this.sections,
  });

  Data copyWith({
    String? slug,
    String? title,
    String? description,
    String? type,
    Category? category,
    String? distanceMeters,
    DateTime? startDate,
    DateTime? endDate,
    String? locationName,
    String? latitude,
    String? longitude,
    String? coverUrl,
    bool? autoAssignRaceBib,
    String? status,
    String? visibility,
    List<RequiredAttendeeInfo>? requiredAttendeeInfo,
    int? reminder,
    bool? hasRecurrence,
    Organization? organization,
    List<Ticket>? tickets,
    int? totalParticipant,
    int? completeParcentage,
    List<Section>? sections,
  }) => Data(
    slug: slug ?? this.slug,
    title: title ?? this.title,
    description: description ?? this.description,
    type: type ?? this.type,
    category: category ?? this.category,
    distanceMeters: distanceMeters ?? this.distanceMeters,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    locationName: locationName ?? this.locationName,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    coverUrl: coverUrl ?? this.coverUrl,
    autoAssignRaceBib: autoAssignRaceBib ?? this.autoAssignRaceBib,
    status: status ?? this.status,
    visibility: visibility ?? this.visibility,
    requiredAttendeeInfo: requiredAttendeeInfo ?? this.requiredAttendeeInfo,
    reminder: reminder ?? this.reminder,
    hasRecurrence: hasRecurrence ?? this.hasRecurrence,
    organization: organization ?? this.organization,
    tickets: tickets ?? this.tickets,
    totalParticipant: totalParticipant ?? this.totalParticipant,
    completeParcentage: completeParcentage ?? this.completeParcentage,
    sections: sections ?? this.sections,
  );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    slug: json["slug"],
    title: json["title"],
    description: json["description"],
    type: json["type"],
    category: json["category"] == null
        ? null
        : Category.fromJson(json["category"]),
    distanceMeters: json["distance_meters"],
    startDate: json["start_date"] == null
        ? null
        : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    locationName: json["location_name"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    coverUrl: json["cover_url"],
    autoAssignRaceBib: json["auto_assign_race_bib"],
    status: json["status"],
    visibility: json["visibility"],
    requiredAttendeeInfo: json["required_attendee_info"] == null
        ? []
        : List<RequiredAttendeeInfo>.from(
            json["required_attendee_info"]!.map(
              (x) => RequiredAttendeeInfo.fromJson(x),
            ),
          ),
    reminder: json["reminder"],
    hasRecurrence: json["has_recurrence"],
    organization: json["organization"] == null
        ? null
        : Organization.fromJson(json["organization"]),
    tickets: json["tickets"] == null
        ? []
        : List<Ticket>.from(json["tickets"]!.map((x) => Ticket.fromJson(x))),
    totalParticipant: json["total_participant"],
    completeParcentage: json["complete_parcentage"],
    sections: json["sections"] == null
        ? []
        : List<Section>.from(json["sections"]!.map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "title": title,
    "description": description,
    "type": type,
    "category": category?.toJson(),
    "distance_meters": distanceMeters,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "location_name": locationName,
    "latitude": latitude,
    "longitude": longitude,
    "cover_url": coverUrl,
    "auto_assign_race_bib": autoAssignRaceBib,
    "status": status,
    "visibility": visibility,
    "required_attendee_info": requiredAttendeeInfo == null
        ? []
        : List<dynamic>.from(requiredAttendeeInfo!.map((x) => x.toJson())),
    "reminder": reminder,
    "has_recurrence": hasRecurrence,
    "organization": organization?.toJson(),
    "tickets": tickets == null
        ? []
        : List<dynamic>.from(tickets!.map((x) => x.toJson())),
    "total_participant": totalParticipant,
    "complete_parcentage": completeParcentage,
    "sections": sections == null
        ? []
        : List<dynamic>.from(sections!.map((x) => x.toJson())),
  };
}

class Category {
  String? slug;
  String? name;

  Category({this.slug, this.name});

  Category copyWith({String? slug, String? name}) =>
      Category(slug: slug ?? this.slug, name: name ?? this.name);

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) =>
      Category(slug: json["slug"], name: json["name"]);

  Map<String, dynamic> toJson() => {"slug": slug, "name": name};
}

class Organization {
  String? slug;
  String? name;
  String? email;

  Organization({this.slug, this.name, this.email});

  Organization copyWith({String? slug, String? name, String? email}) =>
      Organization(
        slug: slug ?? this.slug,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  factory Organization.fromRawJson(String str) =>
      Organization.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Organization.fromJson(Map<String, dynamic> json) => Organization(
    slug: json["slug"],
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {"slug": slug, "name": name, "email": email};
}

class RequiredAttendeeInfo {
  String? key;
  String? type;
  String? label;
  List<String>? options;

  RequiredAttendeeInfo({this.key, this.type, this.label, this.options});

  RequiredAttendeeInfo copyWith({
    String? key,
    String? type,
    String? label,
    List<String>? options,
  }) => RequiredAttendeeInfo(
    key: key ?? this.key,
    type: type ?? this.type,
    label: label ?? this.label,
    options: options ?? this.options,
  );

  factory RequiredAttendeeInfo.fromRawJson(String str) =>
      RequiredAttendeeInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RequiredAttendeeInfo.fromJson(Map<String, dynamic> json) =>
      RequiredAttendeeInfo(
        key: json["key"],
        type: json["type"],
        label: json["label"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
    "key": key,
    "type": type,
    "label": label,
    "options": options == null
        ? []
        : List<dynamic>.from(options!.map((x) => x)),
  };
}

class Section {
  String? title;
  String? imageUrl;
  String? description;

  Section({this.title, this.imageUrl, this.description});

  Section copyWith({String? title, String? imageUrl, String? description}) =>
      Section(
        title: title ?? this.title,
        imageUrl: imageUrl ?? this.imageUrl,
        description: description ?? this.description,
      );

  factory Section.fromRawJson(String str) => Section.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    title: json["title"],
    imageUrl: json["image_url"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image_url": imageUrl,
    "description": description,
  };
}

class Ticket {
  int? id;
  String? name;
  String? price;
  int? quantity;
  bool? isFree;
  bool? isAccessOpen;
  bool? accessCodeEnabled;
  String? accessCode;
  int? minPerUser;
  int? maxPerUser;
  int? soldCount;

  Ticket({
    this.id,
    this.name,
    this.price,
    this.quantity,
    this.isFree,
    this.isAccessOpen,
    this.accessCodeEnabled,
    this.accessCode,
    this.minPerUser,
    this.maxPerUser,
    this.soldCount,
  });

  Ticket copyWith({
    int? id,
    String? name,
    String? price,
    int? quantity,
    bool? isFree,
    bool? isAccessOpen,
    bool? accessCodeEnabled,
    String? accessCode,
    int? minPerUser,
    int? maxPerUser,
    int? soldCount,
  }) => Ticket(
    id: id ?? this.id,
    name: name ?? this.name,
    price: price ?? this.price,
    quantity: quantity ?? this.quantity,
    isFree: isFree ?? this.isFree,
    isAccessOpen: isAccessOpen ?? this.isAccessOpen,
    accessCodeEnabled: accessCodeEnabled ?? this.accessCodeEnabled,
    accessCode: accessCode ?? this.accessCode,
    minPerUser: minPerUser ?? this.minPerUser,
    maxPerUser: maxPerUser ?? this.maxPerUser,
    soldCount: soldCount ?? this.soldCount,
  );

  factory Ticket.fromRawJson(String str) => Ticket.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    quantity: json["quantity"],
    isFree: json["is_free"],
    isAccessOpen: json["is_access_open"],
    accessCodeEnabled: json["access_code_enabled"],
    accessCode: json["access_code"],
    minPerUser: json["min_per_user"],
    maxPerUser: json["max_per_user"],
    soldCount: json["sold_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "quantity": quantity,
    "is_free": isFree,
    "is_access_open": isAccessOpen,
    "access_code_enabled": accessCodeEnabled,
    "access_code": accessCode,
    "min_per_user": minPerUser,
    "max_per_user": maxPerUser,
    "sold_count": soldCount,
  };
}
