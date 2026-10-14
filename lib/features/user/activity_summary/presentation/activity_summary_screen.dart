// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivitySummaryScreen extends StatefulWidget {
  const ActivitySummaryScreen({super.key});

  @override
  State<ActivitySummaryScreen> createState() => _ActivitySummaryScreenState();
}

class _ActivitySummaryScreenState extends State<ActivitySummaryScreen> {
  // Mock data for the activity summaries
  final List<Map<String, dynamic>> _summaries = [
    {
      'title': 'Daily Miles',
      'valueText': '87.3 / 100 km',
      'progress': 0.64,
      'percentageText': '64% Complete',
    },
    {
      'title': 'Weekly Miles',
      'valueText': '87.3 / 100 km',
      'progress': 0.68,
      'percentageText': '68% Complete',
    },
    {
      'title': 'Monthly Miles',
      'valueText': '87.3 / 100 km',
      'progress': 0.82,
      'percentageText': '82% Complete',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115), // Deep premium background color
      body: SafeArea(
        child: Column(
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
                    'Activity Summary',
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
            SizedBox(height: 24.h),

            // ── Activity Cards List ─────────────────────────────────────
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: _summaries.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final summary = _summaries[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF091115), // Dark card bg color
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.05),
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top info row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              summary['title'],
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              summary['valueText'],
                              style: GoogleFonts.inter(
                                color: Colors.white.withOpacity(0.55),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),

                        // Progress Bar (Vibrant blue bar with clean light track)
                        Stack(
                          children: [
                            Container(
                              height: 10.h,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9), // Bright light track color
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            FractionallySizedBox(
                              widthFactor: summary['progress'],
                              child: Container(
                                height: 10.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF266FEF), // Vibrant blue accent fill
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),

                        // Bottom row (Percentage complete + Details button)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              summary['percentageText'],
                              style: GoogleFonts.inter(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Dynamic premium micro-feedback interaction
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Showing details for ${summary['title']}',
                                      style: GoogleFonts.inter(color: Colors.white),
                                    ),
                                    backgroundColor: const Color(0xFF132F3F),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              },
                              child: Text(
                                'View Details',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF266FEF),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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