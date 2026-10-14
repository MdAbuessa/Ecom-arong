import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoCodeDateSelector extends StatelessWidget {
  final String dateString;
  final bool isSelected;
  final VoidCallback onTap;

  const PromoCodeDateSelector({
    super.key,
    required this.dateString,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: const Color(0xFF111A20),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF1C2A35), width: 1.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dateString,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white24,
                fontSize: 14.sp,
              ),
            ),
            Icon(
              Icons.access_time_outlined,
              color: const Color(0xFF8E9AA5),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
