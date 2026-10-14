import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/organizer/wallet/widgets/withdraw_request.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StripeDetailsScreen extends StatefulWidget {
  final WithdrawRequest request;

  const StripeDetailsScreen({super.key, required this.request});

  @override
  State<StripeDetailsScreen> createState() => _StripeDetailsScreenState();
}

class _StripeDetailsScreenState extends State<StripeDetailsScreen> {
  final TextEditingController _stripeEmailController = TextEditingController(text: "organizer@stripe.com");

  void _handleNextTap() {
    if (_stripeEmailController.text.trim().isEmpty || !_stripeEmailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF2D1214),
          content: Text(
            "Please enter a valid Stripe email address.",
            style: TextFontStyle.textStyle14InterW500.copyWith(color: const Color(0xFFE74C3C)),
          ),
        ),
      );
      return;
    }

    final updatedRequest = widget.request.copyWith(
      stripeEmail: _stripeEmailController.text.trim(),
    );

    NavigationService.navigateTo(Routes.reviewWithdrawalScreen, arguments: updatedRequest);
  }

  Widget _buildTextFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: TextFontStyle.textStyle14InterW500.copyWith(
          color: Colors.white70,
          fontSize: 13.sp,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        onBackTap: () {
          NavigationService.goBack;
        },
        title: "Stripe Details",
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
                    _buildTextFieldLabel("Stripe Email"),
                    TextField(
                      controller: _stripeEmailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextFontStyle.textStyle14InterW500.copyWith(color: Colors.white),
                      decoration: _inputDecoration("Enter stripe account email"),
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
                    "Review & Submit",
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
