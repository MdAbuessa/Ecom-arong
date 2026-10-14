import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_save_button.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/edit_profile_field.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrgChangePasswordScren extends StatefulWidget {
  const OrgChangePasswordScren({super.key});

  @override
  State<OrgChangePasswordScren> createState() => _OrgChangePasswordScrenState();
}

class _OrgChangePasswordScrenState extends State<OrgChangePasswordScren> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        title: "Change Password",
        onBackTap: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EditProfileField(
              label: "Current Password",
              hintText: "**********",
              controller: _currentPasswordController,     
              isPassword: true,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  NavigationService.navigateToUntilReplacement(
                    Routes.forgetPasswordScreen,
                  );
                },
                child: Text(
                  "Forgot Password?",
                  style: TextFontStyle.textStyle14InterW500.copyWith(
                    color: AppColor.c2196F3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            UIHelper.verticalSpace(20.h),
            EditProfileField(
              label: "New Password",
              hintText: "**********",
              controller: _newPasswordController,
              isPassword: true,
            ),
            EditProfileField(
              label: "Confirm Password",
              hintText: "**********",
              controller: _confirmPasswordController,
              isPassword: true,
            ),
            SizedBox(height: 40.h),
            CustomSaveButton(btnText: 'Save Changes'),
          ],
        ),
      ),
    );
  }
}
