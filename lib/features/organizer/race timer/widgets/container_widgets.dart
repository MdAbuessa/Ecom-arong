import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerWidgets extends StatelessWidget {
  final String title;
  final VoidCallback? onCall;
  const ContainerWidgets({super.key, required this.title, this.onCall});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCall,
      child: Container(
        width: 100.w,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration( 
          color: AppColor.c454F5B,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              title,
              style: TextFontStyle.textStyle16InterW600.copyWith(
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
