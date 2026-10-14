import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentEventCardWidget extends StatelessWidget {
  final String title;
  final String status;
  final String date;
  final String participants;
  final String revenue;
  final VoidCallback? onTap;
  final VoidCallback? onDeleteTap;

  const RecentEventCardWidget({
    super.key,
    required this.title,
    required this.status,
    required this.date,
    required this.participants,
    required this.revenue,
    this.onTap,
    this.onDeleteTap,
  });

  Color _getStatusBgColor() {
    switch (status.toLowerCase()) {
      case 'ongoing':
        return const Color(0xFF1E3A2F);
      case 'upcoming':
        return const Color(0xFF1C3A5A);
      case 'draft':
        return const Color(0xFF3A2E1C);
      case 'publish':
      case 'published':
        return const Color(0xFF1A3A3A);
      case 'completed':
      default:
        return const Color(0xFF2C353F);
    }
  }

  Color _getStatusTextColor() {
    switch (status.toLowerCase()) {
      case 'ongoing':
        return const Color(0xFF4CAF50);
      case 'upcoming':
        return const Color(0xFF2196F3);
      case 'draft':
        return const Color(0xFFFFB74D);
      case 'publish':
      case 'published':
        return const Color(0xFF00BFA5);
      case 'completed':
      default:
        return Colors.white70;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1B232A),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextFontStyle.textStyle14InterW500.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusBgColor(),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    status,
                    style: TextFontStyle.textStyle14InterW400.copyWith(
                      color: _getStatusTextColor(),
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.white54,
                  size: 14.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  date,
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    color: Colors.white70,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(Icons.people_outline, color: Colors.white54, size: 14.sp),
                SizedBox(width: 4.w),
                Text(
                  participants,
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    color: Colors.white70,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(Icons.attach_money, color: Colors.white54, size: 14.sp),
                SizedBox(width: 2.w),
                Text(
                  revenue,
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    color: Colors.white70,
                    fontSize: 12.sp,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: onDeleteTap,
                  child: Icon(Icons.delete, color: Colors.red, size: 20.sp),
                ),
                UIHelper.horizontalSpace(12.w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
