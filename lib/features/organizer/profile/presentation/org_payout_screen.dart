import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_button.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrgPayoutScreen extends StatefulWidget {
  const OrgPayoutScreen({super.key});

  @override
  State<OrgPayoutScreen> createState() => _OrgPayoutScreenState();
}

class _OrgPayoutScreenState extends State<OrgPayoutScreen> {
  final TextEditingController _payoutController = TextEditingController(
    text: "\$50000",
  );

  @override
  void dispose() {
    _payoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        title: "Payout",
        onBackTap: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Cards
            _buildStatCard("Total Member", "\$12,450.00"),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(child: _buildStatCard("Available", "\$12,450.00")),
                SizedBox(width: 12.w),
                Expanded(child: _buildStatCard("Pending", "\$12,450.00")),
              ],
            ),
            SizedBox(height: 24.h),

            // REQUEST PAYOUT Section
            Text(
              "REQUEST PAYOUT",
              style: TextFontStyle.textStyle14InterW500.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                letterSpacing: 1.2,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),
            _buildRequestPayoutSection(),
            SizedBox(height: 24.h),

            // BANK DETAILS Section
            Text(
              "BANK DETAILS",
              style: TextFontStyle.textStyle14InterW500.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                letterSpacing: 1.2,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),
            _buildBankDetailsCard(),
            SizedBox(height: 24.h),

            // PAYOUT HISTORY Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "PAYOUT HISTORY",
                  style: TextFontStyle.textStyle14InterW500.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View All",
                    style: TextFontStyle.textStyle14InterW500.copyWith(
                      color: AppColor.c2196F3,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) => _buildHistoryItem(),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Color(0xFF0B1A20),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Color(0xFF1570EF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.trending_up,
              color: const Color(0xFF1570EF),
              size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  value,
                  style: TextFontStyle.textStyle14InterW500.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestPayoutSection() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1A20),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payout Amount",
            style: TextFontStyle.textStyle14InterW400.copyWith(
              color: Colors.white70,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 8.h),
          CustomTextfieldWidget(
            hintText: "\$50000",
            controller: _payoutController,
          ),
          SizedBox(height: 12.h),
          Text(
            "Available balance: \$3,450.00",
            style: TextFontStyle.textStyle14InterW400.copyWith(
              color: Colors.white54,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(height: 20.h),
          CustomButton(
            text: "Request Payout",
            backgroundColor: const Color(0xFF266FEF),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildBankDetailsCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0B1A20),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBankDetailItem("Account Holder Name", "John Anderson"),
          SizedBox(height: 16.h),
          _buildBankDetailItem("Bank Name", "Prime Bank"),
          SizedBox(height: 16.h),
          _buildBankDetailItem("Account Number", "•••• •••• 4532"),
        ],
      ),
    );
  }

  Widget _buildBankDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextFontStyle.textStyle14InterW400.copyWith(
            color: Colors.white54,
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextFontStyle.textStyle14InterW500.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1A20),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1570EF).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.trending_up,
              color: const Color(0xFF1570EF),
              size: 16.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$1,250.00",
                  style: TextFontStyle.textStyle14InterW500.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Prime Bank •••• 4532",
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    color: Colors.white54,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$1,250.00",
            style: TextFontStyle.textStyle14InterW400.copyWith(
              color: Colors.white70,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
