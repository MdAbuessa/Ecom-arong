import 'dart:convert';

class ClubCategoryListModel {
    bool? success;
    int? code;
    String? message;
    List<Datum>? data;
    String? timestamp;

    ClubCategoryListModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    ClubCategoryListModel copyWith({
        bool? success,
        int? code,
        String? message,
        List<Datum>? data,
        String? timestamp,
    }) => 
        ClubCategoryListModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory ClubCategoryListModel.fromRawJson(String str) => ClubCategoryListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ClubCategoryListModel.fromJson(Map<String, dynamic> json) => ClubCategoryListModel(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "timestamp": timestamp,
    };
}

class Datum {
    String? slug;
    String? name;

    Datum({
        this.slug,
        this.name,
    });

    Datum copyWith({
        String? slug,
        String? name,
    }) => 
        Datum(
            slug: slug ?? this.slug,
            name: name ?? this.name,
        );

    factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        slug: json["slug"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
    };
}
