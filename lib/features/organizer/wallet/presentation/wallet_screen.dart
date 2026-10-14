import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/organizer/wallet/widgets/transaction_card.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        onBackTap: () {
          NavigationService.goBack;
        },
        title: "Wallet",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Available Balance Card
            GestureDetector(
              onTap: () {
                NavigationService.navigateTo(Routes.withdrawAmountScreen);
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2196F3), Color(0xFF0A74DA)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 50,
                        ), // Balance the USD dropdown on the right
                        Expanded(
                          child: Center(
                            child: Text(
                              "Available Balance",
                              style: TextFontStyle.textStyle14InterW500
                                  .copyWith(
                                    color: const Color(0xCCFFFFFF),
                                    fontSize: 12.sp,
                                  ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0x26FFFFFF),
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "USD",
                                style: TextFontStyle.textStyle12UrbanistW600
                                    .copyWith(
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
                    SizedBox(height: 20.h),
                    Container(
                      width: double.infinity,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Center(
                        child: Text(
                          "Withdraw",
                          style: TextFontStyle.textStyle16InterW600.copyWith(
                            color: const Color(0xFF2196F3),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Recent Transactions Section Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Transactions",
                  style: TextFontStyle.textStyle16InterW600.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    NavigationService.navigateTo(Routes.allTransactionsScreen);
                  },
                  child: Text(
                    "See all",
                    style: TextFontStyle.textStyle14InterW400.copyWith(
                      color: Colors.white70,
                      fontSize: 13.sp,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Recent Transactions List
            TransactionCard(
              amount: "\$1,000.00",
              method: "Bank Transfer",
              dateTime: "Apr 10, 2025 at 02:15 PM",
              status: "Completed",
            ),
            TransactionCard(
              amount: "\$1,000.00",
              method: "Stripe",
              dateTime: "Apr 10, 2025 at 02:15 PM",
              status: "Pending",
            ),
            TransactionCard(
              amount: "\$1,000.00",
              method: "Bank Transfer",
              dateTime: "Apr 10, 2025 at 02:15 PM",
              status: "Rejected",
            ),
          ],
        ),
      ),
    );
  }
}
