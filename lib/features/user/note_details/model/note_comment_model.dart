class NoteCommentModel {
  final String id;
  final String userName;
  final String userAvatar;
  final String timeAgo;
  final String content;

  const NoteCommentModel({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.timeAgo,
    required this.content,
  });
}
