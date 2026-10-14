import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_save_button.dart';
import 'package:aarongonzales01/features/organizer/promocodes/widgets/promo_code_model.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoCodeCreatedScreen extends StatelessWidget {
  final PromoCode promoCode;

  const PromoCodeCreatedScreen({super.key, required this.promoCode});

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: promoCode.promoCode));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF142C3E),
        content: Text(
          "Promo code '${promoCode.promoCode}' copied to clipboard!",
          style: TextFontStyle.textStyle14InterW500.copyWith(
            color: AppColor.c2196F3,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the first event name as subtitle/event title
    final eventSubtitle = promoCode.selectedEvents.isNotEmpty
        ? promoCode.selectedEvents.first
        : "Summer Music Festival";

    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Custom Back Button & Screen Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: AppColor.c2196F3,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: 10.h),

              // Spark circle check illustration
              SizedBox(
                height: 160.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer floating dots/particles
                    Positioned(
                      top: 15.h,
                      left: 80.w,
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2196F3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40.h,
                      right: 90.w,
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF5CA8E6),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40.h,
                      left: 100.w,
                      child: Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2196F3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 25.h,
                      right: 120.w,
                      child: Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: const BoxDecoration(
                          color: Color(0x802196F3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 60.h,
                      left: 95.w,
                      child: Container(
                        width: 5.w,
                        height: 5.w,
                        decoration: const BoxDecoration(
                          color: Color(0x662196F3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 70.h,
                      right: 70.w,
                      child: Container(
                        width: 14.w,
                        height: 14.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2196F3),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    // Central Checkmark Badge
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: const BoxDecoration(
                        color: AppColor.c2196F3,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x402196F3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.check, color: Colors.white, size: 40),
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Promo Code Created!",
                style: TextFontStyle.textStyle24RobotoW600.copyWith(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Your promo code has been successfully\ngenerated and is ready to use.",
                textAlign: TextAlign.center,
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: const Color(0xFF8E9AA5),
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),

              // The Ticket/Card container
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1B232A),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: const Color(0x0DFFFFFF),
                    width: 1.w,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subtitle & Status Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            eventSubtitle,
                            style: TextFontStyle.textStyle14InterW400.copyWith(
                              color: const Color(0xFF8E9AA5),
                              fontSize: 13.sp,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10281F),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Text(
                            "Active",
                            style: TextFontStyle.textStyle12UrbanistW600
                                .copyWith(
                                  color: const Color(0xFF22C55E),
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),

                    // Promo Code Title (Name)
                    Text(
                      promoCode.name,
                      style: TextFontStyle.textStyle16InterW600.copyWith(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Copy Box
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF132F3F),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: const Color(0x4D2196F3),
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            promoCode.promoCode,
                            style: TextFontStyle.textStyle14InterW500.copyWith(
                              color: AppColor.c2196F3,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              letterSpacing: 0.5,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _copyToClipboard(context),
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: const BoxDecoration(
                                color: Color(0xFF222E3A),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.content_copy,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Detail boxes grid
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildDetailBox(
                                icon: Icons.local_offer_outlined,
                                iconColor: const Color(0xFF2196F3),
                                label: "Discount",
                                value: promoCode.discountString,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _buildDetailBox(
                                icon: Icons.group_outlined,
                                iconColor: const Color(0xFFA855F7),
                                label: "Usage",
                                value: "${promoCode.usageLimit}",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDetailBox(
                                icon: Icons.calendar_today_outlined,
                                iconColor: const Color(0xFFEAB308),
                                label: "Expires",
                                value: promoCode.expiryString,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _buildDetailBox(
                                icon: Icons.shield_outlined,
                                iconColor: const Color(0xFF22C55E),
                                label: "Applied To",
                                value: promoCode.appliedToSummary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              CustomSaveButton(
                btnText: 'Go to Promo Codes',
                onCall: () {
                  Navigator.of(context).popUntil(
                    (route) =>
                        route.isFirst ||
                        route.settings.name == Routes.promoCodesScreen,
                  );
                },
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailBox({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF111A20),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
              color: Color(0xFF1C2A35),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 18.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            label,
            style: TextFontStyle.textStyle14InterW400.copyWith(
              color: const Color(0xFF8E9AA5),
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextFontStyle.textStyle16InterW600.copyWith(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
