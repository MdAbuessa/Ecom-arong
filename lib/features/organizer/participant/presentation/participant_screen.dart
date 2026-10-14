import 'package:aarongonzales01/features/organizer/participant/widgets/participant_event_selector.dart';
import 'package:aarongonzales01/features/organizer/participant/widgets/participant_search_filter.dart';
import 'package:aarongonzales01/features/organizer/participant/widgets/participants_table.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParticipantScreen extends StatefulWidget {
  const ParticipantScreen({super.key});

  @override
  State<ParticipantScreen> createState() => _ParticipantScreenState();
}

class _ParticipantScreenState extends State<ParticipantScreen> {
  String selectedEvent = "SK City Run";

  final List<Map<String, dynamic>> participants = [
    {
      "bib": "101",
      "name": "Ayana Mera meherin",
      "email": "ayana@gmail.com",
      "event": "5K City Run",
      "status": "Completed",
      "distance": "5.0 KM",
      "time": "18:45 AM",
      "image": "https://i.pravatar.cc/150?img=1",
    },
    {
      "bib": "102",
      "name": "Ayana Mera meherin",
      "email": "ayana@gmail.com",
      "event": "5K City Run",
      "status": "Completed",
      "distance": "5.0 KM",
      "time": "18:45 AM",
      "image": "https://i.pravatar.cc/150?img=2",
    },
    {
      "bib": "103",
      "name": "Ayana Mera meherin",
      "email": "ayana@gmail.com",
      "event": "5K City Run",
      "status": "Running",
      "distance": "5.0 KM",
      "time": "18:45 AM",
      "image": "https://i.pravatar.cc/150?img=3",
    },
    {
      "bib": "104",
      "name": "Ayana Mera meherin",
      "email": "ayana@gmail.com",
      "event": "5K City Run",
      "status": "Resisted",
      "distance": "5.0 KM",
      "time": "18:45 AM",
      "image": "https://i.pravatar.cc/150?img=4",
    },
    {
      "bib": "105",
      "name": "Bourgeois",
      "email": "ayana@gmail.com",
      "event": "5K City Run",
      "status": "Running",
      "distance": "6.2 KM",
      "time": "18:45 AM",
      "image": "https://i.pravatar.cc/150?img=5",
    },
    {
      "bib": "106",
      "name": "Ayana Mera meherin",
      "email": "ayana@gmail.com",
      "event": "5K City Run",
      "status": "Completed",
      "distance": "5.0 KM",
      "time": "18:45 AM",
      "image": "https://i.pravatar.cc/150?img=6",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF060D14),
      appBar: ProfileAppBar(title: "Participants Overview"),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ParticipantSearchFilter(),
            ParticipantEventSelector(
              selectedEvent: selectedEvent,
              onTap: () {},
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ParticipantsTable(participants: participants),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
