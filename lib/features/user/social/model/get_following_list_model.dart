import 'dart:convert';

class GetFollowingListModel {
    bool? success;
    int? code;
    String? message;
    Data? data;
    String? timestamp;

    GetFollowingListModel({
        this.success,
        this.code,
        this.message,
        this.data,
        this.timestamp,
    });

    GetFollowingListModel copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
        String? timestamp,
    }) => 
        GetFollowingListModel(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
            timestamp: timestamp ?? this.timestamp,
        );

    factory GetFollowingListModel.fromRawJson(String str) => GetFollowingListModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetFollowingListModel.fromJson(Map<String, dynamic> json) => GetFollowingListModel(
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
    List<Post>? posts;
    Pagination? pagination;

    Data({
        this.posts,
        this.pagination,
    });

    Data copyWith({
        List<Post>? posts,
        Pagination? pagination,
    }) => 
        Data(
            posts: posts ?? this.posts,
            pagination: pagination ?? this.pagination,
        );

    factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
    };
}

class Pagination {
    int? currentPage;
    int? lastPage;
    int? perPage;
    int? total;

    Pagination({
        this.currentPage,
        this.lastPage,
        this.perPage,
        this.total,
    });

    Pagination copyWith({
        int? currentPage,
        int? lastPage,
        int? perPage,
        int? total,
    }) => 
        Pagination(
            currentPage: currentPage ?? this.currentPage,
            lastPage: lastPage ?? this.lastPage,
            perPage: perPage ?? this.perPage,
            total: total ?? this.total,
        );

    factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "last_page": lastPage,
        "per_page": perPage,
        "total": total,
    };
}

class Post {
    String? slug;
    PostCreator? postCreator;
    String? caption;
    List<String>? images;
    List<String>? videos;
    int? likesCount;
    int? commentsCount;
    bool? isLiked;
    String? shareLink;
    CreatedAt? createdAt;

    Post({
        this.slug,
        this.postCreator,
        this.caption,
        this.images,
        this.videos,
        this.likesCount,
        this.commentsCount,
        this.isLiked,
        this.shareLink,
        this.createdAt,
    });

    Post copyWith({
        String? slug,
        PostCreator? postCreator,
        String? caption,
        List<String>? images,
        List<String>? videos,
        int? likesCount,
        int? commentsCount,
        bool? isLiked,
        String? shareLink,
        CreatedAt? createdAt,
    }) => 
        Post(
            slug: slug ?? this.slug,
            postCreator: postCreator ?? this.postCreator,
            caption: caption ?? this.caption,
            images: images ?? this.images,
            videos: videos ?? this.videos,
            likesCount: likesCount ?? this.likesCount,
            commentsCount: commentsCount ?? this.commentsCount,
            isLiked: isLiked ?? this.isLiked,
            shareLink: shareLink ?? this.shareLink,
            createdAt: createdAt ?? this.createdAt,
        );

    factory Post.fromRawJson(String str) => Post.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Post.fromJson(Map<String, dynamic> json) => Post(
        slug: json["slug"],
        postCreator: json["post_creator"] == null ? null : PostCreator.fromJson(json["post_creator"]),
        caption: json["caption"],
        images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
        videos: json["videos"] == null ? [] : List<String>.from(json["videos"]!.map((x) => x)),
        likesCount: json["likes_count"],
        commentsCount: json["comments_count"],
        isLiked: json["is_liked"],
        shareLink: json["share_link"],
        createdAt: createdAtValues.map[json["created_at"]],
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "post_creator": postCreator?.toJson(),
        "caption": caption,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "videos": videos == null ? [] : List<dynamic>.from(videos!.map((x) => x)),
        "likes_count": likesCount,
        "comments_count": commentsCount,
        "is_liked": isLiked,
        "share_link": shareLink,
        "created_at": createdAtValues.reverse[createdAt],
    };
}

enum CreatedAt {
    THE_1_DAY_AGO,
    THE_2_DAYS_AGO
}

final createdAtValues = EnumValues({
    "1 day ago": CreatedAt.THE_1_DAY_AGO,
    "2 days ago": CreatedAt.THE_2_DAYS_AGO
});

class PostCreator {
    Slug? slug;
    Name? name;
    String? avatar;
    bool? isClub;
    bool? isFollowing;

    PostCreator({
        this.slug,
        this.name,
        this.avatar,
        this.isClub,
        this.isFollowing,
    });

    PostCreator copyWith({
        Slug? slug,
        Name? name,
        String? avatar,
        bool? isClub,
        bool? isFollowing,
    }) => 
        PostCreator(
            slug: slug ?? this.slug,
            name: name ?? this.name,
            avatar: avatar ?? this.avatar,
            isClub: isClub ?? this.isClub,
            isFollowing: isFollowing ?? this.isFollowing,
        );

    factory PostCreator.fromRawJson(String str) => PostCreator.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PostCreator.fromJson(Map<String, dynamic> json) => PostCreator(
        slug: slugValues.map[json["slug"]],
        name: nameValues.map[json["name"]],
        avatar: json["avatar"],
        isClub: json["is_club"],
        isFollowing: json["is_following"],
    );

    Map<String, dynamic> toJson() => {
        "slug": slugValues.reverse[slug],
        "name": nameValues.reverse[name],
        "avatar": avatar,
        "is_club": isClub,
        "is_following": isFollowing,
    };
}

enum Name {
    DEMO_CLUB,
    MYSELF,
    NEW
}

final nameValues = EnumValues({
    "demo club": Name.DEMO_CLUB,
    "Myself": Name.MYSELF,
    "New": Name.NEW
});

enum Slug {
    DEMO_CLUB_ZD_R_MI,
    MYSELF946096,
    NEW
}

final slugValues = EnumValues({
    "demo-club-ZdRMi": Slug.DEMO_CLUB_ZD_R_MI,
    "myself946096": Slug.MYSELF946096,
    "new": Slug.NEW
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
