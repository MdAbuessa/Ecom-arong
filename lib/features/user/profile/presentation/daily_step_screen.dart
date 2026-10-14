// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DailyStepScreen extends StatefulWidget {
  final int initialGoal;
  const DailyStepScreen({super.key, this.initialGoal = 6000});

  @override
  State<DailyStepScreen> createState() => _DailyStepScreenState();
}

class _DailyStepScreenState extends State<DailyStepScreen> {
  late final List<int> _stepOptions;
  late final FixedExtentScrollController _scrollController;
  late int _selectedGoal;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    // Generates values from 2000 to 20000 with step size of 500
    _stepOptions = List.generate(37, (index) => 2000 + index * 500);
    
    // Find initial index
    int initialIndex = _stepOptions.indexOf(widget.initialGoal);
    if (initialIndex == -1) {
      initialIndex = _stepOptions.indexOf(6000);
    }
    _selectedIndex = initialIndex;
    _selectedGoal = _stepOptions[initialIndex];
    _scrollController = FixedExtentScrollController(initialItem: initialIndex);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        decoration: BoxDecoration(
          color: const Color(0xFF101B20), // Premium dark teal/gray dialog bg
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.04),
            width: 1.w,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Dialog Title ──
            Text(
              "Daily Step Goal",
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 24.h),

            // ── Picker Area ──
            SizedBox(
              height: 140.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Scroll wheel container
                  SizedBox(
                    width: 100.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Highlight lines above and below selection
                        Positioned(
                          top: 46.h,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 1.2.h,
                            color: Colors.white.withOpacity(0.12),
                          ),
                        ),
                        Positioned(
                          bottom: 46.h,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 1.2.h,
                            color: Colors.white.withOpacity(0.12),
                          ),
                        ),

                        // List wheel scroll view
                        ListWheelScrollView.useDelegate(
                          controller: _scrollController,
                          itemExtent: 44.h,
                          perspective: 0.003,
                          diameterRatio: 1.2,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedIndex = index;
                              _selectedGoal = _stepOptions[index];
                            });
                          },
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: _stepOptions.length,
                            builder: (context, index) {
                              final isSelected = index == _selectedIndex;
                              return Center(
                                child: Text(
                                  "${_stepOptions[index]}",
                                  style: GoogleFonts.inter(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white.withOpacity(0.35),
                                    fontSize: isSelected ? 22.sp : 17.sp,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Suffix label
                  Text(
                    "Steps/ day",
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.4),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.h),

            // ── Actions Buttons ──
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 48.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2830), // Dark action bg
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14.w),

                // OK Button
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, _selectedGoal),
                    child: Container(
                      height: 48.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF266FEF), // Primary blue accent
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        "OK",
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
          ],
        ),
      ),
    );
  }
}