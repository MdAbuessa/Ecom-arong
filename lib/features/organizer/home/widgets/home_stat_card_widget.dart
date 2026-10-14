import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeStatCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const HomeStatCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1B232A), // Dark blue-grey for card background
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: Colors.white70,
                  fontSize: 12.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Color(0xFF2196F3), //
                  size: 16.sp,
                ),
              ),
            ],
          ),
          // SizedBox(height: 12.h),
          Text(
            value,
            style: TextFontStyle.textStyle24RobotoW600.copyWith(
              color: Colors.white,
              fontSize: 22.sp,
            ),
          ),
        ],
      ),
    );
  }
}
