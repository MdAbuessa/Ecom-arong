// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/common_widgets/custom_delete_account_widget.dart';
import 'package:aarongonzales01/common_widgets/custom_logout_widget.dart';
import 'package:aarongonzales01/constants/app_constants.dart';
import 'package:aarongonzales01/features/user/profile/presentation/change_password_screen.dart';
import 'package:aarongonzales01/features/user/profile/presentation/daily_step_screen.dart';
import 'package:aarongonzales01/features/user/profile/widgets/setting_expandable_tile.dart';
import 'package:aarongonzales01/features/user/profile/widgets/setting_info_row.dart';
import 'package:aarongonzales01/features/user/profile/widgets/setting_item.dart';
import 'package:aarongonzales01/features/user/profile/widgets/setting_notif_tile.dart';
import 'package:aarongonzales01/features/user/profile/widgets/setting_trailing_helpers.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/di.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

/// The full scrollable body of the Settings screen.
/// Receives all state values and callbacks from [_SettingScreenState].
class SettingBody extends StatelessWidget {
  const SettingBody({
    super.key,
    // Section expand flags
    required this.accountExpanded,
    required this.appExpanded,
    required this.dataExpanded,
    required this.notifExpanded,
    // Animations
    required this.accountAnimation,
    required this.appAnimation,
    required this.dataAnimation,
    required this.notifAnimation,
    // Toggle callbacks
    required this.onToggleAccount,
    required this.onToggleApp,
    required this.onToggleData,
    required this.onToggleNotif,
    // Notif state
    required this.pushNotifEnabled,
    required this.emailNotifEnabled,
    required this.onPushChanged,
    required this.onEmailChanged,
    // App settings state
    required this.dailyStepGoal,
    required this.onDailyStepGoalChanged,
  });

