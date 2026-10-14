import 'dart:convert';

class ClubShowModel {
  bool? success;
  int? code;
  String? message;
  Data? data;
  String? timestamp;

  ClubShowModel({
    this.success,
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  ClubShowModel copyWith({
    bool? success,
    int? code,
    String? message,
    Data? data,
    String? timestamp,
  }) => ClubShowModel(
    success: success ?? this.success,
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
    timestamp: timestamp ?? this.timestamp,
  );

  factory ClubShowModel.fromRawJson(String str) =>
      ClubShowModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClubShowModel.fromJson(Map<String, dynamic> json) => ClubShowModel(
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
  Topic? topic;
  String? location;
  String? description;
  int? totalMembers;
  int? totalPendingMembers;
  int? totalChallenges;
  int? totalPosts;
  dynamic avatarUrl;
  dynamic coverUrl;
  List<SocialLink>? socialLinks;
  String? shareLink;

  Data({
    this.slug,
    this.name,
    this.topic,
    this.location,
    this.description,
    this.totalMembers,
    this.totalPendingMembers,
    this.totalChallenges,
    this.totalPosts,
    this.avatarUrl,
    this.coverUrl,
    this.socialLinks,
    this.shareLink,
  });

  Data copyWith({
    String? slug,
    String? name,
    Topic? topic,
    String? location,
    String? description,
    int? totalMembers,
    int? totalPendingMembers,
    int? totalChallenges,
    int? totalPosts,
    dynamic avatarUrl,
    dynamic coverUrl,
    List<SocialLink>? socialLinks,
    String? shareLink,
  }) => Data(
    slug: slug ?? this.slug,
    name: name ?? this.name,
    topic: topic ?? this.topic,
    location: location ?? this.location,
    description: description ?? this.description,
    totalMembers: totalMembers ?? this.totalMembers,
    totalPendingMembers: totalPendingMembers ?? this.totalPendingMembers,
    totalChallenges: totalChallenges ?? this.totalChallenges,
    totalPosts: totalPosts ?? this.totalPosts,
    avatarUrl: avatarUrl ?? this.avatarUrl,
    coverUrl: coverUrl ?? this.coverUrl,
    socialLinks: socialLinks ?? this.socialLinks,
    shareLink: shareLink ?? this.shareLink,
  );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    slug: json["slug"],
    name: json["name"],
    topic: json["topic"] == null ? null : Topic.fromJson(json["topic"]),
    location: json["location"],
    description: json["description"],
    totalMembers: json["total_members"],
    totalPendingMembers: json["total_pending_members"],
    totalChallenges: json["total_challenges"],
    totalPosts: json["total_posts"],
    avatarUrl: json["avatar_url"],
    coverUrl: json["cover_url"],
    socialLinks: json["social_links"] == null
        ? []
        : List<SocialLink>.from(
            json["social_links"]!.map((x) => SocialLink.fromJson(x)),
          ),
    shareLink: json["share_link"],
  );

  Map<String, dynamic> toJson() => {
    "slug": slug,
    "name": name,
    "topic": topic?.toJson(),
    "location": location,
    "description": description,
    "total_members": totalMembers,
    "total_pending_members": totalPendingMembers,
    "total_challenges": totalChallenges,
    "total_posts": totalPosts,
    "avatar_url": avatarUrl,
    "cover_url": coverUrl,
    "social_links": socialLinks == null
        ? []
        : List<dynamic>.from(socialLinks!.map((x) => x.toJson())),
    "share_link": shareLink,
  };
}

class SocialLink {
  String? platform;
  String? url;
  String? icon;

  SocialLink({this.platform, this.url, this.icon});

  SocialLink copyWith({String? platform, String? url, String? icon}) =>
      SocialLink(
        platform: platform ?? this.platform,
        url: url ?? this.url,
        icon: icon ?? this.icon,
      );

  factory SocialLink.fromRawJson(String str) =>
      SocialLink.fromJson(json.decode(str));

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

  Topic({this.slug, this.name});

  Topic copyWith({String? slug, String? name}) =>
      Topic(slug: slug ?? this.slug, name: name ?? this.name);

  factory Topic.fromRawJson(String str) => Topic.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Topic.fromJson(Map<String, dynamic> json) =>
      Topic(slug: json["slug"], name: json["name"]);

  Map<String, dynamic> toJson() => {"slug": slug, "name": name};
}
