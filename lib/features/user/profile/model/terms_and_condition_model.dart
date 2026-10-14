import 'dart:convert';

class TermsAndConditionModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    TermsAndConditionModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    TermsAndConditionModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        TermsAndConditionModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory TermsAndConditionModel.fromRawJson(String str) => TermsAndConditionModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TermsAndConditionModel.fromJson(Map<String, dynamic> json) => TermsAndConditionModel(
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
    String? title;
    String? content;

    Data({
        this.title,
        this.content,
    });

    Data copyWith({
        String? title,
        String? content,
    }) => 
        Data(
            title: title ?? this.title,
            content: content ?? this.content,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
    };
}
