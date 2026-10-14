import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MailCard extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final bool isSelected;
  final VoidCallback? onTap;

  const MailCard({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1B232A),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? AppColor.c2196F3 : Colors.transparent,
            width: 1.5.w,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: const BoxDecoration(
                color: Color(0xFF0E1E26),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.mail_outline,
                color: AppColor.c2196F3,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextFontStyle.textStyle16InterW600.copyWith(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                      Text(
                        time,
                        style: TextFontStyle.textStyle14InterW400.copyWith(
                          color: Colors.white38,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    message,
                    style: TextFontStyle.textStyle14InterW400.copyWith(
                      color: Colors.white54,
                      fontSize: 12.sp,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
