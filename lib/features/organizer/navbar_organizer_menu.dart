import 'package:aarongonzales01/assets_helper/app_icons.dart';
import 'package:aarongonzales01/features/organizer/community/presentation/community_screen.dart';
import 'package:aarongonzales01/features/organizer/events/presentation/events_screen.dart';
import 'package:aarongonzales01/features/organizer/home/presentation/organizer_home_screen.dart';
import 'package:aarongonzales01/features/organizer/participant/presentation/participant_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavbarOrganizerMenu extends StatefulWidget {
  const NavbarOrganizerMenu({super.key});

  @override
  State<NavbarOrganizerMenu> createState() => _NNavbarOrganizerMenuState();
}

class _NNavbarOrganizerMenuState extends State<NavbarOrganizerMenu> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const OrganizerHomeScreen(),
    const EventsScreen(),
    const ParticipantScreen(),
    const CommunityScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedIndex],

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(
                    index: 0,
                    icon: AppIcons.home,
                    activeIcon: AppIcons.home_selected,
                    label: 'Home'.tr,
                  ),
                  _buildNavItem(
                    index: 1,
                    icon: 'assets/images/event.png',
                    activeIcon: 'assets/images/event_selected.png',
                    label: 'Events'.tr,
                  ),
                  _buildNavItem(
                    index: 2,
                    icon: 'assets/images/participants.png',
                    activeIcon: 'assets/images/selected_participant.png',
                    label: 'Participants'.tr,
                  ),
                  _buildNavItem(
                    index: 3,
                    icon: 'assets/images/community.png',
                    activeIcon: 'assets/images/selected_community.png',
                    label: 'Community'.tr,
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
        // width: 60.w,
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
