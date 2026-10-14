import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/community/model/all_comment_model.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_social_feed_comments/api.dart';
import 'package:aarongonzales01/features/organizer/community/data/rx_social_feed_comment_create/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class FeedPostWidget extends StatefulWidget {
  final String creatorName;
  final String? creatorAvatar;
  final String date;
  final String caption;
  final String? link;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final VoidCallback? onDelete;
  final VoidCallback? onLike;
  final VoidCallback? allComment;
  final String? postSlug;

  const FeedPostWidget({
    super.key,
    required this.creatorName,
    this.creatorAvatar,
    required this.date,
    required this.caption,
    this.link,
    required this.likesCount,
    required this.commentsCount,
    required this.isLiked,
    this.onDelete,
    this.onLike,
    this.allComment,
    this.postSlug,
  });

  @override
  State<FeedPostWidget> createState() => _FeedPostWidgetState();
}

class _FeedPostWidgetState extends State<FeedPostWidget> {
  bool _showComments = false;
  bool _isLoading = false;
  List<Comment> _comments = [];
  Comment? _replyingTo;
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _commentController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _formatCommentDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    try {
      final dateTime = DateTime.parse(dateStr);
      return DateFormat("MM-dd-yy").format(dateTime);
    } catch (_) {
      return dateStr;
    }
  }

  List<Comment> _parseReplies(List<dynamic>? repliesList) {
    if (repliesList == null) return [];
    return repliesList.map((x) {
      if (x is Comment) return x;
      if (x is Map<String, dynamic>) return Comment.fromJson(x);
      return Comment(comment: x.toString());
    }).toList();
  }

  Future<void> _fetchComments() async {
    final slug = widget.postSlug;
    if (slug == null || slug.isEmpty) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final res = await SocialFeedCommentsApi.instance.getComments(slug);
      setState(() {
        _comments = res.data?.comments ?? [];
      });
    } catch (e) {
      debugPrint("Error fetching comments: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _submitComment() async {
    final text = _commentController.text.trim();
    final slug = widget.postSlug;
    if (text.isEmpty || slug == null || slug.isEmpty) return;

    final parentId = _replyingTo?.commentId;

    _commentController.clear();
    setState(() {
      _replyingTo = null;
    });
    _focusNode.unfocus();

    setState(() {
      _isLoading = true;
    });

    try {
      await SocialFeedCommentCreateApi.instance.createComment(
        postSlug: slug,
        comment: text,
        parentId: parentId,
      );
      // Refetch comments
      final res = await SocialFeedCommentsApi.instance.getComments(slug);
      setState(() {
        _comments = res.data?.comments ?? [];
      });
    } catch (e) {
      debugPrint("Error creating comment: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildCommentItem(Comment comment, {bool isReply = false}) {
    final username =
        comment.commenter?.username ?? comment.commenter?.name ?? "Anonymous";
    final avatar = comment.commenter?.avatar;
    final date = _formatCommentDate(comment.createdAt);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: isReply ? 10.r : 14.r,
                backgroundImage: NetworkImage(
                  avatar != null && avatar.isNotEmpty
                      ? avatar
                      : "https://images.unsplash.com/photo-1517649763962-0c623066013b?q=80&w=2070&auto=format&fit=crop",
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          username,
                          style: TextFontStyle.textStyle14InterW500.copyWith(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          date,
                          style: TextFontStyle.textStyle14InterW400.copyWith(
                            color: AppColor.c797A7C,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      comment.comment ?? "",
                      style: TextFontStyle.textStyle14InterW400.copyWith(
                        color: const Color(0xFF9EAEB8),
                        fontSize: 12.sp,
                      ),
                    ),
                    if (!isReply) ...[
                      SizedBox(height: 4.h),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _replyingTo = comment;
                          });
                          _focusNode.requestFocus();
                        },
                        child: Text(
                          "Reply",
                          style: TextStyle(
                            color: AppColor.c2196F3,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (!isReply) ...[
            ..._parseReplies(comment.replies).map((reply) {
              return Padding(
                padding: EdgeInsets.only(left: 28.w),
                child: _buildCommentItem(reply, isReply: true),
              );
            }),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Split the caption into a title and a body if a newline is present
    final String title;
    final String body;
    if (widget.caption.contains('\n')) {
      final index = widget.caption.indexOf('\n');
      title = widget.caption.substring(0, index).trim();
      body = widget.caption.substring(index).trim();
    } else {
      title = "";
      body = widget.caption;
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF101C21),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: NetworkImage(
                  widget.creatorAvatar != null &&
                          widget.creatorAvatar!.isNotEmpty
                      ? widget.creatorAvatar!
                      : "https://images.unsplash.com/photo-1517649763962-0c623066013b?q=80&w=2070&auto=format&fit=crop",
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.creatorName,
                    style: TextFontStyle.textStyle14InterW500.copyWith(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.date,
                    style: TextFontStyle.textStyle14InterW400.copyWith(
                      color: AppColor.c797A7C,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: widget.onDelete,
                child: Icon(Icons.delete, color: AppColor.cD64545, size: 20.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (title.isNotEmpty) ...[
            Text(
              title,
              style: TextFontStyle.textStyle16InterW600.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
          ],
          Text(
            body,
            style: TextFontStyle.textStyle14InterW400.copyWith(
              color: const Color(0xFF9EAEB8),
              fontSize: 13.sp,
              height: 1.4,
            ),
          ),
          if (widget.link != null && widget.link!.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Row(
              children: [
                Icon(Icons.link, color: AppColor.c2196F3, size: 18.sp),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    widget.link!,
                    style: TextFontStyle.textStyle14InterW400.copyWith(
                      color: AppColor.c2196F3,
                      fontSize: 13.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: 16.h),
          Row(
            children: [
              GestureDetector(
                onTap: widget.onLike,
                child: Icon(
                  widget.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: widget.isLiked ? Colors.red : AppColor.c797A7C,
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                widget.likesCount.toString(),
                style: TextStyle(
                  color: AppColor.c797A7C,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 20.w),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _showComments = !_showComments;
                  });
                  if (_showComments) {
                    _fetchComments();
                  }
                  widget.allComment?.call();
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.chat_bubble,
                      color: _showComments
                          ? AppColor.c2196F3
                          : AppColor.c797A7C,
                      size: 18.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      widget.commentsCount.toString(),
                      style: TextStyle(
                        color: _showComments
                            ? AppColor.c2196F3
                            : AppColor.c797A7C,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Icon(Icons.ios_share, color: AppColor.c797A7C, size: 18.sp),
            ],
          ),

          // Inline Comments Extension
          if (_showComments) ...[
            const Divider(color: Colors.white12, height: 24),
            if (_isLoading && _comments.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: CircularProgressIndicator(color: AppColor.c2196F3),
                ),
              )
            else if (_comments.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  "No comments yet. Start the conversation!",
                  style: TextStyle(color: Colors.white54, fontSize: 12.sp),
                ),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _comments
                    .map((comment) => _buildCommentItem(comment))
                    .toList(),
              ),

            // Reply banner inside container
            if (_replyingTo != null)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Replying to @${_replyingTo!.commenter?.username ?? _replyingTo!.commenter?.name ?? "Anonymous"}",
                      style: TextStyle(color: Colors.white70, fontSize: 11.sp),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _replyingTo = null;
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white60,
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),

            // Input field
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B2A32),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: TextField(
                        controller: _commentController,
                        focusNode: _focusNode,
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                        decoration: InputDecoration(
                          hintText: _replyingTo != null
                              ? "Add a reply..."
                              : "Add a comment...",
                          hintStyle: TextStyle(
                            color: Colors.white30,
                            fontSize: 13.sp,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: _submitComment,
                    child: CircleAvatar(
                      radius: 16.r,
                      backgroundColor: AppColor.c2196F3,
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
