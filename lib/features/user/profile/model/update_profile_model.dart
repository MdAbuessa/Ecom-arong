import 'dart:convert';

class UpdateProfileModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    UpdateProfileModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    UpdateProfileModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        UpdateProfileModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory UpdateProfileModel.fromRawJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
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
    String? location;
    String? gender;
    DateTime? dateOfBirth;
    int? dailyStepGoal;
    double? targetWeight;
    bool? emailNotification;
    bool? pushNotification;

    User({
        this.username,
        this.firstName,
        this.email,
        this.role,
        this.avatar,
        this.location,
        this.gender,
        this.dateOfBirth,
        this.dailyStepGoal,
        this.targetWeight,
        this.emailNotification,
        this.pushNotification,
    });

    User copyWith({
        String? username,
        String? firstName,
        String? email,
        String? role,
        String? avatar,
        String? location,
        String? gender,
        DateTime? dateOfBirth,
        int? dailyStepGoal,
        double? targetWeight,
        bool? emailNotification,
        bool? pushNotification,
    }) => 
        User(
            username: username ?? this.username,
            firstName: firstName ?? this.firstName,
            email: email ?? this.email,
            role: role ?? this.role,
            avatar: avatar ?? this.avatar,
            location: location ?? this.location,
            gender: gender ?? this.gender,
            dateOfBirth: dateOfBirth ?? this.dateOfBirth,
            dailyStepGoal: dailyStepGoal ?? this.dailyStepGoal,
            targetWeight: targetWeight ?? this.targetWeight,
            emailNotification: emailNotification ?? this.emailNotification,
            pushNotification: pushNotification ?? this.pushNotification,
        );

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        firstName: json["first_name"],
        email: json["email"],
        role: json["role"],
        avatar: json["avatar"],
        location: json["location"],
        gender: json["gender"],
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
        dailyStepGoal: json["daily_step_goal"],
        targetWeight: json["target_weight"]?.toDouble(),
        emailNotification: json["email_notification"],
        pushNotification: json["push_notification"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "first_name": firstName,
        "email": email,
        "role": role,
        "avatar": avatar,
        "location": location,
        "gender": gender,
        "date_of_birth": dateOfBirth == null ? null : "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "daily_step_goal": dailyStepGoal,
        "target_weight": targetWeight,
        "email_notification": emailNotification,
        "push_notification": pushNotification,
    };
}
