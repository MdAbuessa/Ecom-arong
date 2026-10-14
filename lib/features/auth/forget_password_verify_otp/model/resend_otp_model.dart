import 'dart:convert';

class ResennOtpModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    ResennOtpModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    ResennOtpModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        ResennOtpModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory ResennOtpModel.fromRawJson(String str) => ResennOtpModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResennOtpModel.fromJson(Map<String, dynamic> json) => ResennOtpModel(
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
    String? otpToken;

    Data({
        this.otpToken,
    });

    Data copyWith({
        String? otpToken,
    }) => 
        Data(
            otpToken: otpToken ?? this.otpToken,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        otpToken: json["otp_token"],
    );

    Map<String, dynamic> toJson() => {
        "otp_token": otpToken,
    };
}
