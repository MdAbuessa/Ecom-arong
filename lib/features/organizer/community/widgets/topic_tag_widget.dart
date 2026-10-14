import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopicTagWidget extends StatelessWidget {
  final String label;
  const TopicTagWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D3748),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextFontStyle.textStyle14InterW400.copyWith(
          color: AppColor.c797A7C,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
