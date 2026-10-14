import 'dart:convert';

class GetUserInfoModel {
  bool? success;
  int? code;
  String? message;
  Data? data;
  String? timestamp;

  GetUserInfoModel({
    this.success,
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  GetUserInfoModel copyWith({
    bool? success,
    int? code,
    String? message,
    Data? data,
    String? timestamp,
  }) => GetUserInfoModel(
    success: success ?? this.success,
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
    timestamp: timestamp ?? this.timestamp,
  );

  factory GetUserInfoModel.fromRawJson(String str) =>
      GetUserInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetUserInfoModel.fromJson(Map<String, dynamic> json) =>
      GetUserInfoModel(
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

  Data({this.user});

  Data copyWith({User? user}) => Data(user: user ?? this.user);

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(user: json["user"] == null ? null : User.fromJson(json["user"]));

  Map<String, dynamic> toJson() => {"user": user?.toJson()};
}

class User {
  String? username;
  String? firstName;
  String? email;
  String? phone;
  String? role;
  String? avatar;
  String? location;
  String? gender;
  DateTime? dateOfBirth;

  User({
    this.username,
    this.firstName,
    this.email,
    this.phone,
    this.role,
    this.avatar,
    this.location,
    this.gender,
    this.dateOfBirth,
  });

  User copyWith({
    String? username,
    String? firstName,
    String? email,
    String? phone,
    String? role,
    String? avatar,
    String? location,
    String? gender,
    DateTime? dateOfBirth,
  }) => User(
    username: username ?? this.username,
    firstName: firstName ?? this.firstName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    role: role ?? this.role,
    avatar: avatar ?? this.avatar,
    location: location ?? this.location,
    gender: gender ?? this.gender,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
  );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    firstName: json["first_name"],
    email: json["email"],
    phone: json["phone"] as String? ?? json["phone_number"] as String?,
    role: json["role"],
    avatar: json["avatar"],
    location: json["location"],
    gender: json["gender"],
    dateOfBirth: json["date_of_birth"] == null
        ? null
        : DateTime.parse(json["date_of_birth"]),
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "first_name": firstName,
    "email": email,
    "phone": phone,
    "role": role,
    "avatar": avatar,
    "location": location,
    "gender": gender,
    "date_of_birth": dateOfBirth == null
        ? null
        : "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
  };
}
