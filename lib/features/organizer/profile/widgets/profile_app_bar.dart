import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? icons;
  final String? icons1;
  final VoidCallback? onBackTap;
  final VoidCallback? onTap;
  final VoidCallback? onTap1;

  const ProfileAppBar({
    super.key,
    this.title,
    this.onBackTap,
    this.onTap,
    this.icons,
    this.icons1,
    this.onTap1,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 90.w,
      leading: onBackTap == null
          ? SizedBox.shrink()
          : Padding(
              padding: EdgeInsets.only(left: 5.w, top: 5.h, bottom: 5.h),
              child: GestureDetector(
                onTap: onBackTap,
                child: Center(
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: AppColor.c2196F3,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon( 
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
      centerTitle: true,
      title: title == null
          ? SizedBox.shrink()
          : Text(
              title!,
              style: TextFontStyle.textStyle24RobotoW600.copyWith(
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),

      actions: [
        icons == null
            ? SizedBox.shrink()
            : GestureDetector(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: SvgPicture.asset(icons!, height: 24.h, width: 24.w),
                ),
              ),

        icons1 == null
            ? SizedBox.shrink()
            : GestureDetector(
                onTap: onTap1,
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: SvgPicture.asset(
                    icons1!,
                    height: 24.h,
                    width: 24.w,
                    color: AppColor.cFFFFFF,
                  ),
                ),
              ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
