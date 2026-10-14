import 'dart:convert';

class ClubDeleteModel {
    bool? success;
    int? code;
    String? message;
    List<dynamic>? data;
    String? timestamp;

    ClubDeleteModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    ClubDeleteModel copyWith({
        bool? success,
        int? code,
        String? message,
        List<dynamic>? data,
        String? timestamp,
    }) => 
        ClubDeleteModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory ClubDeleteModel.fromRawJson(String str) => ClubDeleteModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ClubDeleteModel.fromJson(Map<String, dynamic> json) => ClubDeleteModel(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "timestamp": timestamp,
    };
}
