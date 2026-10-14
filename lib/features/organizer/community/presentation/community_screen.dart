import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/club_card_widget.dart';
import 'package:aarongonzales01/features/organizer/home/widgets/home_stat_card_widget.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/features/organizer/community/model/club_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    clubListRxObj.fetchClubList("");
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      clubListRxObj.fetchClubList(_searchController.text);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      clubListRxObj.fetchClubList(
        _searchController.text,
        isLoadMoreAction: true,
      );
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF061115), // Consistent with Home screen
      appBar: ProfileAppBar(title: "Community"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: HomeStatCardWidget(
                      title: "Total Clubs",
                      value: "12",
                      icon: Icons.calendar_today_outlined,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: HomeStatCardWidget(
                      title: "Total Groups",
                      value: "340",
                      icon: Icons.people_outline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: HomeStatCardWidget(
                      title: "Total Member",
                      value: "12", // Following the photo exactly
                      icon: Icons.attach_money,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: HomeStatCardWidget(
                      title: "Total Pending",
                      value: "150",
                      icon: Icons.trending_up,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "All Club",
                    style: TextFontStyle.textStyle16InterW600.copyWith(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  GestureDetector(
                    onTap: () async {
                      await NavigationService.navigateTo(
                        Routes.createClubBasicInfoScreen,
                      );
                      clubListRxObj.fetchClubList(_searchController.text);
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
                            Icon(Icons.add, size: 16.sp, color: Colors.white),
                            Text(
                              " Create club",
                              style: TextStyle(color: AppColor.cFFFFFF),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(16.h),
              CustomTextfieldWidget(
                hintText: "Search club",
                controller: _searchController,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColor.c797A7C,
                  size: 20.sp,
                ),
              ),
              UIHelper.verticalSpace(24.h),

              ValueListenableBuilder<bool>(
                valueListenable: clubListRxObj.isLoading,
                builder: (context, isLoading, child) {
                  if (isLoading) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.c2196F3,
                        ),
                      ),
                    );
                  }
                  return StreamBuilder<ClubListModel>(
                    stream: clubListRxObj.getClubListData,
                    builder: (context, snapshot) {
                      final clubs = snapshot.data?.data?.clubs ?? [];

                      if (clubs.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.h),
                          child: Center(
                            child: Text(
                              "No clubs found",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: clubs.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              final club = clubs[index];
                              return ClubCardWidget(
                                title: club.name ?? "Unknown Club",
                                location: club.location ?? "",
                                members: (club.totalMembers ?? 0).toString(),
                                events: (club.totalChallenges ?? 0).toString(),
                                image:
                                    club.avatarUrl ??
                                    "https://images.unsplash.com/photo-1517649763962-0c623066013b?q=80&w=2070&auto=format&fit=crop",
                                onViewDetails: () {
                                  NavigationService.navigateTo(
                                    Routes.organizerCreateDetailsScreen,
                                    arguments: club.slug,
                                  );
                                },
                                onEdit: () async {
                                  await NavigationService.navigateTo(
                                    Routes.createClubBasicInfoScreen,
                                    arguments: club,
                                  );
                                  clubListRxObj.fetchClubList(
                                    _searchController.text,
                                  );
                                },
                                onDelete: () async {
                                  if (club.slug != null) {
                                    final res = await deleteClubRxObj
                                        .deleteClub(club.slug!);
                                    if (res != null) {
                                      // Refresh the list after deleting
                                      clubListRxObj.fetchClubList(
                                        _searchController.text,
                                      );
                                    }
                                  }
                                },
                                description: club.description,
                                socialLinks: club.socialLinks,
                              );
                            },
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: clubListRxObj.isLoadMore,
                            builder: (context, isLoadMore, child) {
                              if (isLoadMore) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColor.c2196F3,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          SizedBox(height: 100.h),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
