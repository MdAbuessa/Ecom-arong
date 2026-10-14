import 'dart:convert';

class AllCommentModel {
  bool? success;
  int? code;
  String? message;
  Data? data;
  String? timestamp;

  AllCommentModel({
    this.success,
    this.code,
    this.message,
    this.data,
    this.timestamp,
  });

  AllCommentModel copyWith({
    bool? success,
    int? code,
    String? message,
    Data? data,
    String? timestamp,
  }) => AllCommentModel(
    success: success ?? this.success,
    code: code ?? this.code,
    message: message ?? this.message,
    data: data ?? this.data,
    timestamp: timestamp ?? this.timestamp,
  );

  factory AllCommentModel.fromRawJson(String str) =>
      AllCommentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllCommentModel.fromJson(Map<String, dynamic> json) =>
      AllCommentModel(
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
  String? postSlug;
  List<Comment>? comments;
  Pagination? pagination;

  Data({this.postSlug, this.comments, this.pagination});

  Data copyWith({
    String? postSlug,
    List<Comment>? comments,
    Pagination? pagination,
  }) => Data(
    postSlug: postSlug ?? this.postSlug,
    comments: comments ?? this.comments,
    pagination: pagination ?? this.pagination,
  );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    postSlug: json["post_slug"],
    comments: json["comments"] == null
        ? []
        : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    pagination: json["pagination"] == null
        ? null
        : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "post_slug": postSlug,
    "comments": comments == null
        ? []
        : List<dynamic>.from(comments!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Comment {
  int? commentId;
  dynamic parentId;
  String? comment;
  Commenter? commenter;
  int? likesCount;
  int? repliesCount;
  bool? isLiked;
  bool? isOwnComment;
  String? createdAt;
  List<dynamic>? replies;

  Comment({
    this.commentId,
    this.parentId,
    this.comment,
    this.commenter,
    this.likesCount,
    this.repliesCount,
    this.isLiked,
    this.isOwnComment,
    this.createdAt,
    this.replies,
  });

  Comment copyWith({
    int? commentId,
    dynamic parentId,
    String? comment,
    Commenter? commenter,
    int? likesCount,
    int? repliesCount,
    bool? isLiked,
    bool? isOwnComment,
    String? createdAt,
    List<dynamic>? replies,
  }) => Comment(
    commentId: commentId ?? this.commentId,
    parentId: parentId ?? this.parentId,
    comment: comment ?? this.comment,
    commenter: commenter ?? this.commenter,
    likesCount: likesCount ?? this.likesCount,
    repliesCount: repliesCount ?? this.repliesCount,
    isLiked: isLiked ?? this.isLiked,
    isOwnComment: isOwnComment ?? this.isOwnComment,
    createdAt: createdAt ?? this.createdAt,
    replies: replies ?? this.replies,
  );

  factory Comment.fromRawJson(String str) => Comment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    commentId: json["comment_id"],
    parentId: json["parent_id"],
    comment: json["comment"],
    commenter: json["commenter"] == null
        ? null
        : Commenter.fromJson(json["commenter"]),
    likesCount: json["likes_count"],
    repliesCount: json["replies_count"],
    isLiked: json["is_liked"],
    isOwnComment: json["is_own_comment"],
    createdAt: json["created_at"],
    replies: json["replies"] == null
        ? []
        : List<dynamic>.from(json["replies"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "comment_id": commentId,
    "parent_id": parentId,
    "comment": comment,
    "commenter": commenter?.toJson(),
    "likes_count": likesCount,
    "replies_count": repliesCount,
    "is_liked": isLiked,
    "is_own_comment": isOwnComment,
    "created_at": createdAt,
    "replies": replies == null
        ? []
        : List<dynamic>.from(replies!.map((x) => x)),
  };
}

class Commenter {
  String? username;
  String? name;
  String? avatar;

  Commenter({this.username, this.name, this.avatar});

  Commenter copyWith({String? username, String? name, String? avatar}) =>
      Commenter(
        username: username ?? this.username,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
      );

  factory Commenter.fromRawJson(String str) =>
      Commenter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Commenter.fromJson(Map<String, dynamic> json) => Commenter(
    username: json["username"],
    name: json["name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "name": name,
    "avatar": avatar,
  };
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Pagination({this.currentPage, this.lastPage, this.perPage, this.total});

  Pagination copyWith({
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
  }) => Pagination(
    currentPage: currentPage ?? this.currentPage,
    lastPage: lastPage ?? this.lastPage,
    perPage: perPage ?? this.perPage,
    total: total ?? this.total,
  );

  factory Pagination.fromRawJson(String str) =>
      Pagination.fromJson(json.decode(str));

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
