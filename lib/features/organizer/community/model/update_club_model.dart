import 'dart:convert';

class UpdateClubModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    UpdateClubModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    UpdateClubModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        UpdateClubModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory UpdateClubModel.fromRawJson(String str) => UpdateClubModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UpdateClubModel.fromJson(Map<String, dynamic> json) => UpdateClubModel(
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
    Category? category;
    String? location;
    String? description;
    dynamic avatarUrl;
    dynamic coverUrl;
    List<SocialLink>? socialLinks;

    Data({
        this.slug,
        this.name,
        this.category,
        this.location,
        this.description,
        this.avatarUrl,
        this.coverUrl,
        this.socialLinks,
    });

    Data copyWith({
        String? slug,
        String? name,
        Category? category,
        String? location,
        String? description,
        dynamic avatarUrl,
        dynamic coverUrl,
        List<SocialLink>? socialLinks,
    }) => 
        Data(
            slug: slug ?? this.slug,
            name: name ?? this.name,
            category: category ?? this.category,
            location: location ?? this.location,
            description: description ?? this.description,
            avatarUrl: avatarUrl ?? this.avatarUrl,
            coverUrl: coverUrl ?? this.coverUrl,
            socialLinks: socialLinks ?? this.socialLinks,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        slug: json["slug"],
        name: json["name"],
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        location: json["location"],
        description: json["description"],
        avatarUrl: json["avatar_url"],
        coverUrl: json["cover_url"],
        socialLinks: json["social_links"] == null ? [] : List<SocialLink>.from(json["social_links"]!.map((x) => SocialLink.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "category": category?.toJson(),
        "location": location,
        "description": description,
        "avatar_url": avatarUrl,
        "cover_url": coverUrl,
        "social_links": socialLinks == null ? [] : List<dynamic>.from(socialLinks!.map((x) => x.toJson())),
    };
}

class Category {
    String? slug;
    String? name;

    Category({
        this.slug,
        this.name,
    });

    Category copyWith({
        String? slug,
        String? name,
    }) => 
        Category(
            slug: slug ?? this.slug,
            name: name ?? this.name,
        );

    factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        slug: json["slug"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
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
