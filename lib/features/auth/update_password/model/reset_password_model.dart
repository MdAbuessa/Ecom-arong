import 'dart:convert';

class ResetPasswordModel {
  bool? success;
  int? code;
  String? message;
  String? timestamp;

  ResetPasswordModel({
    this.success,
    this.code,
    this.message,
    this.timestamp,
  });

  ResetPasswordModel copyWith({
    bool? success,
    int? code,
    String? message,
    String? timestamp,
  }) =>
      ResetPasswordModel(
        success: success ?? this.success,
        code: code ?? this.code,
        message: message ?? this.message,
        timestamp: timestamp ?? this.timestamp,
      );

  factory ResetPasswordModel.fromRawJson(String str) =>
      ResetPasswordModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordModel(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "timestamp": timestamp,
      };
}
