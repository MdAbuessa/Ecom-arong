import 'dart:convert';

class RegisterModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    RegisterModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    RegisterModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        RegisterModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory RegisterModel.fromRawJson(String str) => RegisterModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
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
    User? user;
    String? otpToken;

    Data({
        this.user,
        this.otpToken,
    });

    Data copyWith({
        User? user,
        String? otpToken,
    }) => 
        Data(
            user: user ?? this.user,
            otpToken: otpToken ?? this.otpToken,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        otpToken: json["otp_token"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "otp_token": otpToken,
    };
}

class User {
    String? username;
    String? firstName;
    String? email;
    dynamic role;
    String? avatar;

    User({
        this.username,
        this.firstName,
        this.email,
        this.role,
        this.avatar,
    });

    User copyWith({
        String? username,
        String? firstName,
        String? email,
        dynamic role,
        String? avatar,
    }) => 
        User(
            username: username ?? this.username,
            firstName: firstName ?? this.firstName,
            email: email ?? this.email,
            role: role ?? this.role,
            avatar: avatar ?? this.avatar,
        );

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        firstName: json["first_name"],
        email: json["email"],
        role: json["role"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "first_name": firstName,
        "email": email,
        "role": role,
        "avatar": avatar,
    };
}
