// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentActivitiesScreen extends StatefulWidget {
  const RecentActivitiesScreen({super.key});

  @override
  State<RecentActivitiesScreen> createState() => _RecentActivitiesScreenState();
}

class _RecentActivitiesScreenState extends State<RecentActivitiesScreen> {
  int _selectedActivityIndex = 0; // Highlight first card by default

  final List<Map<String, dynamic>> _activities = [
    {
      'title': 'Morning Run',
      'date': 'March 20, 2026',
      'distance': '5.2 km',
      'time': '32:15',
      'pace': '6:12 /km',
    },
    {
      'title': 'Evening Jog',
      'date': 'March 18, 2026',
      'distance': '5.0 km',
      'time': '30:45',
      'pace': '6:09 /km',
    },
    {
      'title': 'Park Run',
      'date': 'March 20, 2026',
      'distance': '4.8 km',
      'time': '29:30',
      'pace': '6:08 /km',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115), // Deep dark background
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
                      padding: EdgeInsets.only(right: 40.w), // Offset back button to center the title
                      child: Text(
                        'Recent Activities',
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
          children: [
            // List of Recent Activities
            Expanded(
              child: ListView.separated(
                itemCount: _activities.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final activity = _activities[index];
                  final isSelected = _selectedActivityIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedActivityIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF101B20), // Dark card background
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF266FEF)
                              : Colors.white.withOpacity(0.04),
                          width: isSelected ? 1.5.w : 1.w,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Activity Title
                          Text(
                            activity['title'],
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4.h),

                          // Activity Date
                          Text(
                            activity['date'],
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 12.h),

                          // Stats Row
                          Row(
                            children: [
                              // Distance (Cyan)
                              Text(
                                activity['distance'],
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF00E5FF),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 24.w),

                              // Time (Subtle White)
                              Text(
                                activity['time'],
                                style: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 24.w),

                              // Pace (Subtle White)
                              Text(
                                activity['pace'],
                                style: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Bottom Action Button
            GestureDetector(
              onTap: () {
                // Show a modern success Snackbar and pop twice to go back to the details screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: const Color(0xFF101B20),
                    content: Text(
                      'Activity successfully submitted!',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                );
                Navigator.pop(context); // Go back to SubmitResultsScreen
              },
              child: Container(
                width: double.infinity,
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF266FEF),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Text(
                  'Submit',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
