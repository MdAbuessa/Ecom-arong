import 'package:aarongonzales01/assets_helper/app_icons.dart';
import 'package:aarongonzales01/features/user/activity_tracking/presentation/activity_tracking_screen.dart';
import 'package:aarongonzales01/features/user/home/presentation/user_home_screen.dart';
import 'package:aarongonzales01/features/user/routes/presentation/routes_screen.dart';
import 'package:aarongonzales01/features/user/shop/presentation/shop_screen.dart';
import 'package:aarongonzales01/features/user/social/presentation/social_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserNavigationMenu extends StatefulWidget {
  const UserNavigationMenu({super.key});

  @override
  State<UserNavigationMenu> createState() => _UserNavigationMenuState();
}

class _UserNavigationMenuState extends State<UserNavigationMenu> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const UserHomeScreen(),

    // RoutesAll(),
    // Social(),
    // Shop(),
    const RoutesScreen(),
    const SocialScreen(),
    const ShopScreen(),
  ];


  // Show exit confirmation dialog
  Future<bool> _onWillPop() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Exit App?'),
        content: const Text('Are you sure you want to exit the app?'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Exit'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (shouldExit == true) {
      SystemNavigator.pop();
    }
    return shouldExit ?? false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        extendBody: true,
        body: _screens[_selectedIndex],
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 30.h),
          child: FloatingActionButton(
            onPressed: () {
              // Add action here
              Get.to(() => const ActivityTrackingScreen());
            },
            backgroundColor: const Color(0xFF266FEF), // Bright blue from design
            elevation: 4,
            shape: const CircleBorder(),
            child: Icon(Icons.add, color: Colors.white, size: 32.sp),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0D1216), // Dark background color from design
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomAppBar(
            padding: EdgeInsets.zero,
            color: Colors.transparent,
            elevation: 0,
            child: SizedBox(
              height: 70.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    index: 0,
                    icon: AppIcons.home,
                    activeIcon: AppIcons.home_selected,
                    label: 'Home'.tr,
                  ),
                  _buildNavItem(
                    index: 1,
                    icon: AppIcons.route,
                    activeIcon: AppIcons.route_selected,
                    label: 'Routes'.tr,
                  ),
                  SizedBox(width: 48.w), // Empty space for the central FAB
                  _buildNavItem(
                    index: 2,
                    icon: AppIcons.social,
                    activeIcon: AppIcons.social_selected,
                    label: 'Social'.tr,
                  ),
                  _buildNavItem(
                    index: 3,
                    icon: AppIcons.shop,
                    activeIcon: AppIcons.shop_selected,
                    label: 'Shop'.tr,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String icon,
    required String activeIcon,
    required String label,
  }) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isSelected ? activeIcon : icon,
              color: isSelected
                  ? const Color(0xFF266FEF)
                  : const Color(0xFF8993A4),
              height: 24.h,
              width: 24.w,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  color: isSelected
                      ? const Color(0xFF266FEF)
                      : const Color(0xFF8993A4),
                  size: 24.sp,
                );
              },
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF266FEF)
                    : const Color(0xFF8993A4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
