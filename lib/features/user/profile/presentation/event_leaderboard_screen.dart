// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/assets_helper/app_icons.dart';
import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/features/user/profile/presentation/summer_5k_challenge_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EventLeaderboardScreen extends StatefulWidget {
  const EventLeaderboardScreen({super.key});

  @override
  State<EventLeaderboardScreen> createState() => _EventLeaderboardScreenState();
}

class _EventLeaderboardScreenState extends State<EventLeaderboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  int _selectedEventIndex = 0; // Default highlight on the first item

  // Mock leaderboard events list
  final List<String> _events = [
    'Summer 5K Challenge',
    'Marathon Madness',
    'Trail Running Adventure',
    'Urban Sprint 10K',
    'Mountain Ascent Trail',
    'Midnight Half Marathon',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter events based on search input query
    final filteredEvents = _events
        .where(
          (event) => event.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF061115), // Deep premium background color
      body: SafeArea(
        child: Column(
          children: [
            // ── Header (Back Button + Centered Title) ──────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomBackButton(),
                  Text(
                    'Event Leader board',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 44.w), // Spacer to balance back button
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // ── Search Field Container ──────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF131E25), // Dark gray/teal search bg
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      color: Colors.white.withOpacity(0.4),
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val;
                          });
                        },
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search event',
                          hintStyle: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 14.sp,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    if (_searchQuery.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = "";
                          });
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white.withOpacity(0.5),
                          size: 18.sp,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 24.h),

            // ── Event Leaderboards List ──────────────────────────────────
            Expanded(
              child: filteredEvents.isEmpty
                  ? Center(
                      child: Text(
                        'No events found',
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.4),
                          fontSize: 14.sp,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 15.h,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredEvents.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 14.h),
                      itemBuilder: (context, index) {
                        final eventName = filteredEvents[index];
                        // Map the overall index back to support selection highlight state
                        final originalIndex = _events.indexOf(eventName);
                        final isSelected = originalIndex == _selectedEventIndex;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedEventIndex = originalIndex;
                            });
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Summer5kChallengeScreen(
                                          title: eventName,
                                        ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF091115),
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(
                                        0xFF266FEF,
                                      ) // Selected blue outline
                                    : Colors.white.withOpacity(
                                        0.04,
                                      ), // Subtle dark gray outline
                                width: isSelected ? 1.5.w : 1.w,
                              ),
                            ),
                            child: Row(
                              children: [
                                // Curved Return / Leaderboard Blue Icon wrapper
                                Container(
                                  width: 38.w,
                                  height: 38.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: Color(0xFF266FEF),
                                      width: 1.5.w,
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    AppIcons.arrowRight,
                                    color: Color(0xFF266FEF),
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                                SizedBox(width: 16.w),

                                // Event Title Text
                                Expanded(
                                  child: Text(
                                    eventName,
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                // Chevron Right Arrow
                                Icon(
                                  Icons.chevron_right_rounded,
                                  color: Colors.white.withOpacity(0.4),
                                  size: 24.sp,
                                ),
                              ],
                            ),
                          ),
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
