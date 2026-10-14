import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/assets_helper/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LiveResultListItem extends StatelessWidget {
  final String bib;
  final String name;
  final String clock;
  final VoidCallback onEdit;

  const LiveResultListItem({
    super.key,
    required this.bib,
    required this.name,
    required this.clock,
    required this.onEdit,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E293B).withValues(alpha: 0.4),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              bib,
              style: TextFontStyle.textStyle14InterW500.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: TextFontStyle.textStyle14InterW400.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF4CAF50,
                  ).withValues(alpha: 0.2), // Light green bg
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: const Color(0xFF4CAF50)),
                ),
                child: Text(
                  clock,
                  style: TextFontStyle.textStyle16InterW600.copyWith(
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          GestureDetector(
            onTap: onEdit,
            child: SvgPicture.asset(AppIcons.edit, height: 24, width: 24),
          ),
        ],
      ),
    );
  }
}
