import 'dart:convert';

class ChangePasswordModel {
    bool? success;
    int? code;
    String? message;
    List<dynamic>? data;
    String? timestamp;

    ChangePasswordModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    ChangePasswordModel copyWith({
        bool? success,
        int? code,
        String? message,
        List<dynamic>? data,
        String? timestamp,
    }) => 
        ChangePasswordModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory ChangePasswordModel.fromRawJson(String str) => ChangePasswordModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
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
