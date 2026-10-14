import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailPreviewScreen extends StatefulWidget {
  const EmailPreviewScreen({super.key});

  @override
  State<EmailPreviewScreen> createState() => _EmailPreviewScreenState();
}

class _EmailPreviewScreenState extends State<EmailPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        onBackTap: () {
          NavigationService.goBack;
        },
        title: "Email Preview",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // To Card
            Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1B232A),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0x0DFFFFFF), width: 1.w),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6.h),
                    padding: EdgeInsets.all(12.w),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0E1E26),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.people_outline,
                      color: AppColor.c2196F3,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "To",
                          style: TextFontStyle.textStyle14InterW400.copyWith(
                            color: Colors.white38,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "SK City Run Participants",
                          style: TextFontStyle.textStyle16InterW600.copyWith(
                            color: Colors.white,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "245 Recipients",
                          style: TextFontStyle.textStyle14InterW400.copyWith(
                            color: Colors.white38,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Subject Card
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1B232A),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0x0DFFFFFF), width: 1.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Subject",
                    style: TextFontStyle.textStyle14InterW400.copyWith(
                      color: Colors.white38,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Race Day Instructions",
                    style: TextFontStyle.textStyle16InterW600.copyWith(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),

            // Message Preview Card
            Container(
              margin: EdgeInsets.only(bottom: 16.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1B232A),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0x0DFFFFFF), width: 1.w),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      color: const Color(0xFF1B232A),
                      child: Text(
                        "Message Preview",
                        style: TextFontStyle.textStyle16InterW600.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    Container(height: 1.h, color: const Color(0x0DFFFFFF)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 20.h,
                      ),
                      color: const Color(0xFF141C22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello Participants,",
                            style: TextFontStyle.textStyle14InterW400.copyWith(
                              color: Colors.white70,
                              fontSize: 13.sp,
                              height: 1.5.h,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "We are excited to see you at SK City Run. Please arrive at least\n30 minutes before the race starts.",
                            style: TextFontStyle.textStyle14InterW400.copyWith(
                              color: Colors.white70,
                              fontSize: 13.sp,
                              height: 1.5.h,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "See you there!",
                            style: TextFontStyle.textStyle14InterW400.copyWith(
                              color: Colors.white70,
                              fontSize: 13.sp,
                              height: 1.5.h,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            "Thank you.",
                            style: TextFontStyle.textStyle14InterW400.copyWith(
                              color: Colors.white70,
                              fontSize: 13.sp,
                              height: 1.5.h,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
