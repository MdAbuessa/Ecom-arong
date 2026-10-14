import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductInfoWidget extends StatelessWidget {
  const ProductInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildBadge("Top Rated"),
            SizedBox(width: 8.w),
            _buildBadge("Free Shipping"),
            const Spacer(),
            Icon(
              Icons.monetization_on,
              color: Colors.orangeAccent,
              size: 16.sp,
            ),
            SizedBox(width: 4.w),
            Text(
              "Points",
              style: TextStyle(color: Colors.white70, fontSize: 12.sp),
            ),
            SizedBox(width: 4.w),
            Text(
              "130",
              style: TextStyle(
                color: const Color(0xFF2196F3),
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "Event Runner T-Shirt",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$ 15.25",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "\$ 20.00",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12.sp,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.white54,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            ...List.generate(
              5,
              (index) => Icon(
                index < 4 ? Icons.star : Icons.star_half,
                color: Colors.amber,
                size: 14.sp,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              "4.5 (2,495 reviews)",
              style: TextStyle(color: Colors.white70, fontSize: 12.sp),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Text(
          "Designed for those who never stop moving, Event Runner is more than just a run—it's a journey of progress, achievement, and purpose. Every step you take brings you closer to new milestones, rewards, and personal victories. Run with confidence, finish with pride.",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 13.sp,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
