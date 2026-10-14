import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventDetailItemWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const EventDetailItemWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColor.c2196F3, size: 24.sp),
        UIHelper.horizontalSpace(15.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextFontStyle.textStyle14InterW400.copyWith(
                color: Colors.white70,
                fontSize: 12.sp,
              ),
            ),
            Text(
              value,
              style: TextFontStyle.textStyle16InterW600.copyWith(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
