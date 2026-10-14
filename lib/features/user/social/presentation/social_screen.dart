import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/user/social_media_add_post/presentation/social_media_post_screen.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import '../widgets/social_post_list.dart';

class SocialScreen extends StatefulWidget {
  const SocialScreen({super.key});

  @override
  State<SocialScreen> createState() => _SocialScreenState();
}

class _SocialScreenState extends State<SocialScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = const ['Feed', 'Following', 'Club', 'My post'];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getFeedListRxObj.fetchFeedList(perPage: 10);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (_selectedTab == 0) {
        getFeedListRxObj.fetchFeedList(isLoadMoreAction: true);
      } else if (_selectedTab == 1) {
        getFollowingFeedListRxObj.fetchFollowingFeedList(
          isLoadMoreAction: true,
        );
      }
    }
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
            bottom: false,
            child: Stack(
              children: [
                Column(
                  children: [
                    // ── APP BAR ──────────────────────────────────────────────
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage('assets/images/user_img.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Text(
                            'Social media',
                            style: TextFontStyle.textStyle16InterW600.copyWith(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 36.w),
                        ],
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // ── TABS ──────────────────────────────────────────────────
                    SizedBox(
                      height: 40.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: _tabs.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedTab == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _selectedTab = index);
                              if (index == 1) {
                                getFollowingFeedListRxObj
                                    .fetchFollowingFeedList();
                              } else if (index == 2) {
                                getClubListRxObj.fetchClubList();
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: EdgeInsets.only(right: 12.w),
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.c2196F3
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(50.r),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                _tabs[index],
                                style: TextFontStyle.textStyle14InterW500
                                    .copyWith(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.white.withValues(alpha: 0.6),
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // ── POST LIST ─────────────────────────────────────────────
                    Expanded(
                      child: SocialPostList(
                        selectedTab: _selectedTab,
                        scrollController: _scrollController,
                      ),
                    ),
                  ],
                ),

                // ── FLOATING ACTION BUTTON ─────────────────────────────────
                Positioned(
                  bottom: 110.h,
                  right: 16.w,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const SocialMediaPostScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.c2196F3,
                        borderRadius: BorderRadius.circular(30.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.c2196F3.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.edit, color: Colors.white, size: 16.sp),
                          SizedBox(width: 8.w),
                          Text(
                            'Add post',
                            style: TextFontStyle.textStyle14InterW500.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
