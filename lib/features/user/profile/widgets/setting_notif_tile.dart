// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Expandable tile for "Notification & Reminders" with Push & Email toggles.
class SettingNotifTile extends StatelessWidget {
  const SettingNotifTile({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    required this.animation,
    required this.pushNotifEnabled,
    required this.emailNotifEnabled,
    required this.onPushChanged,
    required this.onEmailChanged,
  });

  final bool isExpanded;
  final VoidCallback onToggle;
  final Animation<double> animation;
  final bool pushNotifEnabled;
  final bool emailNotifEnabled;
  final ValueChanged<bool> onPushChanged;
  final ValueChanged<bool> onEmailChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header row
        GestureDetector(
          onTap: onToggle,
          child: Container(
            margin: EdgeInsets.only(bottom: isExpanded ? 0 : 12.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF091115),
              borderRadius: isExpanded
                  ? BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r),
                    )
                  : BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.05),
                width: 1.w,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFF132F3F).withOpacity(0.3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF266FEF).withOpacity(0.2),
                      width: 1.w,
                    ),
                  ),
                  child: SizedBox(
                    width: 22.w,
                    height: 22.w,
                    child: Center(
                      child: Image.asset(
                        'assets/images/notification.png',
                        width: 22.w,
                        height: 22.w,
                        color: const Color(0xFF266FEF),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    "Notification & Reminders",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                AnimatedRotation(
                  turns: isExpanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 260),
                  curve: Curves.easeInOut,
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.white.withOpacity(0.6),
                    size: 24.sp,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Expandable content with toggles
        SizeTransition(
          sizeFactor: animation,
          child: Container(
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1A23),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
              border: Border(
                left: BorderSide(
                  color: Colors.white.withOpacity(0.05),
                  width: 1.w,
                ),
                right: BorderSide(
                  color: Colors.white.withOpacity(0.05),
                  width: 1.w,
                ),
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.05),
                  width: 1.w,
                ),
              ),
            ),
            child: Column(
              children: [
                // Push Notifications toggle
                _NotifToggleRow(
                  icon: Icons.notifications_outlined,
                  label: "Push Notifications",
                  value: pushNotifEnabled,
                  onChanged: onPushChanged,
                ),
                Divider(
                  height: 1,
                  thickness: 1,
                  color: Colors.white.withOpacity(0.05),
                  indent: 16.w,
                  endIndent: 16.w,
                ),
                // Email Notification toggle
                _NotifToggleRow(
                  icon: Icons.mail_outline_rounded,
                  label: "Email Notification",
                  value: emailNotifEnabled,
                  onChanged: onEmailChanged,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Private helper row for a toggle inside the notification tile.
class _NotifToggleRow extends StatelessWidget {
  const _NotifToggleRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white.withOpacity(0.55),
            size: 20.sp,
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.85),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF266FEF),
            inactiveThumbColor: Colors.white.withOpacity(0.5),
            inactiveTrackColor: Colors.white.withOpacity(0.12),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
