import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialIconWidget extends StatelessWidget {
  final IconData icon;
  const SocialIconWidget({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: const BoxDecoration(
        color: Color(0xFF1A2128),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: AppColor.c2196F3, size: 20.sp),
    );
  }
}
