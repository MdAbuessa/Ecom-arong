import 'dart:convert';

class ChooseRoleModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    ChooseRoleModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    ChooseRoleModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        ChooseRoleModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory ChooseRoleModel.fromRawJson(String str) => ChooseRoleModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChooseRoleModel.fromJson(Map<String, dynamic> json) => ChooseRoleModel(
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

    Data({
        this.user,
    });

    Data copyWith({
        User? user,
    }) => 
        Data(
            user: user ?? this.user,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
    };
}

class User {
    String? username;
    String? firstName;
    String? email;
    String? role;
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
        String? role,
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
