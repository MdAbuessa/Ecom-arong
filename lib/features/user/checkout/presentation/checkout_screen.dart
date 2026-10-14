import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/features/user/checkout/presentation/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _promoController = TextEditingController();
  bool _isPromoApplied = false;

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.c111827,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),

              /// CUSTOM APP BAR
              Row(
                children: [
                  const CustomBackButton(),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Check out",
                        style: GoogleFonts.inter(
                          color: const Color(0xFF2196F3),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 44.w),
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 32.h),

                      /// BILLING INFORMATION
                      _buildSectionTitle("Billing Information"),
                      SizedBox(height: 16.h),
                      _buildBillingItem(
                        icon: Icons.person_outline,
                        label: "Full name",
                        value: "Ayana meherima",
                      ),
                      SizedBox(height: 16.h),
                      _buildBillingItem(
                        icon: Icons.phone_outlined,
                        label: "Phone number",
                        value: "000 888 999",
                      ),
                      SizedBox(height: 16.h),
                      _buildBillingItem(
                        icon: Icons.mail_outline,
                        label: "Email",
                        value: "ayanamera@gmail.com",
                      ),

                      SizedBox(height: 32.h),

                      /// PROMO CODE
                      _buildSectionTitle("Promo Code"),
                      SizedBox(height: 16.h),
                      _buildPromoCodeField(),

                      SizedBox(height: 32.h),

                      /// ORDER SUMMARY
                      _buildSectionTitle("Order Summary"),
                      SizedBox(height: 16.h),
                      _buildOrderSummaryCard(),

                      SizedBox(height: 48.h),

                      /// COMPLETE ORDER BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle complete order
                            Get.to(() => const PaymentScreen());
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
                            "Complete Order",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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

  Widget _buildBillingItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFF2196F3), size: 24.sp),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(color: Colors.white60, fontSize: 14.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showApplyPromoDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: const Color(0xFF15222E),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12.h),
                // Circular outer ring
                Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 60.w,
                    height: 60.w,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/promo_code_popup.png',
                      width: 28.w,
                      height: 28.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  "Are you sure?",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "If you apply this code, you will get a \$100.00 discount on your order.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.08),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            _isPromoApplied = true;
                            if (_promoController.text.trim().isEmpty) {
                              _promoController.text = "AA487B98";
                            }
                          });
                          Get.snackbar(
                            "Success",
                            "Promo code applied successfully!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: const Color(
                              0xFF2196F3,
                            ).withOpacity(0.9),
                            colorText: Colors.white,
                            margin: EdgeInsets.all(16.w),
                            duration: const Duration(seconds: 2),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2196F3),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Yes, Apply Code",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPromoCodeField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        children: [
          SizedBox(width: 16.w),
          Icon(
            Icons.confirmation_number_outlined,
            color: const Color(0xFF2196F3),
            size: 24.sp,
          ),
          Expanded(
            child: TextField(
              controller: _promoController,
              readOnly: _isPromoApplied,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
              decoration: InputDecoration(
                hintText: "Enter promo code",
                hintStyle: GoogleFonts.inter(
                  color: Colors.white38,
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: ElevatedButton(
              onPressed: _isPromoApplied
                  ? null
                  : () {
                      _showApplyPromoDialog(context);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isPromoApplied
                    ? const Color(0xFF0E3E34)
                    : const Color(0xFF2196F3),
                disabledBackgroundColor: const Color(0xFF0E3E34),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                elevation: 0,
              ),
              child: Text(
                _isPromoApplied ? "Applied" : "Apply",
                style: GoogleFonts.inter(
                  color: _isPromoApplied
                      ? const Color(0xFF10B981)
                      : Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    final int discount = _isPromoApplied ? 100 : 0;
    final int total = 1530 - discount;
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937).withOpacity(0.8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildSummaryRow("General Admission (1) :", "\$1,500"),
          if (_isPromoApplied) ...[
            SizedBox(height: 12.h),
            _buildSummaryRow("Promo Code :", "\$ -100"),
          ],
          SizedBox(height: 12.h),
          _buildSummaryRow("Processing Fee :", "\$30"),
          SizedBox(height: 12.h),
          const Divider(color: Colors.white24),
          SizedBox(height: 12.h),
          _buildSummaryRow("Total", "\$$total", isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: isTotal ? Colors.white : Colors.white60,
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: isTotal ? 18.sp : 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
