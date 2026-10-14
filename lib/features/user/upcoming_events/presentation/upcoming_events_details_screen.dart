import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/features/user/access_code/presentation/access_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UpcomingEventsDetailsScreen extends StatefulWidget {
  const UpcomingEventsDetailsScreen({super.key});

  @override
  State<UpcomingEventsDetailsScreen> createState() =>
      _UpcomingEventsDetailsScreenState();
}

class _UpcomingEventsDetailsScreenState
    extends State<UpcomingEventsDetailsScreen> {
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
          child: const CustomBackButton(),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light, // White icons
          statusBarBrightness: Brightness.dark, // For iOS
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
                Stack(
                  children: [
                    Container(
                      height: 400.h,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://images.unsplash.com/photo-1551632811-561732d1e306', // Placeholder image similar to the design
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Gradient overlay at the top for better back button visibility
                    Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.4),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
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
                                fontSize: 20.sp,
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
                        "Start Date: 15 Apr 2026 at 08:00AM",
                      ),
                      SizedBox(height: 12.h),
                      _buildDetailRow(
                        Icons.calendar_today_outlined,
                        "End Date: 15 Mar 2026 at 08:00AM",
                      ),
                      SizedBox(height: 12.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _buildIconDetail(
                                'assets/images/shoe.png',
                                "100 KM",
                              ),
                              SizedBox(width: 20.w),
                              _buildIconDetail(
                                'assets/images/location.png',
                                "Marseille, France",
                              ),
                            ],
                          ),
                          Text(
                            "\$500",
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
                                // Icon(
                                //   Icons.timer_outlined,
                                //   color: const Color(0xFF2196F3),
                                //   size: 18.sp,
                                // ),
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

                      /// ORGANIZER
                      _buildSectionTitle("Organizer"),
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24.r,
                              backgroundImage: const NetworkImage(
                                'https://i.pravatar.cc/150?u=organizer',
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Leslie Alexander",
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "France",
                                  style: GoogleFonts.inter(
                                    color: Colors.white70,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      /// DESCRIPTION
                      _buildSectionTitle("Description"),
                      SizedBox(height: 12.h),
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          "Join the Spring 100K Challenge and stay active this season. Complete 100 kilometers by running, walking, or cycling while tracking your progress and reaching your fitness goal.",
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14.sp,
                            height: 1.5,
                          ),
                        ),
                      ),

                      SizedBox(height: 24.h),

                      /// AVAILABLE OFFERS
                      _buildSectionTitle("Available offers"),
                      SizedBox(height: 12.h),
                      _buildOfferCard(
                        title: "Summer Special Discount",
                        expiry: "Jan 14,2026",
                        promoCode: "SUMMER20",
                      ),
                      _buildOfferCard(
                        title: "Special Discount",
                        expiry: "Jan 15,2026",
                        promoCode: "SPECIAL20",
                      ),

                      SizedBox(height: 24.h),

                      /// LOCATION & DIRECTION
                      _buildSectionTitle("Location & Direction"),
                      SizedBox(height: 12.h),
                      Image.asset(
                        'assets/images/map.png', // Placeholder map image
                        height: 240.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      SizedBox(height: 120.h), // Space for the floating button
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// REGISTER BUTTON
          Positioned(
            bottom: 50.h,
            left: 20.w,
            right: 20.w,
            child: ElevatedButton(
              onPressed: () {
                Get.to(
                  () => const AccessCodeScreen(),
                  opaque: false,
                  transition: Transition.fadeIn,
                );
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
        Icon(icon, color: Colors.white70, size: 18.sp),
        SizedBox(width: 8.w),
        Text(
          text,
          style: GoogleFonts.inter(color: Colors.white70, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildIconDetail(String icon, String text) {
    return Row(
      children: [
        // Icon(icon, color: Colors.white70, size: 18.sp),
        Image.asset(icon, fit: BoxFit.cover, width: 18.w, height: 18.w),
        SizedBox(width: 6.w),
        Text(
          text,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildOfferCard({
    required String title,
    required String expiry,
    required String promoCode,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      height: 100.h,
      decoration: BoxDecoration(
        color: const Color(0xFF13202E),
        borderRadius: BorderRadius.circular(24.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Circle overlay on the right
          Positioned(
            right: -30.w,
            top: -20.h,
            bottom: -20.h,
            width: 140.w,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF1E2E3D),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Text(
                            "Expire $expiry",
                            style: GoogleFonts.inter(
                              color: Colors.white70,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(text: promoCode));
                              Get.snackbar(
                                "Success",
                                "Promo code copied to clipboard!",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: const Color(
                                  0xFF2196F3,
                                ).withOpacity(0.9),
                                colorText: Colors.white,
                                margin: EdgeInsets.all(16.w),
                                duration: const Duration(seconds: 2),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2196F3),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Text(
                                "Copy",
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // "20% OFF" pill on the right, centered vertically
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Text(
                    "20% OFF",
                    style: GoogleFonts.inter(
                      color: const Color(0xFF2196F3),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
