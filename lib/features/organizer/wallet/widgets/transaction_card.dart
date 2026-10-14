import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionCard extends StatelessWidget {
  final String amount;
  final String method;
  final String dateTime;
  final String status;

  const TransactionCard({
    super.key,
    required this.amount,
    required this.method,
    required this.dateTime,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color badgeBgColor;
    Color badgeTextColor;

    switch (status.toLowerCase()) {
      case 'completed':
        badgeBgColor = const Color(0xFF10281F);
        badgeTextColor = const Color(0xFF22C55E);
        break;
      case 'pending':
        badgeBgColor = const Color(0xFF2B2109);
        badgeTextColor = const Color(0xFFF1C40F);
        break;
      case 'rejected':
      default:
        badgeBgColor = const Color(0xFF2D1214);
        badgeTextColor = const Color(0xFFE74C3C);
        break;
    }

    final bool isStripe = method.toLowerCase() == 'stripe';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1B232A),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0x0DFFFFFF), width: 1.w),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: const BoxDecoration(
              color: Color(0xFF0E1E26),
              shape: BoxShape.circle,
            ),
            child: isStripe
                ? SizedBox(
                    width: 20.sp,
                    height: 20.sp,
                    child: Center(
                      child: Text(
                        "S",
                        style: TextFontStyle.textStyle16InterW600.copyWith(
                          color: AppColor.c2196F3,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  )
                : Icon(
                    Icons.account_balance_outlined,
                    color: AppColor.c2196F3,
                    size: 20.sp,
                  ),
          ),
          SizedBox(width: 16.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      amount,
                      style: TextFontStyle.textStyle16InterW600.copyWith(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                    // Status Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
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
                SizedBox(height: 6.h),
                Text(
                  method,
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    color: Colors.white54,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  dateTime,
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    color: Colors.white38,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