  final bool accountExpanded;
  final bool appExpanded;
  final bool dataExpanded;
  final bool notifExpanded;
  final Animation<double> accountAnimation;
  final Animation<double> appAnimation;
  final Animation<double> dataAnimation;
  final Animation<double> notifAnimation;
  final VoidCallback onToggleAccount;
  final VoidCallback onToggleApp;
  final VoidCallback onToggleData;
  final VoidCallback onToggleNotif;
  final bool pushNotifEnabled;
  final bool emailNotifEnabled;
  final ValueChanged<bool> onPushChanged;
  final ValueChanged<bool> onEmailChanged;
  final int dailyStepGoal;
  final ValueChanged<int> onDailyStepGoalChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomBackButton(),
              Text(
                "Settings",
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 44.w),
            ],
          ),
          SizedBox(height: 32.h),

          // Account Settings
          SettingExpandableTile(
            assetIcon: 'assets/images/account_setting.png',
            title: "Account Settings",
            isExpanded: accountExpanded,
            onToggle: onToggleAccount,
            animation: accountAnimation,
            children: [
              SettingInfoRow(
                icon: Icons.account_circle_outlined,
                label: "Race Realm ID",
                trailing: settingTrailingText("M364247863"),
                showDivider: true,
              ),
              SettingInfoRow(
                icon: Icons.mail_outline_rounded,
                label: "Email",
                trailing: settingTrailingText("aaron@gamil.com"),
                showDivider: true,
              ),
              SettingInfoRow(
                icon: Icons.lock_outline_rounded,
                label: "Password",
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    settingTrailingText("Set a Password"),
                    SizedBox(width: 6.w),
                    settingOrangeDot(),
                  ],
                ),
                showDivider: true,
                onTap: () => Get.to(() => const ChangePasswordScreen()),
              ),
              SettingInfoRow(
                icon: Icons.link_rounded,
                label: "Connect with Social Account",
                trailing: Icon(
                  Icons.check_rounded,
                  color: Colors.white.withOpacity(0.7),
                  size: 20.sp,
                ),
                showDivider: false,
              ),
            ],
          ),

          // Personal Information
          SettingItem(
            iconWidget: Image.asset(
              'assets/images/profile.png',
              width: 22.w,
              height: 22.w,
              color: const Color(0xFF266FEF),
            ),
            title: "Personal Information",
            onTap: () =>
                NavigationService.navigateTo(Routes.personalInformationScreen),
          ),

          // App Settings
          SettingExpandableTile(
            assetIcon: 'assets/images/app_setting.png',
            title: "App Settings",
            isExpanded: appExpanded,
            onToggle: onToggleApp,
            animation: appAnimation,
            children: [
              SettingInfoRow(
                assetIcon: 'assets/images/daily_step.png',
                label: "Daily Step Goal",
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    settingTrailingText("$dailyStepGoal"),
                    SizedBox(width: 6.w),
                    settingOrangeDot(),
                  ],
                ),
                showDivider: true,
                onTap: () async {
                  final v = await showDialog<int>(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) => DailyStepScreen(initialGoal: dailyStepGoal),
                  );
                  if (v != null) onDailyStepGoalChanged(v);
                },
              ),
              SettingInfoRow(
                assetIcon: 'assets/images/target_weight.png',
                label: "Target Weight",
                trailing: settingTrailingText("Set"),
                showDivider: false,
                onTap: () async {
                  final v = await showDialog<int>(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) => DailyStepScreen(initialGoal: dailyStepGoal),
                  );
                  if (v != null) onDailyStepGoalChanged(v);
                },
              ),
            ],
          ),

          // Data & Syncing
          SettingExpandableTile(
            assetIcon: 'assets/images/data_synce.png',
            title: "Data & Syncing",
            isExpanded: dataExpanded,
            onToggle: onToggleData,
            animation: dataAnimation,
            children: [
              SettingInfoRow(
                icon: Icons.sync_rounded,
                label: "Data Sync",
                trailing: const SizedBox.shrink(),
                showDivider: true,
              ),
              SettingInfoRow(
                icon: Icons.devices_other_rounded,
                label: "Connect Devices",
                trailing: const SizedBox.shrink(),
                showDivider: false,
              ),
            ],
          ),

          // Notification & Reminders
          SettingNotifTile(
            isExpanded: notifExpanded,
            onToggle: onToggleNotif,
            animation: notifAnimation,
            pushNotifEnabled: pushNotifEnabled,
            emailNotifEnabled: emailNotifEnabled,
            onPushChanged: onPushChanged,
            onEmailChanged: onEmailChanged,
          ),

          // Privacy Policy
          SettingItem(
            iconWidget: Image.asset(
              'assets/images/privacy_policy.png',
              width: 22.w,
              height: 22.w,
              color: const Color(0xFF266FEF),
            ),
            title: "Privacy Policy",
            onTap: () =>
                NavigationService.navigateTo(Routes.privacyPolicyScreen),
          ),

          // Help and Support
          SettingItem(
            iconWidget: Image.asset(
              'assets/images/help_and_support.png',
              width: 22.w,
              height: 22.w,
              color: const Color(0xFF266FEF),
            ),
            title: "Help & Support",
            onTap: () =>
                NavigationService.navigateTo(Routes.helpAndSupportScreen),
          ),
          // Terms & Conditions
          SettingItem(
            iconWidget: Image.asset(
              'assets/images/term_and_condition.png',
              width: 22.w,
              height: 22.w,
              color: const Color(0xFF266FEF),
            ),
            title: "Terms & Conditions",
            onTap: () =>
                NavigationService.navigateTo(Routes.termsAndConditionsScreen),
          ),
          // Log Out
          SettingItem(
            iconWidget: SvgPicture.asset(
              'assets/images/logout.svg',
              width: 22.w,
              height: 22.w,
              colorFilter: const ColorFilter.mode(
                Color(0xFF266FEF),
                BlendMode.srcIn,
              ),
            ),
            title: "Log Out",
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) => CustomLogoutWidget(
                  onTap: () async {
                    final success = await logoutRxObj.logoutRx();
                    if (success) {
                      appData.write(kKeyIsLoggedIn, false);
                      appData.write(kKeyAccessToken, '');
                      appData.write(kKeyRefreshToken, '');
                      appData.write(kKeyIsProfileSelected, false);
                      appData.write(kKeyUserRole, '');
                      NavigationService.navigateToReplacement(
                        Routes.loginScreen,
                      );
                    }
                  },
                  subtitle: "Are you sure want to Log Out",
                  title: "Log Out",
                ),
              );
            },
          ),

          // Delete Account
          SettingItem(
            iconWidget: Image.asset(
              'assets/images/delete.png',
              width: 22.w,
              height: 22.w,
              color: const Color(0xFFEF2626),
            ),
            title: "Delete Account",
            isDestructive: true,
            onTap: () {
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (_) => const CustomDeleteAccountWidget(),
              );
            },
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
