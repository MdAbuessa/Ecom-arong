// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget settingTrailingText(String value) {
  return Text(
    value,
    style: GoogleFonts.inter(
      color: Colors.white.withOpacity(0.55),
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
    ),
  );
}

Widget settingOrangeDot() {
  return Container(
    width: 8.r,
    height: 8.r,
    decoration: const BoxDecoration(
      color: Color(0xFFFF8C00),
      shape: BoxShape.circle,
    ),
  );
}
