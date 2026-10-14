import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/organizer/wallet/widgets/withdraw_request.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ReviewWithdrawalScreen extends StatelessWidget {
  final WithdrawRequest request;

  const ReviewWithdrawalScreen({super.key, required this.request});

  void _handleConfirmTap() {
    NavigationService.navigateTo(Routes.withdrawSuccessScreen, arguments: request);
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        title,
        style: TextFontStyle.textStyle14InterW500.copyWith(
          color: Colors.white54,
          fontSize: 12.sp,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String val, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextFontStyle.textStyle14InterW400.copyWith(
            color: isHighlight ? Colors.white : Colors.white54,
            fontSize: 13.sp,
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
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
    final String displayAmt = "\$${NumberFormat("#,##0.00").format(request.amount)}";

    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        onBackTap: () {
          NavigationService.goBack;
        },
        title: "Review Withdrawal",
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Withdrawal Details section
                    _buildSectionHeader("Withdrawal Details"),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B232A),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: const Color(0x0DFFFFFF)),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow("Amount", displayAmt),
                          SizedBox(height: 12.h),
                          _buildDetailRow("Processing Fee :", "\$0.00"),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Container(
                              height: 1.h,
                              color: const Color(0x0DFFFFFF),
                            ),
                          ),
                          _buildDetailRow("You Will Receive", displayAmt, isHighlight: true),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Payment Method section
                    _buildSectionHeader("Payment Method"),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B232A),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: const Color(0x0DFFFFFF)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: const BoxDecoration(
                              color: Color(0xFF0E1E26),
                              shape: BoxShape.circle,
                            ),
                            child: request.method == "Bank Transfer"
                                ? Icon(
                                    Icons.account_balance_outlined,
                                    color: AppColor.c2196F3,
                                    size: 20.sp,
                                  )
                                : SizedBox(
                                    width: 20.sp,
                                    height: 20.sp,
                                    child: Center(
                                      child: Text(
                                        "S",
                                        style: TextFontStyle.textStyle16InterW600.copyWith(
                                          color: AppColor.c2196F3,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            request.method,
                            style: TextFontStyle.textStyle16InterW600.copyWith(
                              color: Colors.white,
                              fontSize: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Bank/Stripe Details section
                    _buildSectionHeader(request.method == "Bank Transfer" ? "Bank Details" : "Stripe Details"),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B232A),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: const Color(0x0DFFFFFF)),
                      ),
                      child: request.method == "Bank Transfer"
                          ? Column(
                              children: [
                                _buildDetailRow("Account Holder Name", request.holderName ?? ""),
                                SizedBox(height: 12.h),
                                _buildDetailRow("Bank Name", request.bankName ?? ""),
                                SizedBox(height: 12.h),
                                _buildDetailRow("Account Number", request.accountNumber ?? ""),
                                SizedBox(height: 12.h),
                                _buildDetailRow("Routing Number", request.routingNumber ?? ""),
                                if (request.swift != null && request.swift!.isNotEmpty) ...[
                                  SizedBox(height: 12.h),
                                  _buildDetailRow("SWIFT/ IFWSC", request.swift!),
                                ],
                              ],
                            )
                          : Column(
                              children: [
                                _buildDetailRow("Stripe Email", request.stripeEmail ?? ""),
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
                              "Please review the details carefully. You cannot change these details later.",
                              style: TextFontStyle.textStyle14InterW400.copyWith(
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
                  onPressed: _handleConfirmTap,
                  child: Text(
                    "Confirm Withdrawal",
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
