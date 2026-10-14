import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        Text(
          'Create Your Account',
          style: TextStyle(
            color: const Color(0xFF23A4FF),
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          'Ready to run, challenge yourself,\nreach new milestones',
          style: TextStyle(color: Colors.white70, fontSize: 14.sp, height: 1.5),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
