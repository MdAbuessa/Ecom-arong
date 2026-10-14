import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomActionButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const BottomActionButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: const Color(0xFF334155), // Lighter grey than background
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle14InterW500.copyWith(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle14InterW400.copyWith(
                color: AppColor.cD5D6D6,
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
