// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/assets_helper/app_icons.dart';
import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/common_widgets/profile_avatar.dart';
import 'package:aarongonzales01/features/user/achivement/presentation/achivement_screen.dart';
import 'package:aarongonzales01/features/user/activity_summary/presentation/activity_summary_screen.dart';
import 'package:aarongonzales01/features/user/profile/model/get_user_info_model.dart';
import 'package:aarongonzales01/features/user/profile/presentation/event_leaderboard_screen.dart';
import 'package:aarongonzales01/features/user/profile/presentation/my_event_screen.dart';
import 'package:aarongonzales01/features/user/profile/presentation/setting_screen.dart';
import 'package:aarongonzales01/features/user/profile/presentation/nationwide_leaderboard_screen.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isParticipant = true;

  @override
  void initState() {
    super.initState();
    // Refresh on every visit so the screen is always up-to-date
    getUserInfoRxObj.fetchUserInfo();
  }

  /// Returns a formatted member-since string from an ISO timestamp.
  String _formatTimestamp(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) return '';
    try {
      final dt = DateTime.parse(timestamp.split(' ').first);
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return 'Member since ${dt.day.toString().padLeft(2, '0')} ${months[dt.month - 1]} ${dt.year}';
    } catch (_) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetUserInfoModel>(
      stream: getUserInfoRxObj.dataFetcher.stream,
      initialData: getUserInfoRxObj.dataFetcher.valueOrNull,
      builder: (context, snapshot) {
        final userInfo = snapshot.data;
        final user = userInfo?.data?.user;
        final isLoading = !snapshot.hasData;
        final displayName = (user?.firstName?.isNotEmpty == true
            ? user!.firstName!
            : user?.username) ??
            '';
        final memberSince = _formatTimestamp(userInfo?.timestamp);

        return Scaffold(
      backgroundColor: const Color(0xFF061115),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Top Bar (Back Button + Avatar + Settings)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomBackButton(),

                  // Avatar with shimmer
                  if (isLoading)
                    _shimmerCircle(radius: 46.r)
                  else
                    Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.12),
                          width: 1.5.w,
                        ),
                      ),
                      child: ProfileAvatar(
                        imageUrl: user?.avatar,
                        radius: 46,
                      ),
                    ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF132F3F).withOpacity(0.3),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF266FEF).withOpacity(0.5),
                          width: 1.w,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.settings_outlined,
                          color: const Color(0xFF266FEF),
                          size: 22.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // 2. Name & Join Date
              if (isLoading) ...[
                _shimmerBox(width: 140.w, height: 22.h, radius: 6),
                SizedBox(height: 8.h),
                _shimmerBox(width: 180.w, height: 14.h, radius: 6),
              ] else ...[
                Text(
                  displayName.isNotEmpty ? displayName : 'User',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                if (memberSince.isNotEmpty)
                  Text(
                    memberSince,
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
              ],
              SizedBox(height: 24.h),

              // 3. Grid of Stats
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      iconWidget: _buildStatIcon(icon: Icons.trending_up),
                      value: "127",
                      label: "Total Miles",
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildStatCard(
                      iconWidget: _buildStatIcon(
                        icon: Icons.calendar_month_outlined,
                      ),
                      value: "12",
                      label: "Events",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      iconWidget: _buildStatIcon(
                        child: Image.asset(
                          'assets/images/coin.png',
                          width: 20.w,
                          height: 20.w,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.monetization_on,
                            color: Colors.amber,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      value: "1000",
                      label: "Total Point",
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildStatCard(
                      iconWidget: _buildStatIcon(
                        icon: Icons.description_outlined,
                      ),
                      value: "152",
                      label: "Certificates",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // 4. Menu Items List
              _buildListItem(
                title: "My posts",
                onTap: () {},
              ),
              _buildListItem(
                title: "Achievements",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AchivementScreen(),
                    ),
                  );
                },
              ),
              _buildListItem(
                title: "Activity Summary",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ActivitySummaryScreen(),
                    ),
                  );
                },
              ),
              _buildListItem(
                title: "My Events",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyEventScreen(),
                    ),
                  );
                },
              ),
              _buildListItem(
                title: "Event Leaderboards",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EventLeaderboardScreen(),
                    ),
                  );
                },
              ),
              _buildListItem(
                title: "Nationwide Leaderboard",
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const NationwideLeaderboardScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 24.h),

              // 5. Switch Profile Toggle
              Text(
                "Switch Profile To",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isParticipant = true;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _isParticipant
                              ? const Color(0xFF266FEF)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: const Color(0xFF266FEF),
                            width: 1.5.w,
                          ),
                        ),
                        child: Text(
                          "Participant",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isParticipant = false;
                        });
                        NavigationService.navigateToReplacement(
                          Routes.chooseRoleScreen,
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: !_isParticipant
                              ? const Color(0xFF266FEF)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(
                            color: const Color(0xFF266FEF),
                            width: 1.5.w,
                          ),
                        ),
                        child: Text(
                          "Organizer",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
      },
    );
  }

  // ── Shimmer helpers ───────────────────────────────────────────────────────

  Widget _shimmerCircle({required double radius}) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1E2830),
      highlightColor: const Color(0xFF2E3C4A),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: const Color(0xFF1E2830),
      ),
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1E2830),
      highlightColor: const Color(0xFF2E3C4A),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF1E2830),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  // ── Reusable widgets ──────────────────────────────────────────────────────

  Widget _buildStatIcon({Widget? child, IconData? icon}) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: const Color(0xFF132F3F).withOpacity(0.3),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF266FEF).withOpacity(0.2),
          width: 1.w,
        ),
      ),
      child: child ?? Icon(icon, color: const Color(0xFF266FEF), size: 20.sp),
    );
  }

  Widget _buildStatCard({
    required Widget iconWidget,
    required String value,
    required String label,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF091115),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconWidget,
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem({required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF091115),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withOpacity(0.05), width: 1.w),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: const Color(0xFF132F3F).withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFF266FEF), width: 1.w),
              ),
              child: SvgPicture.asset(
                AppIcons.arrowRight,
                color: const Color(0xFF266FEF),
                height: 20,
                width: 20,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.white.withOpacity(0.4),
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
