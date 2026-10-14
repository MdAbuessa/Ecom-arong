import 'dart:io';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/assets_helper/app_icons.dart';
import 'package:aarongonzales01/assets_helper/app_images.dart';
import 'package:aarongonzales01/common_widgets/custom_logout_widget.dart';
import 'package:aarongonzales01/constants/app_constants.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/security_settings_dialog.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/di.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/features/user/profile/model/get_user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_list_item.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_stat_card.dart';
import 'package:shimmer/shimmer.dart';

class OrganiserProfileScreen extends StatefulWidget {
  const OrganiserProfileScreen({super.key});

  @override
  State<OrganiserProfileScreen> createState() => _OrganiserProfileScreenState();
}

class _OrganiserProfileScreenState extends State<OrganiserProfileScreen> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    getUserInfoRxObj.fetchUserInfo();
  }

  void _showSecuritySettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SecuritySettingsDialog(),
    );
  }

  Widget _shimmerCircle(double radius) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1E2830),
      highlightColor: const Color(0xFF2E3C4A),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: const Color(0xFF1E2830),
      ),
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1E2830),
      highlightColor: const Color(0xFF2E3C4A),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF1E2830),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF061115),
      appBar: ProfileAppBar(
        onBackTap: () {
          NavigationService.goBack;
        },
      ),
      body: StreamBuilder<GetUserInfoModel>(
        stream: getUserInfoRxObj.dataFetcher.stream,
        initialData: getUserInfoRxObj.dataFetcher.valueOrNull,
        builder: (context, snapshot) {
          final isLoading = !snapshot.hasData;
          final user = snapshot.data?.data?.user;

          final displayName =
              (user?.firstName?.isNotEmpty == true
                  ? user!.firstName!
                  : user?.username) ??
              '';
          final avatarUrl = user?.avatar;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UIHelper.verticalSpace(10.h),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 85.h,
                      width: 95.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColor.cFFFFFF, width: 2),
                      ),
                      child: ClipOval(
                        child: isLoading
                            ? _shimmerCircle(42.5.r)
                            : _selectedImage != null
                            ? Image.file(_selectedImage!, fit: BoxFit.cover)
                            : (avatarUrl != null &&
                                  avatarUrl.startsWith('http'))
                            ? Image.network(avatarUrl, fit: BoxFit.cover)
                            : Image.asset(
                                AppImages.organizer_img,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(24.h),
                if (isLoading)
                  _shimmerBox(width: 150.w, height: 22.h, radius: 6)
                else
                  Text(
                    displayName,
                    style: TextFontStyle.textStyle24RobotoW600.copyWith(
                      color: Colors.white,
                      fontSize: 22.sp,
                    ),
                  ),
                SizedBox(height: 4.h),
                Text(
                  "Member since 01 Feb 2026",
                  style: TextFontStyle.textStyle14InterW500,
                ),
                const SizedBox(height: 30),

                // Grid Stats
                Row(
                  children: [
                    Expanded(
                      child: ProfileStatCard(
                        icon: Icons.calendar_today,
                        value: "127",
                        label: "Events",
                        iconBgColor: const Color(0xFF132F3F),
                        iconColor: Colors.white,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ProfileStatCard(
                        icon: Icons.people_alt,
                        value: "122",
                        label: "Participants",
                        iconBgColor: Color(0xFF132F3F),
                        iconColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ProfileStatCard(
                        icon: Icons.attach_money,
                        value: "\$ 1000",
                        label: "Revenue",
                        iconBgColor: const Color(0xFF132F3F),
                        iconColor: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ProfileStatCard(
                        icon: Icons.star,
                        value: "4.5",
                        label: "Avg Rating",
                        iconBgColor: const Color(0xFF132F3F),
                        iconColor: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // List Items
                ProfileListItem(
                  title: "Personal Information",
                  onTap: () {
                    NavigationService.navigateTo(Routes.editProfileScreen);
                  },
                  icon: AppIcons.profile,
                ),
                ProfileListItem(
                  title: "Achievements",
                  onTap: () {
                    NavigationService.navigateTo(Routes.orgAchievementsScreen);
                  },
                  icon: AppIcons.achievements,
                ),
                ProfileListItem(
                  title: "Notification Preferences",
                  onTap: () {
                    NavigationService.navigateTo(
                      Routes.orgNotificationSettingScreen,
                    );
                  },
                  icon: AppIcons.notification,
                ),
                ProfileListItem(
                  title: "Security Settings",
                  onTap: () => _showSecuritySettingsDialog(context),
                  icon: AppIcons.security,
                ),
                ProfileListItem(
                  title: "Email",
                  onTap: () {
                    NavigationService.navigateTo(Routes.allMailScreen);
                  },
                  icon: AppIcons.email,
                ),
                ProfileListItem(
                  title: "Promo Code",
                  onTap: () {
                    NavigationService.navigateTo(Routes.promoCodesScreen);
                  },
                  icon: AppIcons.promoCode,
                ),
                ProfileListItem(
                  title: "Wallet",
                  onTap: () {
                    NavigationService.navigateTo(Routes.walletScreen);
                  },
                  icon: AppIcons.wallet,
                ),
                ProfileListItem(
                  title: "Privacy Policy",
                  onTap: () {},
                  icon: AppIcons.privacyPolicy,
                ),

                ProfileListItem(
                  title: "Log Out",
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => CustomLogoutWidget(
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
                  icon: AppIcons.logOut,
                ),

                ProfileListItem(
                  title: "Delete Account",
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => CustomLogoutWidget(
                        subtitle: "Are you sure want to Delete Account",
                        title: "Delete Account",
                      ),
                    );
                  },
                  icon: AppIcons.delete,
                ),
                SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}
