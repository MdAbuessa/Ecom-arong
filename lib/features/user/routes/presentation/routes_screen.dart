// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => _RoutesScreenState();
}

class _RoutesScreenState extends State<RoutesScreen> {

  
  final TextEditingController _searchController = TextEditingController();
  String _selectedActivity = 'Walk';

  final List<String> _activities = ['Walk', 'Run', 'Hike', 'Ride'];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          children: [
            // 1. Map Background
            Positioned.fill(
              child: Image.asset(
                AppImages.map,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF0F172A),
                    child: Center(
                      child: Icon(
                        Icons.map_outlined,
                        color: Colors.white54,
                        size: 64.sp,
                      ),
                    ),
                  );
                },
              ),
            ),

            // 2. Floating Top Row (Search + Filter) & Horizontal Chips
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search & Filter Row
                    Row(
                      children: [
                        // Search Bar
                        Expanded(
                          child: Container(
                            height: 52.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D1216).withOpacity(0.6),
                              borderRadius: BorderRadius.circular(30.r),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                                width: 1.w,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: const Color(0xFF8993A4),
                                  size: 24.sp,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Search routes',
                                      hintStyle: GoogleFonts.inter(
                                        color: const Color(0xFF8993A4),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                  ),
                                ),
                                if (_searchController.text.isNotEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _searchController.clear();
                                      });
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: const Color(0xFF8993A4),
                                      size: 20.sp,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // Filter Button
                        GestureDetector(
                          onTap: () {
                            // Handle Filter Action
                          },
                          child: Container(
                            height: 52.h,
                            width: 52.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D1216).withOpacity(0.6),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                                width: 1.w,
                              ),
                            ),
                            child: Icon(
                              Icons.tune,
                              color: Colors.white,
                              size: 22.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Horizontal Category Chips
                    SizedBox(
                      height: 40.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _activities.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final activity = _activities[index];
                          final isSelected = _selectedActivity == activity;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedActivity = activity;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColor.c266FEF
                                    : const Color(0xFF0D1216).withOpacity(0.6),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.transparent
                                      : Colors.white.withOpacity(0.1),
                                  width: 1.w,
                                ),
                              ),
                              child: Text(
                                activity,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 15.sp,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 3. Floating Right Buttons (Zoom, Locate, Bookmark)
            Positioned(
              right: 16.w,
              bottom: 120.h, // Positioned above the Bottom Nav Bar
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFloatingActionButton(
                    icon: Icons.add,
                    onTap: () {
                      // Zoom In or Add Route Action
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildFloatingActionButton(
                    icon: Icons.near_me,
                    onTap: () {
                      // Locate user Action
                    },
                  ),
                  SizedBox(height: 12.h),
                  _buildFloatingActionButton(
                    icon: Icons.bookmark_border,
                    onTap: () {
                      // Bookmarked routes Action
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52.h,
        width: 52.w,
        decoration: BoxDecoration(
          color: const Color(0xFF0D1216).withOpacity(0.6),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 24.sp),
      ),
    );
  }
}
