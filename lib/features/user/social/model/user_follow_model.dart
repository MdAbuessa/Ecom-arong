import 'dart:convert';

class UserFollowModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    UserFollowModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    UserFollowModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        UserFollowModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory UserFollowModel.fromRawJson(String str) => UserFollowModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserFollowModel.fromJson(Map<String, dynamic> json) => UserFollowModel(
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
    bool? isFollowing;
    int? followersCount;
    int? followingCount;

    Data({
        this.isFollowing,
        this.followersCount,
        this.followingCount,
    });

    Data copyWith({
        bool? isFollowing,
        int? followersCount,
        int? followingCount,
    }) => 
        Data(
            isFollowing: isFollowing ?? this.isFollowing,
            followersCount: followersCount ?? this.followersCount,
            followingCount: followingCount ?? this.followingCount,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        isFollowing: json["is_following"],
        followersCount: json["followers_count"],
        followingCount: json["following_count"],
    );

    Map<String, dynamic> toJson() => {
        "is_following": isFollowing,
        "followers_count": followersCount,
        "following_count": followingCount,
    };
}
