import 'dart:convert';

class JoinClubModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    JoinClubModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    JoinClubModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        JoinClubModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory JoinClubModel.fromRawJson(String str) => JoinClubModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory JoinClubModel.fromJson(Map<String, dynamic> json) => JoinClubModel(
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
    bool? isJoined;

    Data({
        this.clubSlug,
        this.isJoined,
    });

    Data copyWith({
        String? clubSlug,
        bool? isJoined,
    }) => 
        Data(
            clubSlug: clubSlug ?? this.clubSlug,
            isJoined: isJoined ?? this.isJoined,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        clubSlug: json["club_slug"],
        isJoined: json["is_joined"],
    );

    Map<String, dynamic> toJson() => {
        "club_slug": clubSlug,
        "is_joined": isJoined,
    };
}
