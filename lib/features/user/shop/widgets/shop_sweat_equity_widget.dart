import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopSweatEquityWidget extends StatelessWidget {
  const ShopSweatEquityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "YOUR RACE REALM SWEAT EQUITY",
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPointText("5000"),
              _buildPointText("10000"),
              _buildPointText("15000"),
              _buildPointText("20000+"),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(child: _buildRankBadge("BRONZE", true)),
              SizedBox(width: 4.w),
              Expanded(child: _buildRankBadge("SILVER", false)),
              SizedBox(width: 4.w),
              Expanded(child: _buildRankBadge("GOLD", false)),
              SizedBox(width: 4.w),
              Expanded(child: _buildRankBadge("PLATINUM", false)),
            ],
          ),
          SizedBox(height: 16.h),
          RichText(
            text: TextSpan(
              text: "EARNED POINTS BALANCE: ",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
              children: [
                TextSpan(
                  text: "3500 pts",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2196F3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointText(String text) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildRankBadge(String rank, bool isActive) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF2196F3) : const Color(0xFF4A5568),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        rank,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
