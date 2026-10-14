import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/pending_request_card_widget.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JoinPendingRequestScreen extends StatefulWidget {
  const JoinPendingRequestScreen({super.key});

  @override
  State<JoinPendingRequestScreen> createState() =>
      _JoinPendingRequestScreenState();
}

class _JoinPendingRequestScreenState extends State<JoinPendingRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        title: "Pending Requests",
        onBackTap: () => NavigationService.goBack,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            Text(
              "140 Total Pending",
              style: TextFontStyle.textStyle16InterW600.copyWith(
                fontSize: 20.sp,
                color: Color(0xFFFFC107),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded( 
              child: ListView.builder(
                itemCount: 8,
                physics: BouncingScrollPhysics(), 
                itemBuilder: (context, index) {
                  return PendingRequestCardWidget(
                    name: index % 2 == 0 ? "Ayana mere" : "Milcher killing",
                    location: "Oreland, USA",
                    time: index == 0 ? "1 hour ago" : "${index + 1} hours ago",
                    image: index % 2 == 0
                        ? "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop"
                        : "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1974&auto=format&fit=crop",
                    onAccept: () {},
                    onDelete: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
