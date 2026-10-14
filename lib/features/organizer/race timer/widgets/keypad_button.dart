import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeypadButton extends StatelessWidget {
  final String number;
  final String letters;
  final VoidCallback? onTap;

  const KeypadButton({
    super.key,
    required this.number,
    required this.letters,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap ?? () {},
        child: Container(
          margin: EdgeInsets.all(4.w),
          padding: EdgeInsets.symmetric(vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColor.cFFFFFF,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (letters.isNotEmpty)
                Text(
                  letters,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                )
              else
                SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
