import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChallengeCardWidget extends StatelessWidget {
  final String title;
  final String goal;
  final String daysLeft;
  final double progress;
  final String? image;

  final VoidCallback? onDelete;

  const ChallengeCardWidget({
    super.key,
    required this.title,
    required this.goal,
    required this.daysLeft,
    required this.progress,
    this.image,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2128),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundImage: NetworkImage(
                  image != null && image!.isNotEmpty
                      ? image!
                      : "https://images.unsplash.com/photo-1517649763962-0c623066013b?q=80&w=2070&auto=format&fit=crop",
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: TextFontStyle.textStyle16InterW600.copyWith(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: onDelete,
                child: Icon(Icons.delete, color: AppColor.cB91C1C, size: 24.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                goal,
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: AppColor.c797A7C,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                daysLeft,
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: AppColor.c797A7C,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: const Color(0xFF2D3748),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColor.c2196F3),
            minHeight: 6.h,
            borderRadius: BorderRadius.circular(3.r),
          ),
        ],
      ),
    );
  }
}
