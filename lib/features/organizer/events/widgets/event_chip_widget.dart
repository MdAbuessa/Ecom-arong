import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventChipWidget extends StatelessWidget {
  final String label;

  const EventChipWidget({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF374151),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextFontStyle.textStyle14InterW400.copyWith(
          color: Colors.white,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
