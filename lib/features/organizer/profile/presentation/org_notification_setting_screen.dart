import 'package:aarongonzales01/features/organizer/profile/widgets/notification_setting_tile.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrgNotificationSettingScreen extends StatefulWidget {
  const OrgNotificationSettingScreen({super.key});

  @override
  State<OrgNotificationSettingScreen> createState() =>
      _OrgNotificationSettingScreenState();
}

class _OrgNotificationSettingScreenState
    extends State<OrgNotificationSettingScreen> {
  bool _newRegistrations = true;
  bool _completionUpdates = true;
  bool _paymentNotifications = true;
  bool _certificateGeneration = true;
  bool _communityActivity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        title: "Notification Setting",
        onBackTap: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          children: [
            NotificationSettingTile(
              title: "New Participant Registrations",
              description: "Get notified when someone joins your event",
              value: _newRegistrations,
              onChanged: (val) => setState(() => _newRegistrations = val),
            ),
            NotificationSettingTile(
              title: "Event Completion Updates",
              description: "Track when participants complete challenges",
              value: _completionUpdates,
              onChanged: (val) => setState(() => _completionUpdates = val),
            ),
            NotificationSettingTile(
              title: "Payment Notifications",
              description: "Receive alerts for new payments and revenue",
              value: _paymentNotifications,
              onChanged: (val) => setState(() => _paymentNotifications = val),
            ),
            NotificationSettingTile(
              title: "Certificate Generation",
              description: "Know when certificates are auto-generated",
              value: _certificateGeneration,
              onChanged: (val) => setState(() => _certificateGeneration = val),
            ),
            NotificationSettingTile(
              title: "Community Activity",
              description: "Updates from your clubs and groups",
              value: _communityActivity,
              onChanged: (val) => setState(() => _communityActivity = val),
            ),
          ],
        ),
      ),
    );
  }
}
