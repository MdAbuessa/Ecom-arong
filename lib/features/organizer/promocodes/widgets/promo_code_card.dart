import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoCodeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String code;
  final String status;
  final String discount;
  final String used;
  final String expires;

  const PromoCodeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.code,
    required this.status,
    required this.discount,
    required this.used,
    required this.expires,
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF142C3E),
        content: Text(
          "Promo code '$code' copied to clipboard!",
          style: TextFontStyle.textStyle14InterW500.copyWith(
            color: AppColor.c2196F3,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color badgeBgColor;
    Color badgeTextColor;

    switch (status.toLowerCase()) {
      case 'active':
        badgeBgColor = const Color(0xFF10281F);
        badgeTextColor = const Color(0xFF22C55E);
        break;
      case 'inactive':
        badgeBgColor = const Color(0xFF2B3338);
        badgeTextColor = Colors.white54;
        break;
      case 'expired':
      default:
        badgeBgColor = const Color(0xFF2D1214);
        badgeTextColor = const Color(0xFFE74C3C);
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1B232A),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0x0DFFFFFF), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Title & Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextFontStyle.textStyle16InterW600.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: badgeBgColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Text(
                  status,
                  style: TextFontStyle.textStyle12UrbanistW600.copyWith(
                    color: badgeTextColor,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),

          // Row 2: Subtitle
          Text(
            subtitle,
            style: TextFontStyle.textStyle14InterW400.copyWith(
              color: Colors.white38,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 16.h),

          // Row 3: Promo Code Box and Copy Button
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF132F3F),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: const Color(0x4D2196F3),
                    width: 1.w,
                  ),
                ),
                child: Text(
                  code,
                  style: TextFontStyle.textStyle14InterW500.copyWith(
                    color: AppColor.c2196F3,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: () => _copyToClipboard(context),
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: const BoxDecoration(
                    color: Color(0xFF222E3A),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.content_copy,
                    color: Colors.white54,
                    size: 16.sp,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Container(height: 1.h, color: const Color(0x0DFFFFFF)),
          ),

          // Row 4: Stats Grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem("Discount", discount),
              _buildStatItem("Used", used),
              _buildStatItem("Expires", expires),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextFontStyle.textStyle14InterW400.copyWith(
            color: Colors.white38,
            fontSize: 11.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextFontStyle.textStyle16InterW600.copyWith(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
