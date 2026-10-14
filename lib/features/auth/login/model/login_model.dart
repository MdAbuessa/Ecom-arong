import 'dart:convert';

class LoginModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    LoginModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    LoginModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        LoginModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory LoginModel.fromRawJson(String str) => LoginModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    bool? isProfileSelected;
    String? accessToken;
    String? refreshToken;
    int? expiresIn;

    Data({
        this.user,
        this.isProfileSelected,
        this.accessToken,
        this.refreshToken,
        this.expiresIn,
    });

    Data copyWith({
        User? user,
        bool? isProfileSelected,
        String? accessToken,
        String? refreshToken,
        int? expiresIn,
    }) => 
        Data(
            user: user ?? this.user,
            isProfileSelected: isProfileSelected ?? this.isProfileSelected,
            accessToken: accessToken ?? this.accessToken,
            refreshToken: refreshToken ?? this.refreshToken,
            expiresIn: expiresIn ?? this.expiresIn,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        isProfileSelected: json["is_profile_selected"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        expiresIn: json["expires_in"],
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "is_profile_selected": isProfileSelected,
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
