import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aarongonzales01/features/user/club_details/model/club_details_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ClubDetailsScreen extends StatefulWidget {
  final ClubDetailsModel? clubModel;
  const ClubDetailsScreen({super.key, this.clubModel});

  @override
  State<ClubDetailsScreen> createState() => _ClubDetailsScreenState();
}

class _ClubDetailsScreenState extends State<ClubDetailsScreen> {
  String get _coverImage =>
      widget.clubModel?.data?.coverUrl ?? 'assets/images/cover_img.jpg';
  String get _clubAvatar =>
      widget.clubModel?.data?.avatarUrl ?? 'assets/images/user_img.png';
  String get _clubName => widget.clubModel?.data?.name ?? 'The Racing Club';
  String get _location => widget.clubModel?.data?.location ?? 'Visalia, France';
  int get _members => widget.clubModel?.data?.totalMembers ?? 340;
  int get _posts => widget.clubModel?.data?.totalPosts ?? 60;
  int get _challenges => widget.clubModel?.data?.totalChallenges ?? 65;
  String get _description => widget.clubModel?.data?.description ?? '';
  List<String> get _topics => widget.clubModel?.data?.topic?.name != null
      ? [widget.clubModel!.data!.topic!.name!]
      : [];

  ImageProvider _getImageProvider(String path) {
    if (path.isEmpty) {
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

  String? _getSocialIconPath(String? platform) {
    if (platform == null) return null;
    switch (platform.toLowerCase()) {
      case 'x':
      case 'twitter':
        return 'assets/icons/x.svg';
      case 'tiktok':
        return 'assets/icons/tiktok.svg';
      case 'facebook':
        return 'assets/icons/facebook.svg';
      case 'instagram':
      case 'instragram':
        return 'assets/icons/instragram.svg';
      default:
        return null;
    }
  }

  final List<_SocialPost> _feedPosts = [
    _SocialPost(
      avatar: 'assets/images/post4.png',
      clubName: 'The Racing Club',
      time: '12:12:26',
      title: 'New Challenge Available!',
      content:
          'The club owner has published a new challenge.\nCheck out the link below to get started.',
      link: 'https://www.race.com/challenges/12...',
      likes: 116,
      comments: 38,
    ),
    _SocialPost(
      avatar: 'assets/images/post2.png',
      clubName: 'The Racing Club',
      time: '12:10:26',
      title: 'New Challenge Available!',
      content:
          'The club owner has published a new challenge.\nCheck out the link below to get started.',
      link: 'https://www.race.com/challenges/12...',
      likes: 116,
      comments: 38,
    ),
    _SocialPost(
      avatar: 'assets/images/post5.png',
      clubName: 'The Racing Club',
      time: '12:10:26',
      title: 'New Challenge Available!',
      content:
          'The club owner has published a new challenge.\nCheck out the link below to get started.',
      link: 'https://www.race.com/challenges/12...',
      likes: 116,
      comments: 38,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF071020),
        body: CustomScrollView(
          slivers: [
            // ── COVER + BACK BUTTON ──────────────────────────────────────
            SliverToBoxAdapter(child: _buildCoverSection()),

            // ── CLUB INFO ────────────────────────────────────────────────
            SliverToBoxAdapter(child: _buildClubInfo()),

            // ── STATS ROW ────────────────────────────────────────────────
            SliverToBoxAdapter(child: _buildStatsRow()),

            // ── DESCRIPTION ──────────────────────────────────────────────
            SliverToBoxAdapter(child: _buildDescription()),

            // ── TOPICS ───────────────────────────────────────────────────
            SliverToBoxAdapter(child: _buildTopics()),

            // // ── JOIN CLUB BUTTON ─────────────────────────────────────────
            // SliverToBoxAdapter(child: _buildJoinButton()),

            // ── ACTIVE CHALLENGES ────────────────────────────────────────
            SliverToBoxAdapter(child: _buildActiveChallenges()),

            // ── SOCIAL FEED HEADER ───────────────────────────────────────
            SliverToBoxAdapter(child: _buildFeedHeader()),

            // ── FEED POSTS ───────────────────────────────────────────────
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _FeedPostCard(post: _feedPosts[index]),
                childCount: _feedPosts.length,
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 100.h)),
          ],
        ),
      ),
    );
  }

  // ── Cover / Hero image with back & avatar ─────────────────────────
  Widget _buildCoverSection() {
    return SizedBox(
      height: 270.h,
      child: Stack(
        children: [
          // Cover image
          Container(
            width: double.infinity,
            height: 240.h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _getImageProvider(_coverImage),
                fit: BoxFit.cover,
              ),
            ),
            // subtle bottom gradient so text is readable
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  const Color(0xFF071020).withValues(alpha: 0.85),
                ],
                stops: const [0.55, 1.0],
              ),
            ),
          ),

          // Back button (top-left inside safe area)
          Positioned(
            top: MediaQuery.of(context).padding.top + 12.h,
            left: 16.w,
            child: const CustomBackButton(),
          ),

          // Avatar overlapping bottom left
          Positioned(
            bottom: 0,
            left: 16.w,
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF071020), width: 4.w),
                image: DecorationImage(
                  image: _getImageProvider(_clubAvatar),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Club name, location, social icons ────────────────────────────────────
  Widget _buildClubInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _clubName,
                style: TextFontStyle.textStyle16InterW600.copyWith(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final shareLink = widget.clubModel?.data?.shareLink;
                  if (shareLink != null && shareLink.isNotEmpty) {
                    Share.share(shareLink);
                  }
                },
                child: SvgPicture.asset(
                  'assets/icons/share.svg',
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                  height: 24.w,
                  width: 24.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/location.svg',
                colorFilter: ColorFilter.mode(
                  Colors.white.withValues(alpha: 0.6),
                  BlendMode.srcIn,
                ),
                width: 16.w,
                height: 16.h,
              ),
              SizedBox(width: 8.w),
              Text(
                _location,
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          // Social icon row
          Row(
            children: (widget.clubModel?.data?.socialLinks ?? []).map((link) {
              if (link.icon == null || link.icon!.isEmpty)
                return const SizedBox.shrink();
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: GestureDetector(
                  onTap: () async {
                    if (link.url != null && link.url!.isNotEmpty) {
                      final uri = Uri.parse(link.url!);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    }
                  },
                  child: _SocialIconButton(imageUrl: link.icon),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ── Stats: Members / Posts / Challenges ───────────────────────────────────
  Widget _buildStatsRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _StatCard(label: 'Members', value: '$_members'),
          SizedBox(width: 12.w),
          _StatCard(label: 'Posts', value: '$_posts'),
          SizedBox(width: 12.w),
          _StatCard(label: 'Challenges', value: '$_challenges'),
        ],
      ),
    );
  }

  // ── Description card ─────────────────────────────────────────────────────
  Widget _buildDescription() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF131E30),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Club Description',
              style: TextFontStyle.textStyle14InterW500.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              _description,
              style: TextFontStyle.textStyle14InterW400.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 13.sp,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Topics chips ──────────────────────────────────────────────────────────
  Widget _buildTopics() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 14.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF131E30),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Topics',
              style: TextFontStyle.textStyle14InterW500.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _topics.map((tag) => _TopicChip(label: tag)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // // ── Join Club CTA ─────────────────────────────────────────────────────────
  // Widget _buildJoinButton() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
  //     child: SizedBox(
  //       width: double.infinity,
  //       height: 52.h,
  //       child: ElevatedButton(
  //         onPressed: () {},
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: AppColor.c2196F3,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(30.r),
  //           ),
  //           elevation: 0,
  //         ),
  //         child: Text(
  //           'Join Club',
  //           style: TextFontStyle.textStyle16InterW600.copyWith(
  //             color: Colors.white,
  //             fontSize: 16.sp,
  //             fontWeight: FontWeight.w700,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // ── Active Challenges section ─────────────────────────────────────────────
  Widget _buildActiveChallenges() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Challenges',
            style: TextFontStyle.textStyle16InterW600.copyWith(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFF131E30),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Challenge thumbnail
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    'assets/images/post6.png',
                    width: 52.w,
                    height: 52.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '2 Million Challenge',
                            style: TextFontStyle.textStyle14InterW500.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColor.c2196F3.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              '2 days left',
                              style: TextFontStyle.textStyle14InterW400
                                  .copyWith(
                                    color: AppColor.c2196F3,
                                    fontSize: 10.sp,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: LinearProgressIndicator(
                          value: 0.0, // 0K / 2000K = 0%
                          backgroundColor: Colors.white.withValues(alpha: 0.12),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColor.c2196F3,
                          ),
                          minHeight: 6.h,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        '0K / 2000K steps',
                        style: TextFontStyle.textStyle14InterW400.copyWith(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Social feed header ────────────────────────────────────────────────────
  Widget _buildFeedHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 12.h),
      child: Text(
        'Social feed',
        style: TextFontStyle.textStyle16InterW600.copyWith(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ── Helpers & sub-widgets ────────────────────────────────────────────────────

class _SocialPost {
  final String avatar;
  final String clubName;
  final String time;
  final String title;
  final String content;
  final String link;
  final int likes;
  final int comments;

  const _SocialPost({
    required this.avatar,
    required this.clubName,
    required this.time,
    required this.title,
    required this.content,
    required this.link,
    required this.likes,
    required this.comments,
  });
}

// ── Social icon round button ─────────────────────────────────────────────────
class _SocialIconButton extends StatelessWidget {
  final String? imageUrl;

  const _SocialIconButton({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36.w,
      height: 36.w,
      decoration: BoxDecoration(
        color: const Color(0xFF1A2A44),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: Center(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(18.w),
                child: CachedNetworkImage(
                  imageUrl: imageUrl!,
                  width: 18.w,
                  height: 18.w,
                  fit: BoxFit.cover,

                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      width: 10,
                      height: 10,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.broken_image_outlined,
                    size: 14,
                    color: Color(0xFF2196F3),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

// ── Stat card ────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2540),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextFontStyle.textStyle14InterW400.copyWith(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: TextFontStyle.textStyle16InterW600.copyWith(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Topic chip ───────────────────────────────────────────────────────────────
class _TopicChip extends StatelessWidget {
  final String label;

  const _TopicChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2540),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextFontStyle.textStyle14InterW400.copyWith(
          color: Colors.white.withValues(alpha: 0.75),
          fontSize: 12.sp,
        ),
      ),
    );
  }
}

// ── Feed post card ───────────────────────────────────────────────────────────
class _FeedPostCard extends StatelessWidget {
  final _SocialPost post;

  const _FeedPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 14.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF131E30),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(post.avatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.clubName,
                      style: TextFontStyle.textStyle14InterW500.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      post.time,
                      style: TextFontStyle.textStyle14InterW400.copyWith(
                        color: Colors.white.withValues(alpha: 0.45),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Title
          Text(
            post.title,
            style: TextFontStyle.textStyle16InterW600.copyWith(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 6.h),

          // Content
          Text(
            post.content,
            style: TextFontStyle.textStyle14InterW400.copyWith(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 13.sp,
              height: 1.5,
            ),
          ),

          SizedBox(height: 10.h),

          // Link
          Row(
            children: [
              Icon(Icons.link, color: AppColor.c2196F3, size: 18.sp),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  post.link,
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    color: AppColor.c2196F3,
                    fontSize: 12.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Footer
          Row(
            children: [
              Icon(Icons.favorite, color: Colors.redAccent, size: 18.sp),
              SizedBox(width: 5.w),
              Text(
                '${post.likes}',
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: Colors.white.withValues(alpha: 0.65),
                  fontSize: 13.sp,
                ),
              ),
              SizedBox(width: 20.w),
              Icon(
                Icons.chat_bubble_outline_rounded,
                color: Colors.white.withValues(alpha: 0.65),
                size: 18.sp,
              ),
              SizedBox(width: 5.w),
              Text(
                '${post.comments}',
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: Colors.white.withValues(alpha: 0.65),
                  fontSize: 13.sp,
                ),
              ),
              const Spacer(),
              Image.asset(
                'assets/images/share.png',
                width: 20.w,
                height: 20.w,
                color: Colors.white.withValues(alpha: 0.65),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
