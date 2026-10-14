// ignore_for_file: unused_field

import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/challenge_card_widget.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/delete_challenge_dialog_widget.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/delete_feed_dialog_widget.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/feed_post_widget.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/info_card_widget.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/social_icon_widget.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/stat_card_widget.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/topic_tag_widget.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/features/organizer/community/model/club_show_model.dart';
import 'package:aarongonzales01/features/organizer/community/model/club_challenge_list_model.dart'
    as challenge_model;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:aarongonzales01/features/organizer/community/model/social_feed_list_model.dart'
    show Post;

class OrganizerCreateDetailsScreen extends StatefulWidget {
  const OrganizerCreateDetailsScreen({super.key});

  @override
  State<OrganizerCreateDetailsScreen> createState() =>
      _OrganizerCreateDetailsScreenState();
}

class _OrganizerCreateDetailsScreenState
    extends State<OrganizerCreateDetailsScreen> {
  String? _slug;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String && _slug == null) {
      _slug = args;
      clubShowRxObj.fetchClubShow(_slug!);
      clubChallengeListRxObj.fetchClubChallengeList(slug: _slug!, perPage: 2);
      socialFeedListRXObj.getSocialFeedList(clubSlug: _slug!, perPage: 2);
    }
  }

  int _currentPage = 1;
  int _challengePage = 1;
  bool _isPaginating = false;

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMorePosts();
      _loadMoreChallenges();
    }
  }

  Future<void> _loadMorePosts() async {
    if (!socialFeedListRXObj.hasMore || socialFeedListRXObj.isLoading.value) {
      return;
    }
    _isPaginating = true; //  lock
    _currentPage++;
    await socialFeedListRXObj.getSocialFeedList(
      clubSlug: _slug!,
      perPage: 2,
      page: _currentPage,
    );
    _isPaginating = false; // unlock after API completes
  }

  Future<void> _loadMoreChallenges() async {
    if (!clubChallengeListRxObj.hasMore ||
        clubChallengeListRxObj.isLoading.value) {
      return;
    }
    _challengePage++;
    await clubChallengeListRxObj.fetchClubChallengeList(
      slug: _slug!,
      perPage: 2,
      page: _challengePage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      body: SafeArea(
        child: ValueListenableBuilder<bool>(
          valueListenable: clubShowRxObj.isLoading,
          builder: (context, isLoading, child) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.c2196F3),
              );
            }
            return StreamBuilder<ClubShowModel>(
              stream: clubShowRxObj.getClubShowData,
              builder: (context, snapshot) {
                final club = snapshot.data?.data;
                if (club == null) {
                  return const Center(
                    child: Text(
                      "No club details found",
                      style: TextStyle(color: Colors.white60),
                    ),
                  );
                }

                return SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Image & Back Button
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 200.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  club.coverUrl != null &&
                                          club.coverUrl.toString().isNotEmpty
                                      ? club.coverUrl.toString()
                                      : "https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?q=80&w=2070&auto=format&fit=crop",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40.h,
                            left: 20.w,
                            child: GestureDetector(
                              onTap: () => NavigationService.goBack,
                              child: Container(
                                padding: EdgeInsets.all(8.w),
                                decoration: const BoxDecoration(
                                  color: AppColor.c2196F3,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                              ),
                            ),
                          ),
                          // Profile Image overlapping
                          Positioned(
                            bottom: -40.h,
                            left: 20.w,
                            child: Container(
                              padding: EdgeInsets.all(4.w),
                              decoration: const BoxDecoration(
                                color: Color(0xFF061115),
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 40.r,
                                backgroundImage: NetworkImage(
                                  club.avatarUrl != null &&
                                          club.avatarUrl.toString().isNotEmpty
                                      ? club.avatarUrl.toString()
                                      : "https://images.unsplash.com/photo-1517649763962-0c623066013b?q=80&w=2070&auto=format&fit=crop",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.h),
                      // Title and Location
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  club.name ?? "The Racing Club",
                                  style: TextFontStyle.textStyle16InterW600
                                      .copyWith(
                                        fontSize: 22.sp,
                                        color: Colors.white,
                                      ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    NavigationService.navigateTo(
                                      Routes.joinPendingRequestScreen,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 4.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.withValues(
                                        alpha: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Pending",
                                          style: TextFontStyle
                                              .textStyle14InterW500
                                              .copyWith(
                                                color: Colors.orange,
                                                fontSize: 12.sp,
                                              ),
                                        ),
                                        SizedBox(width: 4.w),
                                        Container(
                                          padding: EdgeInsets.all(4.w),
                                          decoration: const BoxDecoration(
                                            color: Colors.orange,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Text(
                                            (club.totalPendingMembers ?? 0)
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: AppColor.c797A7C,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  club.location ?? "Not specified",
                                  style: TextFontStyle.textStyle14InterW400
                                      .copyWith(color: AppColor.c797A7C),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            // Social Icons
                            Row(
                              children:
                                  (club.socialLinks != null &&
                                      club.socialLinks!.isNotEmpty)
                                  ? club.socialLinks!.map((link) {
                                      IconData iconData;
                                      switch (link.platform?.toLowerCase()) {
                                        case 'instagram':
                                          iconData = Icons.camera_alt_outlined;
                                          break;
                                        case 'facebook':
                                          iconData = Icons.facebook_outlined;
                                          break;
                                        case 'tiktok':
                                          iconData = Icons.music_note_outlined;
                                          break;
                                        case 'twitter':
                                        case 'x':
                                          iconData = Icons.close;
                                          break;
                                        default:
                                          iconData = Icons.link;
                                      }
                                      return Padding(
                                        padding: EdgeInsets.only(right: 12.w),
                                        child: SocialIconWidget(icon: iconData),
                                      );
                                    }).toList()
                                  : [
                                      SocialIconWidget(
                                        icon: Icons.camera_alt_outlined,
                                      ),
                                      SizedBox(width: 12.w),
                                      SocialIconWidget(
                                        icon: Icons.facebook_outlined,
                                      ),
                                      SizedBox(width: 12.w),
                                      SocialIconWidget(
                                        icon: Icons.music_note_outlined,
                                      ),
                                      SizedBox(width: 12.w),
                                      SocialIconWidget(icon: Icons.close),
                                    ],
                            ),
                            SizedBox(height: 24.h),
                            // Stats Row
                            Row(
                              children: [
                                StatCardWidget(
                                  title: "Members",
                                  value: (club.totalMembers ?? 0).toString(),
                                  onTap: () {
                                    NavigationService.navigateTo(
                                      Routes.clubAllMemberScreen,
                                    );
                                  },
                                ),
                                SizedBox(width: 12.w),
                                StatCardWidget(
                                  title: "Posts",
                                  value: (club.totalPosts ?? 0).toString(),
                                ),
                                SizedBox(width: 12.w),
                                StatCardWidget(
                                  title: "Challenges",
                                  value: (club.totalChallenges ?? 0).toString(),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            // Description
                            InfoCardWidget(
                              title: "Club Description",
                              content:
                                  club.description ??
                                  "No description available.",
                            ),
                            SizedBox(height: 16.h),
                            // Topics
                            InfoCardWidget(
                              title: "Topics",
                              child: Wrap(
                                spacing: 8.w,
                                children: [
                                  if (club.topic != null &&
                                      club.topic!.name != null)
                                    TopicTagWidget(label: club.topic!.name!)
                                  else ...const [
                                    TopicTagWidget(label: "Walking"),
                                    TopicTagWidget(label: "Running"),
                                    TopicTagWidget(label: "Fitness"),
                                  ],
                                ],
                              ),
                            ),
                            SizedBox(height: 24.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Active Challenges",
                                  style: TextFontStyle.textStyle16InterW600
                                      .copyWith(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    NavigationService.navigateTo(
                                      Routes.createNewChallengesScreen,
                                      arguments: club.slug,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.c2196F3,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 8.h,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 16.sp,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Create Challenges",
                                            style: TextStyle(
                                              color: AppColor.cFFFFFF,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            UIHelper.verticalSpace(16.h),

                            ValueListenableBuilder<
                              List<challenge_model.Challenge>
                            >(
                              valueListenable:
                                  clubChallengeListRxObj.allChallenges,
                              builder: (context, challenges, _) {
                                if (challenges.isEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                    ),
                                    child: Text(
                                      "No active challenges found",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  );
                                }

                                String getGoalString(
                                  challenge_model.Challenge ch,
                                ) {
                                  final type = ch.goalType ?? "steps";
                                  final val = ch.goalValue ?? "0";
                                  final completed = ch.totalCompleted ?? 0;
                                  return "$completed/ $val $type";
                                }

                                String getDaysLeft(DateTime? end) {
                                  if (end == null) return "0 days left";
                                  final diff = end
                                      .difference(DateTime.now())
                                      .inDays;
                                  if (diff <= 0) return "Ends today";
                                  return "$diff days left";
                                }

                                double getProgress(
                                  challenge_model.Challenge ch,
                                ) {
                                  final valStr = ch.goalValue;
                                  if (valStr == null) return 0.0;
                                  final double maxVal =
                                      double.tryParse(valStr) ?? 1.0;
                                  if (maxVal <= 0) return 0.0;
                                  final double completed =
                                      (ch.totalCompleted ?? 0).toDouble();
                                  final double prog = completed / maxVal;
                                  return prog > 1.0
                                      ? 1.0
                                      : (prog < 0.0 ? 0.0 : prog);
                                }

                                return Column(
                                  children: challenges.map((ch) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 12.h),
                                      child: ChallengeCardWidget(
                                        title: ch.title ?? "Untitled Challenge",
                                        goal: getGoalString(ch),
                                        daysLeft: getDaysLeft(ch.endDate),
                                        progress: getProgress(ch),
                                        image: ch.thumbnailUrl?.toString(),
                                        onDelete: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return DeleteChallengeDialogWidget(
                                                onConfirmDelete: () async {
                                                  Navigator.pop(context);
                                                  final success =
                                                      await challengeDeleteRxObj
                                                          .deleteChallengeRx(
                                                            ch.slug!,
                                                          );
                                                  if (success) {
                                                    _challengePage = 1;
                                                    clubChallengeListRxObj
                                                        .fetchClubChallengeList(
                                                          slug: _slug!,
                                                          perPage: 2,
                                                          page: 1,
                                                        );
                                                    clubShowRxObj.fetchClubShow(
                                                      _slug!,
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                            SizedBox(height: 24.h),
                            // Social Feed
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Social feed",
                                  style: TextFontStyle.textStyle16InterW600
                                      .copyWith(color: Colors.white),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final result =
                                        await NavigationService.navigateTo(
                                          Routes.createSocialFeedScreen,
                                          arguments: club.slug,
                                        );
                                    if (result == true) {
                                      _currentPage = 1;
                                      socialFeedListRXObj.getSocialFeedList(
                                        clubSlug: _slug!,
                                        perPage: 2,
                                        page: 1,
                                      );
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColor.c2196F3,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 8.h,
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 16.sp,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Create Feed",
                                            style: TextStyle(
                                              color: AppColor.cFFFFFF,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 12.h),
                            ValueListenableBuilder<List<Post>>(
                              valueListenable: socialFeedListRXObj.allPosts,
                              builder: (context, posts, _) {
                                String formatPostDate(String? dateStr) {
                                  if (dateStr == null || dateStr.isEmpty) {
                                    return "";
                                  }
                                  try {
                                    final dateTime = DateTime.parse(dateStr);
                                    return DateFormat(
                                      "MM-dd-yy",
                                    ).format(dateTime);
                                  } catch (e) {
                                    return dateStr;
                                  }
                                }

                                if (posts.isEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.h,
                                    ),
                                    child: Text(
                                      "No feed posts found",
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  );
                                }

                                return Column(
                                  children: posts.map((post) {
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 16.h),
                                      child: FeedPostWidget(
                                        creatorName:
                                            post.postCreator?.name ?? "Unknown",
                                        creatorAvatar: post.postCreator?.avatar,
                                        date: formatPostDate(post.createdAt),
                                        caption: post.caption ?? "",
                                        link: post.shareLink,
                                        likesCount: post.likesCount ?? 0,
                                        commentsCount: post.commentsCount ?? 0,
                                        isLiked: post.isLiked ?? false,
                                        postSlug: post.slug ?? "",
                                        // allComment: () {},
                                        onLike: () async {
                                          final postSlug = post.slug;
                                          if (postSlug == null ||
                                              postSlug.isEmpty) {
                                            return;
                                          }
                                          final currentlyLiked =
                                              post.isLiked ?? false;
                                          post.isLiked = !currentlyLiked;
                                          post.likesCount =
                                              (post.likesCount ?? 0) +
                                              (post.isLiked! ? 1 : -1);

                                          socialFeedListRXObj
                                              .allPosts
                                              .value = List.from(
                                            socialFeedListRXObj.allPosts.value,
                                          );

                                          final success =
                                              await socialFeedLikeRxObj
                                                  .likeSocialFeedRx(postSlug);
                                          if (!success) {
                                            post.isLiked = currentlyLiked;
                                            post.likesCount =
                                                (post.likesCount ?? 0) +
                                                (currentlyLiked ? 1 : -1);
                                            socialFeedListRXObj.allPosts.value =
                                                List.from(
                                                  socialFeedListRXObj
                                                      .allPosts
                                                      .value,
                                                );
                                          }
                                        },
                                        onDelete: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return DeleteFeedDialogWidget(
                                                onConfirmDelete: () async {
                                                  Navigator.pop(context);
                                                  final success =
                                                      await socialFeedDeleteRxObj
                                                          .deleteSocialFeedRx(
                                                            post.slug ?? "",
                                                          );
                                                  if (success) {
                                                    _currentPage = 1;
                                                    socialFeedListRXObj
                                                        .getSocialFeedList(
                                                          clubSlug: _slug!,
                                                          perPage: 2,
                                                          page: 1,
                                                        );
                                                  }
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),

                            // Invite Button
                            Container(
                              width: double.infinity,
                              height: 50.h,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColor.c2196F3,
                                  width: 1.w,
                                ),
                                borderRadius: BorderRadius.circular(25.r),
                              ),
                              child: Center(
                                child: Text(
                                  "Invite club",
                                  style: TextFontStyle.textStyle16InterW600
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
