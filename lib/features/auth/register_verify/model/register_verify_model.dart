import 'dart:convert';

class RegisterVerifyOtpModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    RegisterVerifyOtpModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    RegisterVerifyOtpModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        RegisterVerifyOtpModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory RegisterVerifyOtpModel.fromRawJson(String str) => RegisterVerifyOtpModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RegisterVerifyOtpModel.fromJson(Map<String, dynamic> json) => RegisterVerifyOtpModel(
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
    String? accessToken;
    String? refreshToken;
    int? expiresIn;

    Data({
        this.user,
        this.accessToken,
        this.refreshToken,
        this.expiresIn,
    });

    Data copyWith({
        User? user,
        String? accessToken,
        String? refreshToken,
        int? expiresIn,
    }) => 
        Data(
            user: user ?? this.user,
            accessToken: accessToken ?? this.accessToken,
            refreshToken: refreshToken ?? this.refreshToken,
            expiresIn: expiresIn ?? this.expiresIn,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        expiresIn: json["expires_in"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "expires_in": expiresIn,
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
