import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileListItem extends StatelessWidget {
  final String title;
  final bool isSwitch;
  final String icon;
  final Color? iconColor;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback? onTap;

  const ProfileListItem({
    super.key,
    required this.title,
    this.isSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    required this.icon,
    this.iconColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF0B1A20),
          borderRadius: BorderRadius.circular(12.h),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.r),
                child: SvgPicture.asset(
                  icon,
                  color: iconColor ?? AppColor.c2563EB,
                  height: 20.h,
                  width: 20.w,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextFontStyle.textStyle16InterW600.copyWith(
                  fontSize: 15.sp,
                ),
              ),
            ),
            if (isSwitch)
              SizedBox(
                height: 24,
                child: Switch(
                  value: switchValue,
                  onChanged: onSwitchChanged ?? (val) {},
                  activeColor: Colors.white,
                  activeTrackColor: Colors.blue,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.withOpacity(0.5),
                ),
              )
            else
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white54,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
