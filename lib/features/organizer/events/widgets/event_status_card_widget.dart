import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventStatusCardWidget extends StatelessWidget {
  final String title;
  final String location;
  final String date;
  final String participants;
  final String revenue;
  final String status;
  final double progress;
  final VoidCallback onTapViewDetails;
  final VoidCallback onTapEdit;
  final VoidCallback onTapDelete;

  const EventStatusCardWidget({
    super.key,
    required this.title,
    required this.location,
    required this.date,
    required this.participants,
    required this.revenue,
    required this.status,
    this.progress = 0.0,
    required this.onTapViewDetails,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1E242B),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextFontStyle.textStyle14InterW500.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white54,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          location,
                          style: TextFontStyle.textStyle14InterW400.copyWith(
                            color: Colors.white54,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (status.toLowerCase() == 'draft')
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A2E1C),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    "Draft",
                    style: TextFontStyle.textStyle14InterW400.copyWith(
                      color: const Color(0xFFFFB74D),
                      fontSize: 10.sp,
                    ),
                  ),
                )
              else
                SizedBox(
                  width: 50.w,
                  height: 50.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 46.w,
                        height: 46.w,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 5.w,
                          backgroundColor: AppColor.c2196F3.withOpacity(0.2),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColor.c2196F3,
                          ),
                        ),
                      ),
                      Text(
                        "${(progress * 100).toInt()}%",
                        style: TextFontStyle.textStyle14InterW500.copyWith(
                          color: AppColor.c2196F3,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
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
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onTapViewDetails,
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    side: BorderSide(color: AppColor.c2196F3.withOpacity(0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "View details",
                    style: TextFontStyle.textStyle16InterW600.copyWith(
                      color: AppColor.c2196F3,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF2C353F),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: onTapEdit,
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.white70,
                    size: 18.sp,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF2C353F),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: onTapDelete,
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.redAccent,
                    size: 18.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
