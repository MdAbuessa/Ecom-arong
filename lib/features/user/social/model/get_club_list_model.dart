import 'dart:convert';

class GetClubListModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    GetClubListModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    GetClubListModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        GetClubListModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory GetClubListModel.fromRawJson(String str) => GetClubListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetClubListModel.fromJson(Map<String, dynamic> json) => GetClubListModel(
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
    List<Club>? clubs;
    Pagination? pagination;

    Data({
        this.clubs,
        this.pagination,
    });

    Data copyWith({
        List<Club>? clubs,
        Pagination? pagination,
    }) => 
        Data(
            clubs: clubs ?? this.clubs,
            pagination: pagination ?? this.pagination,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        clubs: json["clubs"] == null ? [] : List<Club>.from(json["clubs"]!.map((x) => Club.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "clubs": clubs == null ? [] : List<dynamic>.from(clubs!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
    };
}

class Club {
    String? slug;
    String? name;
    String? description;
    String? avatarUrl;
    String? location;
    int? totalMembers;
    Topic? topic;
    bool? isJoined;

    Club({
        this.slug,
        this.name,
        this.description,
        this.avatarUrl,
        this.location,
        this.totalMembers,
        this.topic,
        this.isJoined,
    });

    Club copyWith({
        String? slug,
        String? name,
        String? description,
        String? avatarUrl,
        String? location,
        int? totalMembers,
        Topic? topic,
        bool? isJoined,
    }) => 
        Club(
            slug: slug ?? this.slug,
            name: name ?? this.name,
            description: description ?? this.description,
            avatarUrl: avatarUrl ?? this.avatarUrl,
            location: location ?? this.location,
            totalMembers: totalMembers ?? this.totalMembers,
            topic: topic ?? this.topic,
            isJoined: isJoined ?? this.isJoined,
        );

    factory Club.fromRawJson(String str) => Club.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Club.fromJson(Map<String, dynamic> json) => Club(
        slug: json["slug"],
        name: json["name"],
        description: json["description"],
        avatarUrl: json["avatar_url"],
        location: json["location"],
        totalMembers: json["total_members"],
        topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
        isJoined: json["is_joined"],
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "description": description,
        "avatar_url": avatarUrl,
        "location": location,
        "total_members": totalMembers,
        "topic": topic?.toJson(),
        "is_joined": isJoined,
    };
}

class Topic {
    String? slug;
    String? name;

    Topic({
        this.slug,
        this.name,
    });

    Topic copyWith({
        String? slug,
        String? name,
    }) => 
        Topic(
            slug: slug ?? this.slug,
            name: name ?? this.name,
        );

    factory Topic.fromRawJson(String str) => Topic.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        slug: json["slug"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
    };
}

class Pagination {
    int? currentPage;
    int? lastPage;
    int? perPage;
    int? total;

    Pagination({
        this.currentPage,
        this.lastPage,
        this.perPage,
        this.total,
    });

    Pagination copyWith({
        int? currentPage,
        int? lastPage,
        int? perPage,
        int? total,
    }) => 
        Pagination(
            currentPage: currentPage ?? this.currentPage,
            lastPage: lastPage ?? this.lastPage,
            perPage: perPage ?? this.perPage,
            total: total ?? this.total,
        );

    factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

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
