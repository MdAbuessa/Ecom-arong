import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventInfoCardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget content;

  const EventInfoCardWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1C252E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 20.sp),
              UIHelper.horizontalSpace(10.w),
              Text(
                title,
                style: TextFontStyle.textStyle16InterW600.copyWith(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          UIHelper.verticalSpace(15.h),
          content,
        ],
      ),
    );
  }
}
