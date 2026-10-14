// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AchivementScreen extends StatefulWidget {
  const AchivementScreen({super.key});

  @override
  State<AchivementScreen> createState() => _AchivementScreenState();
}

class _AchivementScreenState extends State<AchivementScreen> {
  int _selectedTabIndex = 0; // 0 for Badges, 1 for Certificates

  // Data for Badges (6 items)
  final List<Map<String, dynamic>> _badges = [
    {
      'title': 'First Race',
      'icon': Icons.emoji_events,
      'color': const Color(0xFFFFB300), // Yellow
    },
    {
      'title': 'Speed Demon',
      'icon': Icons.bolt,
      'color': const Color(0xFFFF5722), // Orange
    },
    {
      'title': '100 Miles',
      'icon': Icons.star_rounded,
      'color': const Color(0xFF9C27B0), // Purple
    },
    {
      'title': 'Early Bird',
      'icon': Icons.wb_sunny_rounded,
      'color': const Color(0xFF00ACC1), // Teal
    },
    {
      'title': 'Streak Master',
      'icon': Icons.local_fire_department_rounded,
      'color': const Color(0xFF4CAF50), // Green
    },
    {
      'title': 'Champion',
      'icon': Icons.military_tech_rounded,
      'color': const Color(0xFFE53935), // Red
    },
  ];

  // Data for Certificates (4 items)
  final List<Map<String, dynamic>> _certificates = [
    {
      'title': '5K Finisher Certificate',
      'date': 'Oct 12, 2025',
      'code': 'CERT-5K-9834',
    },
    {
      'title': '10K Power Challenge',
      'date': 'Nov 05, 2025',
      'code': 'CERT-10K-0294',
    },
    {
      'title': 'Half Marathon Badge',
      'date': 'Dec 18, 2025',
      'code': 'CERT-HM-1182',
    },
    {
      'title': 'Sprint King Challenge',
      'date': 'Jan 14, 2026',
      'code': 'CERT-SK-8839',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115), // Deep premium background color
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header (Back Button + Centered Title) ──────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomBackButton(),
                  Text(
                    'Achievements',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 44.w), // Spacer to balance back button
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // ── Tab Selection Row ────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  // Badges Tab
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = 0;
                        });
                      },
                      child: Container(
                        height: 44.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 0
                              ? const Color(0xFF266FEF) // Active blue
                              : const Color(0xFF131E25), // Inactive dark bg
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'Badges (6)',
                          style: GoogleFonts.inter(
                            color: _selectedTabIndex == 0
                                ? Colors.white
                                : Colors.white.withOpacity(0.55),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Certificates Tab
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = 1;
                        });
                      },
                      child: Container(
                        height: 44.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _selectedTabIndex == 1
                              ? const Color(0xFF266FEF) // Active blue
                              : const Color(0xFF131E25), // Inactive dark bg
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          'Certificates (4)',
                          style: GoogleFonts.inter(
                            color: _selectedTabIndex == 1
                                ? Colors.white
                                : Colors.white.withOpacity(0.55),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.h),

            // ── Tab Content ──────────────────────────────────────────────
            Expanded(
              child: _selectedTabIndex == 0
                  ? _buildBadgesView()
                  : _buildCertificatesView(),
            ),
          ],
        ),
      ),
    );
  }

  // ── Badges Tab View ────────────────────────────────────────────────────────
  Widget _buildBadgesView() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Horizontally Scrollable Badges List
          SizedBox(
            height: 144.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _badges.length,
              separatorBuilder: (context, index) => SizedBox(width: 12.w),
              itemBuilder: (context, index) {
                final badge = _badges[index];
                return Container(
                  width: 104.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF091115),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: const Color(0xFF266FEF).withOpacity(0.4),
                      width: 1.5.w,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Circular Icon wrapper
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: badge['color'],
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: badge['color'].withOpacity(0.3),
                              blurRadius: 8.r,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Icon(
                          badge['icon'],
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        badge['title'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 36.h),

          // Next Milestone Info (Premium Element)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next Milestone',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF101B20),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.04),
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2830),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.insights_rounded,
                          color: const Color(0xFF266FEF),
                          size: 22.sp,
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Centurion Runner',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            // Progress bar
                            Stack(
                              children: [
                                Container(
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: 0.75, // 75% progress
                                  child: Container(
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF266FEF),
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Complete 100 runs',
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withOpacity(0.4),
                                    fontSize: 12.sp,
                                  ),
                                ),
                                Text(
                                  '75/100',
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF266FEF),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
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

  // ── Certificates Tab View ──────────────────────────────────────────────────
  Widget _buildCertificatesView() {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      physics: const BouncingScrollPhysics(),
      itemCount: _certificates.length,
      separatorBuilder: (context, index) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final cert = _certificates[index];
        return Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: const Color(0xFF091115),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.04),
              width: 1.w,
            ),
          ),
          child: Row(
            children: [
              // Icon Badge style
              Container(
                width: 46.w,
                height: 46.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E2830),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.article_outlined,
                  color: const Color(0xFF266FEF),
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cert['title'],
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          cert['date'],
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          width: 3.r,
                          height: 3.r,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          cert['code'],
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.file_download_outlined,
                  color: Colors.white.withOpacity(0.55),
                  size: 20.sp,
                ),
                onPressed: () {
                  // Simulate download certificate Action
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
