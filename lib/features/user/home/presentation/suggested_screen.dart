import 'dart:ui';
import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SuggestedScreen extends StatefulWidget {
  const SuggestedScreen({super.key});

  @override
  State<SuggestedScreen> createState() => _SuggestedScreenState();
}

class _SuggestedScreenState extends State<SuggestedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 70.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: CustomBackButton(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w, top: 10.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    "Recommend\nfor You",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: const Color(0xFF030C12),
      body: Stack(
        children: [
          /// MAIN CONTENT
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER IMAGE
                Container(
                  height: 400.h,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/suggested_for_you_img.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),

                      /// TITLE & POINTS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Spring 100K Challenge",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/coin.png',
                                height: 20.w,
                                width: 20.w,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                "Earn 50pts",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      SizedBox(height: 16.h),

                      /// EVENT DETAILS
                      _buildDetailRow(
                        Icons.calendar_today_outlined,
                        "Start Date: 15 Apr 2026 at 19:00PM",
                      ),
                      SizedBox(height: 16.h),

                      /// EVENT DETAILS
                      _buildDetailRow(
                        Icons.calendar_today_outlined,
                        "End Date: 25 Apr 2026 at 19:00PM",
                      ),
                      SizedBox(height: 16.h),

                      Row(
                        children: [
                          _buildIconDetail('assets/images/shoe.png', "100 KM"),
                          SizedBox(width: 20.w),
                          _buildIconDetail(
                            'assets/images/location.png',
                            "Marseille, France",
                          ),
                          const Spacer(),
                          Text(
                            "Free entry",
                            style: GoogleFonts.inter(
                              color: const Color(0xFF2196F3),
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      /// JOINED & TIMER
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 110.w,
                                height: 36.h,
                                child: Stack(
                                  children: [
                                    ...List.generate(3, (index) {
                                      return Positioned(
                                        left: index * 22.w,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: CircleAvatar(
                                            radius: 16.r,
                                            backgroundImage: NetworkImage(
                                              'https://i.pravatar.cc/150?u=user$index',
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                    Positioned(
                                      left: 3 * 22.w,
                                      child: Container(
                                        height: 34.h,
                                        width: 34.h,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1.5,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "+12",
                                          style: GoogleFonts.inter(
                                            color: const Color(0xFF4B5563),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Joined",
                                style: GoogleFonts.inter(
                                  color: Colors.white70,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF2196F3).withOpacity(0.5),
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  "assets/images/time_icon.png",
                                  width: 18.w,
                                  height: 18.w,
                                ),
                                SizedBox(width: 6.w),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "01 ",
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Day ",
                                        style: GoogleFonts.inter(
                                          color: Colors.white70,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "04 ",
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Hours",
                                        style: GoogleFonts.inter(
                                          color: Colors.white70,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32.h),

                      /// WHY THIS IS SUGGESTED
                      _buildSectionContainer(
                        "Why This is Suggested",
                        Column(
                          children: [
                            _buildCheckItem("Matches your running level"),
                            SizedBox(height: 12.h),
                            _buildCheckItem("Based on your recent 5K activity"),
                            SizedBox(height: 12.h),
                            _buildCheckItem("Popular in your area"),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      /// REWARDS
                      _buildSectionContainer(
                        "Rewards",
                        Text(
                          "Earn a special badge and a digital certificate!",
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      /// LOCATION & DIRECTION
                      _buildSectionTitle("Location & Direction"),
                      SizedBox(height: 12.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24.r),
                        child: Image.asset(
                          'assets/images/map.png',
                          height: 240.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      SizedBox(height: 120.h),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// REGISTER BUTTON
          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: ElevatedButton(
              onPressed: () {
                // Get.to(
                //   () => const AccessCodeScreen(),
                //   opaque: false,
                //   transition: Transition.fadeIn,
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2196F3),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "Register",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20.sp),
        SizedBox(width: 8.w),
        Text(
          text,
          style: GoogleFonts.inter(color: Colors.white70, fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildIconDetail(String icon, String text) {
    return Row(
      children: [
        Image.asset(icon, fit: BoxFit.cover, width: 20.w, height: 20.w),
        SizedBox(width: 8.w),
        Text(
          text,
          style: GoogleFonts.inter(
            color: Colors.white70,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildSectionContainer(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: content,
        ),
      ],
    );
  }

  Widget _buildCheckItem(String text) {
    return Row(
      children: [
        Icon(
          Icons.check_circle_outline,
          color: const Color(0xFF2196F3),
          size: 20.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
    );
  }
}
