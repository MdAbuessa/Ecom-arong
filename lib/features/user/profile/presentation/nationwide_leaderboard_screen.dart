// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class NationwideLeaderboardScreen extends StatefulWidget {
  const NationwideLeaderboardScreen({super.key});

  @override
  State<NationwideLeaderboardScreen> createState() =>
      _NationwideLeaderboardScreenState();
}

class _NationwideLeaderboardScreenState
    extends State<NationwideLeaderboardScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _selectedCountry = "Worldwide"; // Default filter
  bool _showAll = false;
  final Set<int> _expandedIndices = {}; // Track expanded items

  // Mock Nationwide Leaderboard users
  final List<Map<String, dynamic>> _allUsers = [
    {
      'rank': 1,
      'name': 'Alex Cooper',
      'miles': '5 miles',
      'location': 'United State',
      'flag': '🇺🇸',
      'avatar': 'assets/images/person.png',
      'pace': '6:45 / mile',
      'calories': '350 kcal',
      'time': '33 Min 45 Sec',
    },
    {
      'rank': 2,
      'name': 'Nina Patel',
      'miles': '4.8 miles',
      'location': 'India',
      'flag': '🇮🇳',
      'avatar': 'assets/images/person2.png',
      'pace': '7:12 / mile',
      'calories': '320 kcal',
      'time': '34 Min 36 Sec',
    },
    {
      'rank': 3,
      'name': 'Jorge Ramirez',
      'miles': '4.3 miles',
      'location': 'Mexico',
      'flag': '🇲🇽',
      'avatar': 'assets/images/person3.png',
      'pace': '7:30 / mile',
      'calories': '295 kcal',
      'time': '32 Min 15 Sec',
    },
    {
      'rank': 4,
      'name': 'Samantha Lee',
      'miles': '4.2 miles',
      'location': 'Canada',
      'flag': '🇨🇦',
      'avatar': 'assets/images/user_img.png',
      'pace': '7:08 / mile',
      'calories': '290 kcal',
      'time': '29 Min 56 Sec',
    },
    {
      'rank': 5,
      'name': 'Jordan Lee',
      'miles': '4.1 miles',
      'location': 'United State',
      'flag': '🇺🇸',
      'avatar': 'assets/images/person.png',
      'pace': '6:58 / mile',
      'calories': '285 kcal',
      'time': '28 Min 38 Sec',
    },
    {
      'rank': 6,
      'name': 'Tayiba Brown',
      'miles': '3.9 miles',
      'location': 'United State',
      'flag': '🇺🇸',
      'avatar': 'assets/images/person3.png',
      'pace': '7:20 / mile',
      'calories': '270 kcal',
      'time': '28 Min 36 Sec',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Filter by country first
    final List<Map<String, dynamic>> countryFiltered = _allUsers.where((user) {
      if (_selectedCountry == "Worldwide") return true;
      return user['location'] == _selectedCountry;
    }).toList();

    // 2. Filter by search query second
    final List<Map<String, dynamic>> finalFiltered = countryFiltered.where((user) {
      if (_searchQuery.isEmpty) return true;
      return user['name'].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // Determine how many items to display
    final int displayedCount = _showAll
        ? finalFiltered.length
        : (finalFiltered.length > 3 ? 3 : finalFiltered.length);

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.65), // Dark overlay backdrop
      body: Center(
        child: Container(
          width: 335.w,
          constraints: BoxConstraints(maxHeight: 600.h),
          decoration: BoxDecoration(
            color: const Color(0xFF101B20), // Premium dark teal/gray dialog bg
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.04),
              width: 1.w,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Header (Title + Close Button) ──────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nationwide Leaderboard',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white.withOpacity(0.7),
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),

              // ── Search & Filter Row ────────────────────────────
              Row(
                children: [
                  // Search Box
                  Expanded(
                    child: Container(
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF131E25),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: Colors.white.withOpacity(0.4),
                            size: 18.sp,
                          ),
                          SizedBox(width: 10.w),
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
                                fontSize: 13.sp,
                              ),
                              decoration: InputDecoration(
                                hintText: _selectedCountry == 'Worldwide'
                                    ? 'Worldwide'
                                    : 'Search in $_selectedCountry',
                                hintStyle: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 13.sp,
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
                                size: 16.sp,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),

                  // Filter tuning icon
                  GestureDetector(
                    onTap: () async {
                      final selected = await showDialog<String>(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => _CountryFilterDialog(
                          initialCountry: _selectedCountry,
                        ),
                      );
                      if (selected != null) {
                        setState(() {
                          _selectedCountry = selected;
                          _expandedIndices.clear(); // collapse expanded items on filter change
                        });
                      }
                    },
                    child: Container(
                      width: 44.h,
                      height: 44.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF131E25),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/filter.png',
                          width: 18.sp,
                          height: 18.sp,
                          color: Colors.white.withOpacity(0.7),
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.filter_list_rounded,
                              color: Colors.white.withOpacity(0.7),
                              size: 18.sp,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),

              // ── Leaderboard List ────────────────────────────────
              Flexible(
                child: finalFiltered.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 36.h),
                        child: Text(
                          'No participants found',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 13.sp,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: displayedCount,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final user = finalFiltered[index];
                          final rank = user['rank'] as int;
                          final isExpanded = _expandedIndices.contains(index);

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isExpanded) {
                                  _expandedIndices.remove(index);
                                } else {
                                  _expandedIndices.add(index);
                                }
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                color: const Color(0xFF131E25), // row container bg
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.02),
                                  width: 1.w,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      // Rank Badge (Gold Trophy, Silver/Bronze Medal, or #Text)
                                      _buildRankBadge(rank),
                                      SizedBox(width: 12.w),

                                      // Avatar Profile Image
                                      _buildAvatar(user['avatar']),
                                      SizedBox(width: 12.w),

                                      // User Info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user['name'],
                                              style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Row(
                                              children: [
                                                Text(
                                                  user['miles'],
                                                  style: GoogleFonts.inter(
                                                    color: Colors.white
                                                        .withOpacity(0.55),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(width: 8.w),
                                                Icon(
                                                  Icons.location_on_rounded,
                                                  color: Colors.white
                                                      .withOpacity(0.55),
                                                  size: 12.sp,
                                                ),
                                                SizedBox(width: 4.w),
                                                Expanded(
                                                  child: Text(
                                                    user['location'],
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white
                                                          .withOpacity(0.55),
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Trailing Flag and Expand Arrow
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            user['flag'],
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          Icon(
                                            isExpanded
                                                ? Icons.keyboard_arrow_up_rounded
                                                : Icons
                                                    .keyboard_arrow_down_rounded,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            size: 18.sp,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Expanded detail card (polished stats breakdown)
                                  if (isExpanded) ...[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10.h,
                                        left: 4.w,
                                        right: 4.w,
                                      ),
                                      child: Divider(
                                        color: Colors.white.withOpacity(0.06),
                                        thickness: 1.h,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 6.h,
                                        left: 4.w,
                                        right: 4.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildDetailStat(
                                              "Pace", user['pace']),
                                          _buildDetailStat(
                                              "Energy", user['calories']),
                                          _buildDetailStat(
                                              "Active Time", user['time']),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(height: 16.h),

              // ── View All / Collapse Button ──────────────────────
              if (finalFiltered.length > 3)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showAll = !_showAll;
                    });
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _showAll ? 'View Less' : 'View All',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF266FEF),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(
                          _showAll
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: const Color(0xFF266FEF),
                          size: 18.sp,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankBadge(int rank) {
    if (rank == 1) {
      return Container(
        width: 32.w,
        height: 32.w,
        alignment: Alignment.center,
        child: Icon(
          Icons.emoji_events_rounded,
          color: const Color(0xFFFFD700), // Gold Trophy
          size: 22.sp,
        ),
      );
    } else if (rank == 2) {
      return Container(
        width: 32.w,
        height: 32.w,
        alignment: Alignment.center,
        child: Icon(
          Icons.workspace_premium_rounded,
          color: const Color(0xFFBDC3C7), // Silver Medal
          size: 22.sp,
        ),
      );
    } else if (rank == 3) {
      return Container(
        width: 32.w,
        height: 32.w,
        alignment: Alignment.center,
        child: Icon(
          Icons.military_tech_rounded,
          color: const Color(0xFFCD7F32), // Bronze Medal Ribbon
          size: 22.sp,
        ),
      );
    } else {
      return Container(
        width: 32.w,
        height: 32.w,
        alignment: Alignment.center,
        child: Text(
          '#$rank',
          style: GoogleFonts.inter(
            color: Colors.white.withOpacity(0.6),
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }
  }

  Widget _buildAvatar(String assetPath) {
    return Container(
      width: 42.w,
      height: 42.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1.w,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(21.r),
        child: Image.asset(
          assetPath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: const Color(0xFF1E2830),
              alignment: Alignment.center,
              child: Icon(
                Icons.person,
                color: Colors.white.withOpacity(0.5),
                size: 20.sp,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white.withOpacity(0.4),
            fontSize: 11.sp,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ── Country Filter Dialog Popup ──────────────────────────────────────────────
class _CountryFilterDialog extends StatefulWidget {
  final String initialCountry;

  const _CountryFilterDialog({
    required this.initialCountry,
  });

  @override
  State<_CountryFilterDialog> createState() => _CountryFilterDialogState();
}

class _CountryFilterDialogState extends State<_CountryFilterDialog> {
  late String _selected;

  final List<Map<String, String>> _countries = [
    {'name': 'Worldwide', 'flag': '🌍'},
    {'name': 'United State', 'flag': '🇺🇸'},
    {'name': 'India', 'flag': '🇮🇳'},
    {'name': 'Mexico', 'flag': '🇲🇽'},
    {'name': 'Canada', 'flag': '🇨🇦'},
  ];

  @override
  void initState() {
    super.initState();
    _selected = widget.initialCountry;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Container(
        width: 295.w,
        decoration: BoxDecoration(
          color: const Color(0xFF101B20), // Matches core dialog background
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Colors.white.withOpacity(0.04),
            width: 1.w,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header (Title & Close Button) ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Region',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.white.withOpacity(0.7),
                    size: 20.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Country Options
            ..._countries.map((country) {
              final isSelected = _selected == country['name'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selected = country['name']!;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF266FEF).withOpacity(0.15)
                        : const Color(0xFF131E25),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF266FEF)
                          : Colors.transparent,
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        country['flag']!,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          country['name']!,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle_rounded,
                          color: const Color(0xFF266FEF),
                          size: 18.sp,
                        ),
                    ],
                  ),
                ),
              );
            }),

            SizedBox(height: 16.h),

            // Action Row
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 40.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.w,
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context, _selected),
                    child: Container(
                      height: 40.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF266FEF),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Apply',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
