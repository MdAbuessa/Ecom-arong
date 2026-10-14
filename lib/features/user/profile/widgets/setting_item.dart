// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Generic non-expandable settings row (e.g. Personal Information, Privacy Policy, Log Out).
class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.iconWidget,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  final Widget iconWidget;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final iconBgColor = isDestructive
        ? const Color(0xFF3F1313).withOpacity(0.3)
        : const Color(0xFF132F3F).withOpacity(0.3);
    final iconBorderColor = isDestructive
        ? const Color(0xFFEF2626).withOpacity(0.2)
        : const Color(0xFF266FEF).withOpacity(0.2);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF091115),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.05),
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
                border: Border.all(color: iconBorderColor, width: 1.w),
              ),
              child: SizedBox(
                width: 22.w,
                height: 22.w,
                child: Center(child: iconWidget),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.inter(
                  color:
                      isDestructive ? const Color(0xFFEF2626) : Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: isDestructive
                  ? const Color(0xFFEF2626).withOpacity(0.5)
                  : Colors.white.withOpacity(0.4),
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }
}
