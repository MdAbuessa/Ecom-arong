// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Reusable expandable tile for settings sections (Account, App, Data & Syncing).
class SettingExpandableTile extends StatelessWidget {
  const SettingExpandableTile({
    super.key,
    required this.assetIcon,
    required this.title,
    required this.isExpanded,
    required this.onToggle,
    required this.animation,
    required this.children,
  });

  final String assetIcon;
  final String title;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Animation<double> animation;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header row
        GestureDetector(
          onTap: onToggle,
          child: Container(
            margin: EdgeInsets.only(bottom: isExpanded ? 0 : 12.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF091115),
              borderRadius: isExpanded
                  ? BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    )
                  : BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.05),
                width: 1.w,
              ),
            ),
            child: Row(
              children: [
                // Icon badge
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF132F3F).withOpacity(0.3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF266FEF).withOpacity(0.2),
                      width: 1.w,
                    ),
                  ),
                  child: SizedBox(
                    width: 22.w,
                    height: 22.w,
                    child: Center(
                      child: Image.asset(
                        assetIcon,
                        width: 22.w,
                        height: 22.w,
                        color: const Color(0xFF266FEF),
                      ),
                    ),
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
                // Animated chevron
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeInOut,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white.withOpacity(0.6),
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Expandable content
        SizeTransition(
          sizeFactor: animation,
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1A23),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
              border: Border(
                left: BorderSide(
                  color: Colors.white.withOpacity(0.05),
                  width: 1.w,
                ),
                right: BorderSide(
                  color: Colors.white.withOpacity(0.05),
                  width: 1.w,
                ),
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.05),
                  width: 1.w,
                ),
              ),
            ),
            child: Column(children: children),
          ),
        ),
      ],
    );
  }
}
