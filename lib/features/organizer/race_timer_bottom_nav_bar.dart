import 'package:aarongonzales01/features/organizer/race%20timer/presentation/all_racers_record_show_name.dart';
import 'package:aarongonzales01/features/organizer/race%20timer/presentation/all_recers_record_screen.dart';
import 'package:aarongonzales01/features/organizer/race%20timer/presentation/keypad_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RaceTimerBottomNavBar extends StatefulWidget {
  const RaceTimerBottomNavBar({super.key});

  @override
  State<RaceTimerBottomNavBar> createState() => _RaceTimerBottomNavBarState();
}

class _RaceTimerBottomNavBarState extends State<RaceTimerBottomNavBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    AllRecersRecordScreen(),
    AllRacersRecordShowName(),
    KeypadViewScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color(0xFF0D1216), // Dark background color from design
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, -5),
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
                    icon: Icons.diamond_outlined,
                    label: 'Race Control',
                  ),
                  _buildNavItem(
                    index: 1,
                    icon: Icons.list_alt,
                    label: 'Show Name',
                  ),
                  _buildNavItem(
                    index: 2,
                    icon: Icons.calculate_outlined,
                    label: 'Keypad View',
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
    required IconData icon,
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
        width: 80.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF266FEF)
                  : const Color(0xFF8993A4),
              size: 24.sp,
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
