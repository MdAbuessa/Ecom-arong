import 'dart:convert';

class DeleteAccountModel {
    bool? success;
    int? code;
    String? message;
    List<dynamic>? data;
    String? timestamp;

    DeleteAccountModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    DeleteAccountModel copyWith({
        bool? success,
        int? code,
        String? message,
        List<dynamic>? data,
        String? timestamp,
    }) => 
        DeleteAccountModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory DeleteAccountModel.fromRawJson(String str) => DeleteAccountModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DeleteAccountModel.fromJson(Map<String, dynamic> json) => DeleteAccountModel(
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
