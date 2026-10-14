import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecuritySettingsDialog extends StatefulWidget {
  const SecuritySettingsDialog({super.key});

  @override
  State<SecuritySettingsDialog> createState() => _SecuritySettingsDialogState();
}

class _SecuritySettingsDialogState extends State<SecuritySettingsDialog> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1E2329),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOption(
              index: 0,
              icon: Icons.person_outline,
              title: "Change Password",
              onTap: () {
                setState(() => _selectedIndex = 0);
                Navigator.pop(context);
                NavigationService.navigateTo(Routes.orgChangePasswordScren);
              },
            ),
            SizedBox(height: 8.h), 
            _buildOption(
              index: 1,
              icon: Icons.person_outline,
              title: "Enable Two_Factor Authentication",
              onTap: () {
                setState(() => _selectedIndex = 1);
              },
            ),
            SizedBox(height: 8.h),
            _buildOption(
              index: 2,
              icon: Icons.mail_outline,
              title: "Manage Connected Devices",
              onTap: () {
                setState(() => _selectedIndex = 2);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required int index,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColor.c2196F3 : Colors.transparent,
            width: 1.5.w,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: TextFontStyle.textStyle14InterW500.copyWith(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
