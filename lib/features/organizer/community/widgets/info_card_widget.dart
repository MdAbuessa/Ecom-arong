import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoCardWidget extends StatelessWidget {
  final String title;
  final String? content;
  final Widget? child;
  const InfoCardWidget({super.key, required this.title, this.content, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2128),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextFontStyle.textStyle16InterW600.copyWith(
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          if (content != null)
            Text(
              content!,
              style: TextFontStyle.textStyle14InterW400.copyWith(
                color: AppColor.c797A7C,
              ),
            ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
