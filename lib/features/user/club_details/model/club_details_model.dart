import 'dart:convert';

class ClubDetailsModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    ClubDetailsModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    ClubDetailsModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        ClubDetailsModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory ClubDetailsModel.fromRawJson(String str) => ClubDetailsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ClubDetailsModel.fromJson(Map<String, dynamic> json) => ClubDetailsModel(
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
    String? slug;
    String? name;
    String? description;
    String? avatarUrl;
    dynamic coverUrl;
    String? location;
    int? totalMembers;
    int? totalChallenges;
    int? totalPosts;
    Topic? topic;
    List<SocialLink>? socialLinks;
    String? shareLink;
    bool? isJoined;

    Data({
        this.slug,
        this.name,
        this.description,
        this.avatarUrl,
        this.coverUrl,
        this.location,
        this.totalMembers,
        this.totalChallenges,
        this.totalPosts,
        this.topic,
        this.socialLinks,
        this.shareLink,
        this.isJoined,
    });

    Data copyWith({
        String? slug,
        String? name,
        String? description,
        String? avatarUrl,
        dynamic coverUrl,
        String? location,
        int? totalMembers,
        int? totalChallenges,
        int? totalPosts,
        Topic? topic,
        List<SocialLink>? socialLinks,
        String? shareLink,
        bool? isJoined,
    }) => 
        Data(
            slug: slug ?? this.slug,
            name: name ?? this.name,
            description: description ?? this.description,
            avatarUrl: avatarUrl ?? this.avatarUrl,
            coverUrl: coverUrl ?? this.coverUrl,
            location: location ?? this.location,
            totalMembers: totalMembers ?? this.totalMembers,
            totalChallenges: totalChallenges ?? this.totalChallenges,
            totalPosts: totalPosts ?? this.totalPosts,
            topic: topic ?? this.topic,
            socialLinks: socialLinks ?? this.socialLinks,
            shareLink: shareLink ?? this.shareLink,
            isJoined: isJoined ?? this.isJoined,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        slug: json["slug"],
        name: json["name"],
        description: json["description"],
        avatarUrl: json["avatar_url"],
        coverUrl: json["cover_url"],
        location: json["location"],
        totalMembers: json["total_members"],
        totalChallenges: json["total_challenges"],
        totalPosts: json["total_posts"],
        topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
        socialLinks: json["social_links"] == null ? [] : List<SocialLink>.from(json["social_links"]!.map((x) => SocialLink.fromJson(x))),
        shareLink: json["share_link"],
        isJoined: json["is_joined"],
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "description": description,
        "avatar_url": avatarUrl,
        "cover_url": coverUrl,
        "location": location,
        "total_members": totalMembers,
        "total_challenges": totalChallenges,
        "total_posts": totalPosts,
        "topic": topic?.toJson(),
        "social_links": socialLinks == null ? [] : List<dynamic>.from(socialLinks!.map((x) => x.toJson())),
        "share_link": shareLink,
        "is_joined": isJoined,
    };
}

class SocialLink {
    String? platform;
    String? url;
    String? icon;

    SocialLink({
        this.platform,
        this.url,
        this.icon,
    });

    SocialLink copyWith({
        String? platform,
        String? url,
        String? icon,
    }) => 
        SocialLink(
            platform: platform ?? this.platform,
            url: url ?? this.url,
            icon: icon ?? this.icon,
        );

    factory SocialLink.fromRawJson(String str) => SocialLink.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
        platform: json["platform"],
        url: json["url"],
        icon: json["icon"],
    );

    Map<String, dynamic> toJson() => {
        "platform": platform,
        "url": url,
        "icon": icon,
    };
}

class Topic {
    String? slug;
    String? name;

    Topic({
        this.slug,
        this.name,
    });

    Topic copyWith({
        String? slug,
        String? name,
    }) => 
        Topic(
            slug: slug ?? this.slug,
            name: name ?? this.name,
        );

    factory Topic.fromRawJson(String str) => Topic.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        slug: json["slug"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
    };
}
