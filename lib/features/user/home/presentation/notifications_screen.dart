// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115), // Deep dark premium background
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              children: [
                const CustomBackButton(),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Notifications',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '3 new notifications',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF266FEF).withOpacity(0.85),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── TODAY SECTION ──
              _buildSectionHeader('Today'),
              SizedBox(height: 12.h),
              // Today notifications are grouped in a container card as shown in the mockup
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF101B20),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.02),
                    width: 1.w,
                  ),
                ),
                child: Column(
                  children: [
                    _buildNotificationItem(
                      name: 'Run Squad',
                      actionText: ' posted a new update',
                      time: '10m ago',
                      badgeIcon: Icons.group_add_rounded,
                      badgeBgColor: const Color(0xFF266FEF),
                      imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&auto=format&fit=crop&q=80',
                      isUnread: true,
                      showDivider: true,
                    ),
                    _buildNotificationItem(
                      name: 'John Mitchell',
                      actionText: ' liked your activity',
                      time: '25m ago',
                      badgeIcon: Icons.favorite,
                      badgeBgColor: const Color(0xFFFF2D55),
                      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80',
                      isUnread: true,
                      showDivider: true,
                    ),
                    _buildNotificationItem(
                      name: 'Anna Rodriguez',
                      actionText: ' shared your post',
                      time: '1h ago',
                      badgeIcon: Icons.share_rounded,
                      badgeBgColor: const Color(0xFF266FEF),
                      imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&auto=format&fit=crop&q=80',
                      isUnread: true,
                      showDivider: true,
                    ),
                    _buildNotificationItem(
                      name: 'Morning Warriors',
                      actionText: ' posted a new',
                      time: '2h ago',
                      badgeIcon: Icons.calendar_month_rounded,
                      badgeBgColor: const Color(0xFF9C27B0),
                      imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&auto=format&fit=crop&q=80',
                      isUnread: false,
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // ── YESTERDAY SECTION ──
              _buildSectionHeader('Yesterday'),
              SizedBox(height: 12.h),
              _buildNotificationItem(
                name: 'Fitness Enthusiasts',
                actionText: ' a new posted',
                time: 'Yesterday',
                badgeIcon: Icons.group_rounded,
                badgeBgColor: const Color(0xFF9C27B0),
                imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&auto=format&fit=crop&q=80',
                isUnread: false,
                showDivider: false,
              ),
              _buildNotificationItem(
                name: 'You completed 70% of your challenge!',
                actionText: '',
                time: 'Yesterday',
                badgeIcon: Icons.trending_up_rounded,
                badgeBgColor: const Color(0xFFFF9800),
                imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=100&auto=format&fit=crop&q=80',
                isUnread: false,
                showDivider: false,
              ),
              _buildNotificationItem(
                name: 'Rarah Johnson',
                actionText: ' liked your activity',
                time: 'Yesterday',
                badgeIcon: Icons.favorite,
                badgeBgColor: const Color(0xFFFF2D55),
                imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100&auto=format&fit=crop&q=80',
                isUnread: false,
                showDivider: false,
              ),
              SizedBox(height: 24.h),

              // ── EARLIER SECTION ──
              _buildSectionHeader('Earlier'),
              SizedBox(height: 12.h),
              _buildNotificationItem(
                name: 'Sarah Johnson',
                actionText: ' liked your activity',
                time: '1 days ago',
                badgeIcon: Icons.favorite,
                badgeBgColor: const Color(0xFFFF2D55),
                imageUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&auto=format&fit=crop&q=80',
                isUnread: false,
                showDivider: false,
              ),
              _buildNotificationItem(
                name: 'Morning Warriors',
                actionText: ' posted a new event',
                time: '2 days ago',
                badgeIcon: Icons.calendar_month_rounded,
                badgeBgColor: const Color(0xFF9C27B0),
                imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100&auto=format&fit=crop&q=80',
                isUnread: false,
                showDivider: false,
              ),
              _buildNotificationItem(
                name: 'Mike Chen',
                actionText: ' liked your activity',
                time: '4 days ago',
                badgeIcon: Icons.favorite,
                badgeBgColor: const Color(0xFFFF2D55),
                imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80',
                isUnread: false,
                showDivider: false,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 15.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildNotificationItem({
    required String name,
    required String actionText,
    required String time,
    required IconData badgeIcon,
    required Color badgeBgColor,
    required String imageUrl,
    required bool isUnread,
    required bool showDivider,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            children: [
              // Avatar with Badge
              Stack(
                children: [
                  Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(3.r),
                      decoration: BoxDecoration(
                        color: badgeBgColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF101B20),
                          width: 1.5.w,
                        ),
                      ),
                      child: Icon(
                        badgeIcon,
                        color: Colors.white,
                        size: 10.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),

              // Content Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: name,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: actionText,
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      time,
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.45),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              // Unread Indicator
              if (isUnread) ...[
                SizedBox(width: 12.w),
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF266FEF),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (showDivider)
          Divider(
            color: Colors.white.withOpacity(0.04),
            height: 1.h,
            thickness: 1.h,
            indent: 16.w,
            endIndent: 16.w,
          ),
      ],
    );
  }
}
