import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/promocodes/widgets/delete_promo_code_dialog.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoCodeDetailsScreen extends StatefulWidget {
  final Map<String, String> promoData;

  const PromoCodeDetailsScreen({
    super.key,
    required this.promoData,
  });

  @override
  State<PromoCodeDetailsScreen> createState() => _PromoCodeDetailsScreenState();
}

class _PromoCodeDetailsScreenState extends State<PromoCodeDetailsScreen> {
  bool _isInactive = false;

  void _copyToClipboard(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF142C3E),
        content: Text(
          "Promo code '$code' copied to clipboard!",
          style: TextFontStyle.textStyle14InterW500.copyWith(
            color: AppColor.c2196F3,
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    final navigator = Navigator.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return DeletePromoCodeDialog(
          promoName: widget.promoData["title"] ?? "Promo Code",
          promoCode: widget.promoData["code"] ?? "CODE",
        );
      },
    ).then((confirmed) {
      if (confirmed == true) {
        // Show success toast
        ToastUtil.showShortToast("Promo code deleted successfully!");
        // Navigate back to Promo Codes list screen
        navigator.pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.promoData["title"] ?? "Summer Special Discount";
    final subtitle = widget.promoData["subtitle"] ?? "Summer Music Festival";
    final code = widget.promoData["code"] ?? "SUM2-7X9K2L";
    final status = widget.promoData["status"] ?? "Active";
    final discount = widget.promoData["discount"] ?? "20% OFF";
    final expires = widget.promoData["expires"] ?? "Aug 31, 2025";
    final usedStr = widget.promoData["used"] ?? "45/100";

    // Parse usage
    int usedCount = 45;
    int totalCount = 100;
    final usedParts = usedStr.split('/');
    if (usedParts.length == 2) {
      usedCount = int.tryParse(usedParts[0]) ?? 45;
      totalCount = int.tryParse(usedParts[1]) ?? 100;
    }
    double progressRatio = totalCount > 0 ? (usedCount / totalCount) : 0.45;
    int progressPercent = (progressRatio * 100).toInt();

    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 90.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 5.w, top: 5.h, bottom: 5.h),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
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
          ),
        ),
        centerTitle: true,
        title: Text(
          "Promo Code Details",
          style: TextFontStyle.textStyle24RobotoW600.copyWith(
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          children: [
            // Main Ticket Card
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          subtitle,
                          style: TextFontStyle.textStyle14InterW400.copyWith(
                            color: const Color(0xFF8E9AA5),
                            fontSize: 13.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: _isInactive ? const Color(0xFF2B3338) : const Color(0xFF10281F),
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Text(
                          _isInactive ? "Inactive" : status,
                          style: TextFontStyle.textStyle12UrbanistW600.copyWith(
                            color: _isInactive ? Colors.white54 : const Color(0xFF22C55E),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    title,
                    style: TextFontStyle.textStyle16InterW600.copyWith(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Code box
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                          code,
                          style: TextFontStyle.textStyle14InterW500.copyWith(
                            color: AppColor.c2196F3,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                            letterSpacing: 0.5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _copyToClipboard(context, code),
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
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Detail boxes
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildDetailBox(
                        icon: Icons.local_offer_outlined,
                        iconColor: const Color(0xFF2196F3),
                        label: "Discount",
                        value: discount,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildDetailBox(
                        icon: Icons.group_outlined,
                        iconColor: const Color(0xFFA855F7),
                        label: "Usage",
                        value: "$usedCount",
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
                        value: expires,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _buildDetailBox(
                        icon: Icons.shield_outlined,
                        iconColor: const Color(0xFF22C55E),
                        label: "Applied To",
                        value: "2 Events",
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Usage Progress Box
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1B232A),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: const Color(0x0DFFFFFF),
                  width: 1.w,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Usage Progress",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$progressPercent%",
                        style: TextStyle(
                          color: AppColor.c2196F3,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: LinearProgressIndicator(
                      value: progressRatio,
                      backgroundColor: const Color(0xFF111A20),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColor.c2196F3,
                      ),
                      minHeight: 8.h,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "$usedCount used out of $totalCount total redemptions",
                    style: TextStyle(
                      color: const Color(0xFF8E9AA5),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Inactive Promo Code Selector Box
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: const Color(0xFF1C2A35),
                  width: 1.w,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Inactive Promo Code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Switch.adaptive(
                    value: _isInactive,
                    activeThumbColor: AppColor.c2196F3,
                    activeTrackColor: const Color(0x332196F3),
                    inactiveThumbColor: Colors.white54,
                    inactiveTrackColor: const Color(0xFF2B3338),
                    onChanged: (val) {
                      setState(() {
                        _isInactive = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),

            // Delete Button
            ElevatedButton(
              onPressed: () => _showDeleteDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD64545),
                minimumSize: Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                elevation: 0,
              ),
              child: Text(
                "Delete Promo Code",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
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
            child: Icon(
              icon,
              color: iconColor,
              size: 18.sp,
            ),
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
