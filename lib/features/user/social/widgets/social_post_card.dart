import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/user/note_details/presentation/note_details_screen.dart';
import 'package:aarongonzales01/features/user/social/model/get_feed_list_model.dart';
import 'package:aarongonzales01/features/user/social/model/social_post_model.dart';
import 'report_bottom_sheet.dart';
import 'package:aarongonzales01/helpers/url_lunch.dart';
import 'package:aarongonzales01/networks/api_acess.dart';

class SocialPostCard extends StatefulWidget {
  final Post post;
  final bool isFollowingTab;
  final bool isMyPost;

  const SocialPostCard({
    super.key,
    required this.post,
    this.isFollowingTab = false,
    this.isMyPost = false,
  });

  @override
  State<SocialPostCard> createState() => _SocialPostCardState();
}

class _SocialPostCardState extends State<SocialPostCard> {
  late bool _isLiked;
  late bool _isFollowing;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.isLiked ?? false;
    _isFollowing = widget.post.postCreator?.isFollowing ?? false;
  }

  ImageProvider _getImageProvider(String? path) {
    if (path == null || path.isEmpty) {
      return const AssetImage('assets/images/placeholder.jpg');
    }
    if (path.startsWith('assets/')) {
      return AssetImage(path);
    }
    if (path.startsWith('http')) {
      return NetworkImage(path);
    }
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return NetworkImage("https://admin.racerealm.com/$cleanPath");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF131E30), // Dark card background
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header (Avatar, Name, Time, Menu) ───────────────────────
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _getImageProvider(widget.post.postCreator?.avatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.postCreator?.name ?? "",
                          style: TextFontStyle.textStyle14InterW500.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          widget.post.createdAt ?? "",
                          style: TextFontStyle.textStyle14InterW500.copyWith(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                    if (widget.post.postCreator?.isClub != true) ...[
                      SizedBox(width: 8.w),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isFollowing = !_isFollowing;
                          });
                          if (widget.post.postCreator?.slug != null) {
                            followUserRxObj.followUser(
                              widget.post.postCreator!.slug!,
                            );
                          }
                        },
                        child: Text(
                          _isFollowing ? 'Following' : 'Follow',
                          style: TextFontStyle.textStyle14InterW400.copyWith(
                            color: AppColor.c2196F3,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Report') {
                    _showReportBottomSheet(context);
                  }
                },
                color: const Color(0xFF1A2540),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 20.sp,
                ),
                itemBuilder: (context) {
                  if (widget.isMyPost) {
                    return [
                      PopupMenuItem(
                        value: 'Edit',
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Edit',
                              style: TextFontStyle.textStyle14InterW400
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'Delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                              size: 18.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Delete',
                              style: TextFontStyle.textStyle14InterW400
                                  .copyWith(color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    ];
                  }
                  if (widget.isFollowingTab) {
                    return [
                      PopupMenuItem(
                        value: 'Pin in Club',
                        child: Text(
                          'Pin in Club',
                          style: TextFontStyle.textStyle14InterW400.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        value: 'Delete',
                        child: Text(
                          'Delete',
                          style: TextFontStyle.textStyle14InterW400.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ];
                  }
                  return [
                    PopupMenuItem(
                      value: 'Report',
                      child: Text(
                        'Report',
                        style: TextFontStyle.textStyle14InterW400.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Hide',
                      child: Text(
                        'Hide',
                        style: TextFontStyle.textStyle14InterW400.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Block',
                      child: Text(
                        'Block',
                        style: TextFontStyle.textStyle14InterW400.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ];
                },
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // ── Text Content ─────────────────────────────────────────────
          Text(
            widget.post.caption ?? "",
            style: TextFontStyle.textStyle14InterW400.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.5,
              fontSize: 13.sp,
            ),
          ),

          SizedBox(height: 12.h),

          // ── Images ───────────────────────────────────────────────────
          if (widget.post.images != null && widget.post.images!.isNotEmpty)
            _buildImages(widget.post.images!),

          if (widget.post.images != null && widget.post.images!.isNotEmpty)
            SizedBox(height: 16.h),

          // ── Videos ───────────────────────────────────────────────────
          if (widget.post.videos != null && widget.post.videos!.isNotEmpty)
            _buildVideos(widget.post.videos!),

          if (widget.post.videos != null && widget.post.videos!.isNotEmpty)
            SizedBox(height: 16.h),

          // ── Footer (Like, Comment, Share) ────────────────────────────
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isLiked = !_isLiked;
                  });
                },
                child: SvgPicture.asset(
                  _isLiked
                      ? 'assets/icons/love_with_color.svg'
                      : 'assets/icons/love_without_color.svg',
                  height: 20.h,
                  width: 20.w,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                '${(widget.post.likesCount ?? 0) + (_isLiked ? 1 : 0)}',
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(width: 24.w),
              GestureDetector(
                onTap: () {
                  // Map Post to SocialPostModel for details screen
                  final mappedPost = SocialPostModel(
                    id: widget.post.slug ?? "",
                    userName: widget.post.postCreator?.name ?? "",
                    userAvatar: widget.post.postCreator?.avatar ?? "",
                    timeAgo: widget.post.createdAt ?? "",
                    content: widget.post.caption ?? "",
                    likes: (widget.post.likesCount ?? 0) + (_isLiked ? 1 : 0),
                    comments: widget.post.commentsCount ?? 0,
                    images: widget.post.images ?? [],
                    tags: const [],
                  );
                  Get.to(() => NoteDetailsScreen(post: mappedPost));
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/comment.svg',
                      height: 20.h,
                      width: 20.w,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '${widget.post.commentsCount ?? 0}',
                      style: TextFontStyle.textStyle14InterW400.copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Handle share
                },
                child: SvgPicture.asset(
                  'assets/icons/share.svg',
                  height: 20.h,
                  width: 20.w,
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
            image: _getImageProvider(images.first),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else if (images.length > 1) {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          childAspectRatio: 0.75, // Makes images taller than wide
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: DecorationImage(
                image: _getImageProvider(images[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );
    }
    // Fallback if there's an unexpected number of images
    return const SizedBox.shrink();
  }

  Widget _buildVideos(List<dynamic> videos) {
    return Column(
      children: videos.map((video) {
        final videoUrl = video.toString();
        return GestureDetector(
          onTap: () {
            if (videoUrl.isNotEmpty) {
              urlLunch(videoUrl);
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 8.h),
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.play_circle_fill,
                  color: Colors.white.withValues(alpha: 0.8),
                  size: 64.sp,
                ),
                Positioned(
                  bottom: 12.h,
                  child: Text(
                    "Play Video",
                    style: TextFontStyle.textStyle14InterW500.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showReportBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ReportBottomSheet(),
    );
  }
}
