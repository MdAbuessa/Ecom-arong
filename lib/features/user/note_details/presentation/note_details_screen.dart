import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/features/user/note_details/model/note_comment_model.dart';
import 'package:aarongonzales01/features/user/social/model/social_post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoteDetailsScreen extends StatefulWidget {
  final SocialPostModel post;

  const NoteDetailsScreen({super.key, required this.post});

  @override
  State<NoteDetailsScreen> createState() => _NoteDetailsScreenState();
}

class _NoteDetailsScreenState extends State<NoteDetailsScreen> {
  final TextEditingController _commentController = TextEditingController();

  final List<NoteCommentModel> _comments = [
    const NoteCommentModel(
      id: '1',
      userName: '🍀🍀Lucky🌸🌸',
      userAvatar: 'assets/images/user_img.png',
      timeAgo: '53m',
      content: 'Wow nice place💕💌',
    ),
    const NoteCommentModel(
      id: '2',
      userName: 'Fayez🌸🌸',
      userAvatar: 'assets/images/person2.png',
      timeAgo: '50m',
      content: 'Wow nice place💕💌',
    ),
    const NoteCommentModel(
      id: '3',
      userName: 'Natacha',
      userAvatar: 'assets/images/person3.png',
      timeAgo: '48m',
      content: 'Congratulations👌👌',
    ),
    const NoteCommentModel(
      id: '4',
      userName: 'Leon🌸',
      userAvatar: 'assets/images/user_img.png',
      timeAgo: '24m',
      content: 'Wow nice 🎇🎉🔲',
    ),
    const NoteCommentModel(
      id: '5',
      userName: '🍀🍀Lucky🌸🌸',
      userAvatar: 'assets/images/user_img.png',
      timeAgo: '13m',
      content: 'Very nice player🎉🔲',
    ),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0A1628), Color(0xFF0D1B38), Color(0xFF071020)],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    children: [
                      _buildPostCard(),
                      SizedBox(height: 16.h),
                      _buildCommentsList(),
                    ],
                  ),
                ),
                _buildBottomInputBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomBackButton(onTap: () => Get.back()),
          ),
          Text(
            'Note Detail',
            style: TextFontStyle.textStyle16InterW600.copyWith(
              color: AppColor.c2196F3,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF131E30), // Dark card background
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(widget.post.userAvatar),
                    fit: BoxFit.cover,
                    // Fallback to placeholder if not found
                    onError: (exception, stackTrace) {},
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.userName,
                      style: TextFontStyle.textStyle14InterW500.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      widget.post.timeAgo,
                      style: TextFontStyle.textStyle14InterW500.copyWith(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.more_vert,
                color: Colors.white.withValues(alpha: 0.5),
                size: 20.sp,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Content
          Text(
            widget.post.content,
            style: TextFontStyle.textStyle14InterW400.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.5,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 12.h),
          // Tags
          Wrap(
            spacing: 8.w,
            children: widget.post.tags.map((tag) {
              return Text(
                tag,
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: AppColor.c2196F3,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.sp,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),
          // Images
          if (widget.post.images.isNotEmpty) _buildImages(widget.post.images),
          if (widget.post.images.isNotEmpty) SizedBox(height: 16.h),
          // Footer
          Row(
            children: [
              Icon(Icons.favorite, color: Colors.redAccent, size: 20.sp),
              SizedBox(width: 6.w),
              Text(
                '${widget.post.likes}',
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(width: 24.w),
              Icon(
                Icons.chat_bubble_outline_rounded,
                color: Colors.white.withValues(alpha: 0.7),
                size: 20.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                '${widget.post.comments}',
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/share.png',
                height: 20.h,
                width: 20.w,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.ios_share_rounded,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImages(List<String> images) {
    if (images.length == 1) {
      return Container(
        height: 220.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
            image: AssetImage(images.first),
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {},
          ),
        ),
      );
    } else if (images.length == 4) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          childAspectRatio: 0.75,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: AssetImage(images[index]),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {},
              ),
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildCommentsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _comments.length,
      separatorBuilder: (context, index) =>
          Divider(color: Colors.white.withValues(alpha: 0.1), height: 30.h),
      itemBuilder: (context, index) {
        final comment = _comments[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(comment.userAvatar),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {},
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        comment.userName,
                        style: TextFontStyle.textStyle14InterW500.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        comment.timeAgo,
                        style: TextFontStyle.textStyle14InterW400.copyWith(
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    comment.content,
                    style: TextFontStyle.textStyle14InterW400.copyWith(
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomInputBar() {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937), // Dark grey input background
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                color: const Color(0xFF374151),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: TextField(
                controller: _commentController,
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: 'Comment here...',
                  hintStyle: TextFontStyle.textStyle14InterW400.copyWith(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          GestureDetector(
            onTap: () {
              // Handle send comment
            },
            child: Text(
              'Send',
              style: TextFontStyle.textStyle16InterW600.copyWith(
                color: AppColor.c2196F3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
