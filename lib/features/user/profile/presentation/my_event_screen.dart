// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyEventScreen extends StatefulWidget {
  const MyEventScreen({super.key});

  @override
  State<MyEventScreen> createState() => _MyEventScreenState();
}

class _MyEventScreenState extends State<MyEventScreen> {
  int _selectedTabIndex = 0; // 0 for All, 1 for Ongoing, 2 for Completed

  // Mock events data with image URLs, fallback assets, and statuses
  final List<Map<String, dynamic>> _events = [
    {
      'title': '5K City Run',
      'date': 'April 15, 2026',
      'location': 'Virtual',
      'status': 'Ongoing',
      'imageUrl':
          'https://images.unsplash.com/photo-1501555088652-021faa106b9b?q=80&w=400&auto=format&fit=crop',
    },
    {
      'title': 'Marathon Madness',
      'date': 'May 15, 2026',
      'location': 'Virtual',
      'status': 'Ongoing',
      'imageUrl':
          'https://images.unsplash.com/photo-1551632811-561732d1e306?q=80&w=400&auto=format&fit=crop',
    },
    {
      'title': '5K City Run',
      'date': 'April 15, 2026',
      'location': 'Virtual',
      'status': 'Ongoing',
      'imageUrl':
          'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?q=80&w=400&auto=format&fit=crop',
    },
    {
      'title': 'Marathon Madness',
      'date': 'May 15, 2026',
      'location': 'Virtual',
      'status': 'Ongoing',
      'imageUrl':
          'https://images.unsplash.com/photo-1527004013197-933c4bb611b3?q=80&w=400&auto=format&fit=crop',
    },
    {
      'title': '5K City Run',
      'date': 'April 15, 2026',
      'location': 'Virtual',
      'status': 'Completed',
      'imageUrl':
          'https://images.unsplash.com/photo-1472791108050-e82fc52ffc3d?q=80&w=400&auto=format&fit=crop',
    },
    {
      'title': 'Marathon Madness',
      'date': 'May 15, 2026',
      'location': 'Virtual',
      'status': 'Completed',
      'imageUrl':
          'https://images.unsplash.com/photo-1486915309851-b0cc1f8a0084?q=80&w=400&auto=format&fit=crop',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filter events based on active tab selection
    final filteredEvents = _events.where((event) {
      if (_selectedTabIndex == 1) return event['status'] == 'Ongoing';
      if (_selectedTabIndex == 2) return event['status'] == 'Completed';
      return true; // All
    }).toList();

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
                  CustomBackButton(),
                  Text(
                    'My Events',
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

            // ── Tabs Row ────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  _buildTab(index: 0, label: 'All (6)'),
                  SizedBox(width: 8.w),
                  _buildTab(index: 1, label: 'Ongoing (4)'),
                  SizedBox(width: 8.w),
                  _buildTab(index: 2, label: 'Completed (2)'),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            // ── Events Grid ──────────────────────────────────────────────
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.w,
                  mainAxisSpacing: 14.h,
                  childAspectRatio:
                      0.82, // Rectangular card ratio matching design
                ),
                itemCount: filteredEvents.length,
                itemBuilder: (context, index) {
                  final event = filteredEvents[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EventDetailScreen(event: event),
                      //   ),
                      // );
                      NavigationService.navigateTo(
                        Routes.eventDetailScreen,
                        arguments: event,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF091115),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          // Background image with loading/error builders
                          Positioned.fill(
                            child: Image.network(
                              event['imageUrl'],
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: const Color(0xFF091115),
                                      child: Center(
                                        child: SizedBox(
                                          width: 24.w,
                                          height: 24.w,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2.w,
                                            color: const Color(0xFF266FEF),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/post1.png',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),

                          // Gradient overlay for text legibility
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.0),
                                    Colors.black.withOpacity(0.85),
                                  ],
                                  stops: const [0.5, 1.0],
                                ),
                              ),
                            ),
                          ),

                          // Event Info Overlay text
                          Positioned(
                            bottom: 16.h,
                            left: 16.w,
                            right: 16.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.white,
                                      size: 14.sp,
                                    ),
                                    SizedBox(width: 6.w),
                                    Expanded(
                                      child: Text(
                                        event['date'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.white,
                                      size: 14.sp,
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      event['location'],
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

  Widget _buildTab({required int index, required String label}) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          height: 44.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF266FEF) // Active blue bg
                : const Color(0xFF131E25), // Inactive dark bg
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.55),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
