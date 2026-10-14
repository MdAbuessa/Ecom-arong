import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;
  const StatCardWidget({
    super.key,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1A2128),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: AppColor.c797A7C,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                value,
                style: TextFontStyle.textStyle16InterW600.copyWith(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
