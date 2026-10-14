import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/organizer/wallet/widgets/withdraw_request.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectMethodScreen extends StatefulWidget {
  final WithdrawRequest request;

  const SelectMethodScreen({super.key, required this.request});

  @override
  State<SelectMethodScreen> createState() => _SelectMethodScreenState();
}

class _SelectMethodScreenState extends State<SelectMethodScreen> {
  late String _selectedMethod;

  @override
  void initState() {
    super.initState();
    _selectedMethod = widget.request.method;
  }

  void _handleNextTap() {
    final updatedRequest = widget.request.copyWith(method: _selectedMethod);
    if (_selectedMethod == "Bank Transfer") {
      NavigationService.navigateTo(Routes.bankAccountDetailsScreen, arguments: updatedRequest);
    } else {
      NavigationService.navigateTo(Routes.stripeDetailsScreen, arguments: updatedRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isBank = _selectedMethod == "Bank Transfer";
    final bool isStripe = _selectedMethod == "Stripe";

    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        onBackTap: () {
          NavigationService.goBack;
        },
        title: "Select Method",
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  children: [
                    // Bank Transfer option
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedMethod = "Bank Transfer";
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B232A),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: isBank ? AppColor.c2196F3 : const Color(0x0DFFFFFF),
                            width: isBank ? 1.5.w : 1.w,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: const BoxDecoration(
                                color: Color(0xFF0E1E26),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.account_balance_outlined,
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
                                    "Bank Transfer",
                                    style: TextFontStyle.textStyle16InterW600.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Transfer to your bank account",
                                    style: TextFontStyle.textStyle14InterW400.copyWith(
                                      color: Colors.white38,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              isBank ? Icons.radio_button_checked : Icons.radio_button_off,
                              color: isBank ? AppColor.c2196F3 : Colors.white24,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Stripe option
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedMethod = "Stripe";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B232A),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            color: isStripe ? AppColor.c2196F3 : const Color(0x0DFFFFFF),
                            width: isStripe ? 1.5.w : 1.w,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: const BoxDecoration(
                                color: Color(0xFF0E1E26),
                                shape: BoxShape.circle,
                              ),
                              child: SizedBox(
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Stripe",
                                    style: TextFontStyle.textStyle16InterW600.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "Transfer to your stripe account",
                                    style: TextFontStyle.textStyle14InterW400.copyWith(
                                      color: Colors.white38,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              isStripe ? Icons.radio_button_checked : Icons.radio_button_off,
                              color: isStripe ? AppColor.c2196F3 : Colors.white24,
                              size: 20.sp,
                            ),
                          ],
                        ),
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
