import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/organizer/wallet/widgets/withdraw_request.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class WithdrawSuccessScreen extends StatelessWidget {
  final WithdrawRequest request;

  const WithdrawSuccessScreen({super.key, required this.request});

  Widget _buildDetailRow(String label, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextFontStyle.textStyle14InterW400.copyWith(
            color: Colors.white54,
            fontSize: 13.sp,
          ),
        ),
        Text(
          val,
          style: TextFontStyle.textStyle16InterW600.copyWith(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String displayAmt =
        "\$${NumberFormat("#,##0.00").format(request.amount)}";
    final String currentDate = DateFormat(
      "MMM dd, yyyy",
    ).format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        onBackTap: () {
          Navigator.popUntil(context, ModalRoute.withName(Routes.walletScreen));
        },
        title: "",
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    // Success Spark Icon Stack
                    Center(
                      child: SizedBox(
                        width: 160.w,
                        height: 160.w,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Inner blue circle with checkmark
                            Container(
                              width: 80.w,
                              height: 80.w,
                              decoration: const BoxDecoration(
                                color: AppColor.c2196F3,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 40.sp,
                              ),
                            ),
                            // Blue dots representing sparks around checkmark circle
                            Positioned(
                              top: 15.h,
                              left: 65.w,
                              child: Container(
                                width: 8.w,
                                height: 8.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0EA5E9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 30.h,
                              left: 30.w,
                              child: Container(
                                width: 14.w,
                                height: 14.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0EA5E9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40.h,
                              right: 32.w,
                              child: Container(
                                width: 12.w,
                                height: 12.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0EA5E9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 25.h,
                              right: 40.w,
                              child: Container(
                                width: 16.w,
                                height: 16.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0EA5E9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 30.h,
                              left: 42.w,
                              child: Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0EA5E9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 55.h,
                              left: 28.w,
                              child: Container(
                                width: 6.w,
                                height: 6.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0EA5E9),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Requested Text
                    Text(
                      "Requested!",
                      style: TextFontStyle.textStyle24RobotoW600.copyWith(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Subtitle
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        "Your withdrawal request has been submitted successfully.",
                        textAlign: TextAlign.center,
                        style: TextFontStyle.textStyle14InterW400.copyWith(
                          color: Colors.white38,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Success Details Card
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 20.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B232A),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: const Color(0x0DFFFFFF)),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow("Amount", displayAmt),
                          SizedBox(height: 12.h),
                          _buildDetailRow("Method", request.method),
                          SizedBox(height: 12.h),
                          _buildDetailRow("Date", currentDate),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Status",
                                style: TextFontStyle.textStyle14InterW400
                                    .copyWith(
                                      color: Colors.white54,
                                      fontSize: 13.sp,
                                    ),
                              ),
                              Text(
                                "Pending Approval",
                                style: TextFontStyle.textStyle16InterW600
                                    .copyWith(
                                      color: const Color(0xFFE2B013),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Info box
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141C22),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: const Color(0x0DFFFFFF)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: AppColor.c2196F3,
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              "You will receive a notification once your withdrawal is approved.",
                              style: TextFontStyle.textStyle14InterW400
                                  .copyWith(
                                    color: Colors.white70,
                                    fontSize: 13.sp,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Persistent Button at bottom
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Container(
                width: double.infinity,
                height: 52.h,
                decoration: BoxDecoration(
                  color: AppColor.c2196F3,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName(Routes.walletScreen),
                    );
                  },
                  child: Text(
                    "Back to Wallet",
                    style: TextFontStyle.textStyle16InterW600.copyWith(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
