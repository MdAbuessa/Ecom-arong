class SocialPostModel {
  final String id;
  final String userName;
  final String userAvatar;
  final String timeAgo;
  final String content;
  final String? title;
  final String? linkUrl;
  final List<String> tags;
  final List<String> images;
  final int likes;
  final int comments;

  const SocialPostModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.timeAgo,
    required this.content,
    this.title,
    this.linkUrl,
    required this.tags,
    required this.images,
    required this.likes,
    required this.comments,
  });
}
