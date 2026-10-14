import 'dart:convert';

class ClubListModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    ClubListModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    ClubListModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        ClubListModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory ClubListModel.fromRawJson(String str) => ClubListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ClubListModel.fromJson(Map<String, dynamic> json) => ClubListModel(
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
    List<Club>? clubs;

    Data({
        this.clubs,
    });

    Data copyWith({
        List<Club>? clubs,
    }) => 
        Data(
            clubs: clubs ?? this.clubs,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        clubs: json["clubs"] == null ? [] : List<Club>.from(json["clubs"]!.map((x) => Club.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "clubs": clubs == null ? [] : List<dynamic>.from(clubs!.map((x) => x.toJson())),
    };
}

class Club {
    String? slug;
    String? name;
    Topic? topic;
    String? location;
    int? totalMembers;
    int? totalChallenges;
    String? avatarUrl;
    String? description;
    String? coverUrl;
    List<SocialLink>? socialLinks;

    Club({
        this.slug,
        this.name,
        this.topic,
        this.location,
        this.totalMembers,
        this.totalChallenges,
        this.avatarUrl,
        this.description,
        this.coverUrl,
        this.socialLinks,
    });

    Club copyWith({
        String? slug,
        String? name,
        Topic? topic,
        String? location,
        int? totalMembers,
        int? totalChallenges,
        String? avatarUrl,
        String? description,
        String? coverUrl,
        List<SocialLink>? socialLinks,
    }) => 
        Club(
            slug: slug ?? this.slug,
            name: name ?? this.name,
            topic: topic ?? this.topic,
            location: location ?? this.location,
            totalMembers: totalMembers ?? this.totalMembers,
            totalChallenges: totalChallenges ?? this.totalChallenges,
            avatarUrl: avatarUrl ?? this.avatarUrl,
            description: description ?? this.description,
            coverUrl: coverUrl ?? this.coverUrl,
            socialLinks: socialLinks ?? this.socialLinks,
        );

    factory Club.fromRawJson(String str) => Club.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Club.fromJson(Map<String, dynamic> json) => Club(
        slug: json["slug"],
        name: json["name"],
        topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
        location: json["location"],
        totalMembers: json["total_members"],
        totalChallenges: json["total_challenges"],
        avatarUrl: json["avatar_url"],
        description: json["description"],
        coverUrl: json["cover_url"],
        socialLinks: json["social_links"] == null ? [] : List<SocialLink>.from(json["social_links"]!.map((x) => SocialLink.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "topic": topic?.toJson(),
        "location": location,
        "total_members": totalMembers,
        "total_challenges": totalChallenges,
        "avatar_url": avatarUrl,
        "description": description,
        "cover_url": coverUrl,
        "social_links": socialLinks == null ? [] : List<dynamic>.from(socialLinks!.map((x) => x.toJson())),
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

enum Name {
    CYCLING_CLUB,
    RUN_CLUB,
    TRAIL_HIKING
}

final nameValues = EnumValues({
    "Cycling Club": Name.CYCLING_CLUB,
    "Run Club": Name.RUN_CLUB,
    "Trail & Hiking": Name.TRAIL_HIKING
});

enum Slug {
    CYCLING_CLUB,
    RUN_CLUB,
    TRAIL_HIKING
}

final slugValues = EnumValues({
    "cycling-club": Slug.CYCLING_CLUB,
    "run-club": Slug.RUN_CLUB,
    "trail-hiking": Slug.TRAIL_HIKING
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
