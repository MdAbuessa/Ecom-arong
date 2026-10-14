import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/features/user/social/model/get_feed_list_model.dart';
import 'package:aarongonzales01/features/user/social/model/get_following_list_model.dart' as following;
import 'package:aarongonzales01/features/user/social/model/get_club_list_model.dart' as club;
import 'club_card.dart';
import 'social_dummy_data.dart';
import 'social_post_card.dart';

class SocialPostList extends StatelessWidget {
  final int selectedTab;
  final ScrollController scrollController;

  const SocialPostList({
    super.key,
    required this.selectedTab,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedTab == 0) {
      return ValueListenableBuilder<bool>(
        valueListenable: getFeedListRxObj.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.c2196F3),
            );
          }
          return StreamBuilder<GetFeedListModel>(
            stream: getFeedListRxObj.getFeedListData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error loading posts: ${snapshot.error}",
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColor.c2196F3),
                );
              }
              final posts = snapshot.data?.data?.posts ?? [];
              if (posts.isEmpty) {
                return Center(
                  child: Text(
                    "No posts found",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 16.sp,
                    ),
                  ),
                );
              }
              return ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  bottom: 150.h,
                ),
                itemCount: posts.length + 1,
                itemBuilder: (context, index) {
                  if (index == posts.length) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: getFeedListRxObj.isLoadMore,
                      builder: (context, isLoadMore, child) {
                        if (isLoadMore) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: CircularProgressIndicator(color: AppColor.c2196F3),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  }
                  return SocialPostCard(
                    post: posts[index],
                    isFollowingTab: false,
                    isMyPost: false,
                  );
                },
              );
            },
          );
        },
      );
    }

    if (selectedTab == 1) {
      return ValueListenableBuilder<bool>(
        valueListenable: getFollowingFeedListRxObj.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.c2196F3),
            );
          }
          return StreamBuilder<following.GetFollowingListModel>(
            stream: getFollowingFeedListRxObj.getFollowingFeedListData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error loading posts: ${snapshot.error}",
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColor.c2196F3),
                );
              }
              final posts = snapshot.data?.data?.posts ?? [];
              if (posts.isEmpty) {
                return Center(
                  child: Text(
                    "No posts found",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 16.sp,
                    ),
                  ),
                );
              }
              return ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  bottom: 150.h,
                ),
                itemCount: posts.length + 1,
                itemBuilder: (context, index) {
                  if (index == posts.length) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: getFollowingFeedListRxObj.isLoadMore,
                      builder: (context, isLoadMore, child) {
                        if (isLoadMore) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: CircularProgressIndicator(color: AppColor.c2196F3),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  }
                  final post = posts[index];
                  final mappedPost = Post(
                    slug: post.slug,
                    caption: post.caption,
                    images: post.images,
                    videos: post.videos,
                    likesCount: post.likesCount,
                    commentsCount: post.commentsCount,
                    isLiked: post.isLiked,
                    shareLink: post.shareLink,
                    createdAt: post.createdAt != null
                        ? following.createdAtValues.reverse[post.createdAt]
                        : null,
                    postCreator: post.postCreator != null
                        ? PostCreator(
                            slug: post.postCreator!.slug != null
                                ? following.slugValues.reverse[post.postCreator!.slug]
                                : null,
                            name: post.postCreator!.name != null
                                ? following.nameValues.reverse[post.postCreator!.name]
                                : null,
                            avatar: post.postCreator!.avatar,
                            isClub: post.postCreator!.isClub,
                            isFollowing: post.postCreator!.isFollowing,
                          )
                        : null,
                  );
                  return SocialPostCard(
                    post: mappedPost,
                    isFollowingTab: true,
                    isMyPost: false,
                  );
                },
              );
            },
          );
        },
      );
    }

    if (selectedTab == 2) {
      return ValueListenableBuilder<bool>(
        valueListenable: getClubListRxObj.isLoading,
        builder: (context, isLoading, child) {
          if (isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.c2196F3),
            );
          }
          return StreamBuilder<club.GetClubListModel>(
            stream: getClubListRxObj.getClubListData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error loading clubs: ${snapshot.error}",
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColor.c2196F3),
                );
              }
              final clubs = snapshot.data?.data?.clubs ?? [];
              if (clubs.isEmpty) {
                return Center(
                  child: Text(
                    "No clubs found",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 16.sp,
                    ),
                  ),
                );
              }
              return ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  bottom: 150.h,
                ),
                itemCount: clubs.length,
                itemBuilder: (context, index) {
                  return ClubCard(club: clubs[index]);
                },
              );
            },
          );
        },
      );
    }

    // Handle other tabs (My post)
    return ListView.builder(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: 150.h,
      ),
      itemCount: dummyPosts.length,
      itemBuilder: (context, index) {
        final currentPost = dummyPosts[index];
        return SocialPostCard(
          post: currentPost,
          isFollowingTab: false,
          isMyPost: selectedTab == 3,
        );
      },
    );
  }
}
