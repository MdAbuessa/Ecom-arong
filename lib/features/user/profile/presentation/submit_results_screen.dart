// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/features/user/profile/presentation/manual_upload_screen.dart';
import 'package:aarongonzales01/features/user/profile/presentation/recent_activities_screen.dart';
import 'package:aarongonzales01/features/user/profile/presentation/sync_from_device_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmitResultsScreen extends StatefulWidget {
  const SubmitResultsScreen({super.key});

  @override
  State<SubmitResultsScreen> createState() => _SubmitResultsScreenState();
}

class _SubmitResultsScreenState extends State<SubmitResultsScreen> {
  int _selectedMethodIndex = 0; // Recent Activities selected by default (matches screenshot highlight)

  final List<Map<String, dynamic>> _methods = [
    {
      'title': 'Recent Activities',
      'subtitle': 'Select from activities after registration',
      'icon': Icons.insights_rounded,
    },
    {
      'title': 'Sync from Device',
      'subtitle': 'Import from connected devices',
      'icon': Icons.smartphone_rounded,
    },
    {
      'title': 'Manual Upload',
      'subtitle': 'Enter your results manually',
      'icon': Icons.description_rounded,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115), // Matching deep dark background
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                const CustomBackButton(),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 40.w), // Offset the back button space to center the title
                      child: Text(
                        'Submit Results',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Choose submission method Header
            Text(
              'Choose submission method',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 24.h),

            // Submission Methods List
            Expanded(
              child: ListView.separated(
                itemCount: _methods.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final method = _methods[index];
                  final isSelected = _selectedMethodIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMethodIndex = index;
                      });
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RecentActivitiesScreen(),
                          ),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SyncFromDeviceScreen(),
                          ),
                        );
                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ManualUploadScreen(),
                          ),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFF101B20), // Dark card bg color
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF266FEF)
                              : Colors.white.withOpacity(0.04),
                          width: isSelected ? 1.5.w : 1.w,
                        ),
                      ),
                      child: Row(
                        children: [
                          // Blue rounded Icon container
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFF266FEF),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              method['icon'],
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 16.w),

                          // Text Column
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  method['title'],
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  method['subtitle'],
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
