import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/organizer/wallet/widgets/withdraw_request.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WithdrawAmountScreen extends StatefulWidget {
  const WithdrawAmountScreen({super.key});

  @override
  State<WithdrawAmountScreen> createState() => _WithdrawAmountScreenState();
}

class _WithdrawAmountScreenState extends State<WithdrawAmountScreen> {
  final TextEditingController _amountController = TextEditingController(text: "1,000.00");

  void _handleNextTap() {
    final cleanAmount = _amountController.text.replaceAll(',', '');
    final amt = double.tryParse(cleanAmount);
    if (amt == null || amt < 50.00) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF2D1214),
          content: Text(
            "Please enter an amount of \$50.00 or more.",
            style: TextFontStyle.textStyle14InterW500.copyWith(color: const Color(0xFFE74C3C)),
          ),
        ),
      );
      return;
    }
    
    // Create the withdraw request and navigate to the Select Method Screen
    final request = WithdrawRequest(amount: amt, method: "Bank Transfer");
    NavigationService.navigateTo(Routes.selectMethodScreen, arguments: request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        onBackTap: () {
          NavigationService.goBack;
        },
        title: "Withdraw Amount",
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
                    // Available Balance Card (No Withdraw Button)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF2196F3),
                            Color(0xFF0A74DA),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 50),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "Available Balance",
                                    style: TextFontStyle.textStyle14InterW500.copyWith(
                                      color: const Color(0xCCFFFFFF),
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: const Color(0x26FFFFFF),
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "USD",
                                      style: TextFontStyle.textStyle12UrbanistW600.copyWith(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Colors.white,
                                      size: 14.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Center(
                            child: Text(
                              "\$4,8500.00",
                              style: TextFontStyle.textStyle24RobotoW600.copyWith(
                                color: Colors.white,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                   			  ),
                			),
              			  ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Amount Label
                    Text(
                      "Amount",
                      style: TextFontStyle.textStyle14InterW500.copyWith(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Amount Input Field
                    TextField(
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      style: TextFontStyle.textStyle14InterW500.copyWith(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Enter amount",
                        hintStyle: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white30),
                        filled: true,
                        fillColor: const Color(0xFF141C22),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: const BorderSide(color: Color(0x0DFFFFFF)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: const BorderSide(color: Color(0x0DFFFFFF)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: const BorderSide(color: AppColor.c2196F3, width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Info box
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF141C22),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: const Color(0x0DFFFFFF),
                          width: 1.w,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: AppColor.c2196F3,
                                size: 20.sp,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  "Minimum withdraw amount is \$50.00",
                                  style: TextFontStyle.textStyle14InterW400.copyWith(
                                    color: Colors.white70,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          Row(
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
                                  "withdraw requestts are useally procced within 1-3 buisenss days.",
                                  style: TextFontStyle.textStyle14InterW400.copyWith(
                                    color: Colors.white70,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
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
                  onPressed: _handleNextTap,
                  child: Text(
                    "Next",
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
