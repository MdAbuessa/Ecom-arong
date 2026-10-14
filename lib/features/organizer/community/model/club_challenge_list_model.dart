import 'dart:convert';

class ClubChallengeListModel {
  bool? success;
  int? code;
  String? message;
  Data? data;
  String? timestamp;

  ClubChallengeListModel({
    this.success,
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  ClubChallengeListModel copyWith({
    bool? success,
    int? code,
    String? message,
    Data? data,
    String? timestamp,
  }) => ClubChallengeListModel(
    success: success ?? this.success,
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
    timestamp: timestamp ?? this.timestamp,
  );

  factory ClubChallengeListModel.fromRawJson(String str) =>
      ClubChallengeListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClubChallengeListModel.fromJson(Map<String, dynamic> json) =>
      ClubChallengeListModel(
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
  String? clubSlug;
  List<Challenge>? challenges;
  Pagination? pagination;

  Data({this.clubSlug, this.challenges, this.pagination});

  Data copyWith({
    String? clubSlug,
    List<Challenge>? challenges,
    Pagination? pagination,
  }) => Data(
    clubSlug: clubSlug ?? this.clubSlug,
    challenges: challenges ?? this.challenges,
    pagination: pagination ?? this.pagination,
  );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    clubSlug: json["club_slug"],
    challenges: json["challenges"] == null
        ? []
        : List<Challenge>.from(
            json["challenges"]!.map((x) => Challenge.fromJson(x)),
          ),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "club_slug": clubSlug,
    "challenges": challenges == null
        ? []
        : List<dynamic>.from(challenges!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Challenge {
  String? slug;
  String? title;
  String? goalType;
  String? goalValue;
  dynamic thumbnailUrl;
  DateTime? startDate;
  DateTime? endDate;
  int? totalCompleted;
  bool? isActive;
  String? shareLink;

  Challenge({
    this.slug,
    this.title,
    this.goalType,
    this.goalValue,
    this.thumbnailUrl,
    this.startDate,
    this.endDate,
    this.totalCompleted,
    this.isActive,
    this.shareLink,
  });

  Challenge copyWith({
    String? slug,
    String? title,
    String? goalType,
    String? goalValue,
    dynamic thumbnailUrl,
    DateTime? startDate,
    DateTime? endDate,
    int? totalCompleted,
    bool? isActive,
    String? shareLink,
  }) => Challenge(
    slug: slug ?? this.slug,
    title: title ?? this.title,
    goalType: goalType ?? this.goalType,
    goalValue: goalValue ?? this.goalValue,
    thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    totalCompleted: totalCompleted ?? this.totalCompleted,
    isActive: isActive ?? this.isActive,
    shareLink: shareLink ?? this.shareLink,
  );

  factory Challenge.fromRawJson(String str) =>
      Challenge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
    slug: json["slug"],
    title: json["title"],
    goalType: json["goal_type"],
    goalValue: json["goal_value"],
    thumbnailUrl: json["thumbnail_url"],
    startDate: json["start_date"] == null
        ? null
        : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    totalCompleted: json["total_completed"],
    isActive: json["is_active"],
    shareLink: json["share_link"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "title": title,
    "goal_type": goalType,
    "goal_value": goalValue,
    "thumbnail_url": thumbnailUrl,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "total_completed": totalCompleted,
    "is_active": isActive,
    "share_link": shareLink,
  };
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Pagination({this.currentPage, this.lastPage, this.perPage, this.total});

  Pagination copyWith({
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
  }) => Pagination(
    currentPage: currentPage ?? this.currentPage,
    lastPage: lastPage ?? this.lastPage,
    perPage: perPage ?? this.perPage,
    total: total ?? this.total,
  );

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
  };
}
