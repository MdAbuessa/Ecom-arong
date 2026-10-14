import 'package:aarongonzales01/features/organizer/profile/widgets/achievement_card.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';

class OrgAchievementsScreen extends StatefulWidget {
  const OrgAchievementsScreen({super.key});

  @override
  State<OrgAchievementsScreen> createState() => _OrgAchievementsScreenState();
}

class _OrgAchievementsScreenState extends State<OrgAchievementsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF061115),
      appBar: ProfileAppBar(
        title: "Achievements",
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            AchievementCard(
              icon: Icon(
                Icons.groups_outlined,
                color: Color(0xFFE9B981),
                size: 30,
              ),
              title: "10+ Events",
              subtitle: "Unlocked Mar 2026",
            ),
            AchievementCard(
              icon: Icon(Icons.emoji_events, color: Colors.amber, size: 30),
              title: "100+ Participants",
              subtitle: "Unlocked Feb 2026",
            ),
            AchievementCard(
              icon: Icon(Icons.verified, color: Colors.blue, size: 30),
              title: "Verified Organizer",
              subtitle: "Unlocked Jan 2026",
            ),
            AchievementCard(
              icon: Icon(Icons.verified, color: Colors.blue, size: 30),
              title: "Top Rated",
              subtitle: "Unlocked Apr 2026",
            ),
          ],
        ),
      ),
    );
  }
}
