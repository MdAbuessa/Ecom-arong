// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// A single info row used inside expandable setting tiles.
class SettingInfoRow extends StatelessWidget {
  const SettingInfoRow({
    super.key,
    this.icon,
    this.assetIcon,
    required this.label,
    required this.trailing,
    required this.showDivider,
    this.onTap,
  });

  final IconData? icon;
  final String? assetIcon;
  final String label;
  final Widget trailing;
  final bool showDivider;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                if (assetIcon != null)
                  Image.asset(
                    assetIcon!,
                    width: 20.sp,
                    height: 20.sp,
                    color: Colors.white.withOpacity(0.55),
                  )
                else if (icon != null)
                  Icon(
                    icon,
                    color: Colors.white.withOpacity(0.55),
                    size: 20.sp,
                  ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Text(
                    label,
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.85),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                trailing,
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.white.withOpacity(0.05),
            indent: 16.w,
            endIndent: 16.w,
          ),
      ],
    );
  }
}
