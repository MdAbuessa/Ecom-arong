import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoCodeSpinnerInput extends StatelessWidget {
  final TextEditingController controller;
  final String? prefixText;

  const PromoCodeSpinnerInput({
    super.key,
    required this.controller,
    this.prefixText,
  });

  void _increment() {
    int val = int.tryParse(controller.text) ?? 0;
    controller.text = (val + 1).toString();
  }

  void _decrement() {
    int val = int.tryParse(controller.text) ?? 0;
    if (val > 0) {
      controller.text = (val - 1).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111A20),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF1C2A35), width: 1.w),
      ),
      child: Row(
        children: [
          if (prefixText != null) ...[
            Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Text(
                prefixText!,
                style: TextStyle(
                  color: const Color(0xFF8E9AA5),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              width: 1.w,
              height: 24.h,
              color: const Color(0xFF1C2A35),
            ),
          ],
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              cursorColor: AppColor.c2196F3,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: prefixText != null ? 0 : 16.w,
                  vertical: 16.h,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _increment,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w, bottom: 2.h, top: 4.h),
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: const Color(0xFF8E9AA5),
                    size: 20.sp,
                  ),
                ),
              ),
              GestureDetector(
                onTap: _decrement,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w, top: 2.h, bottom: 4.h),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: const Color(0xFF8E9AA5),
                    size: 20.sp,
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
