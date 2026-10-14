// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Summer5kChallengeScreen extends StatefulWidget {
  final String title;

  const Summer5kChallengeScreen({
    super.key,
    this.title = "Summer 5K Challenge",
  });

  @override
  State<Summer5kChallengeScreen> createState() => _Summer5kChallengeScreenState();
}

class _Summer5kChallengeScreenState extends State<Summer5kChallengeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  bool _showAll = false;
  final Set<int> _expandedIndices = {}; // Track expanded detail cards

  // Filter States
  String _selectedGender = "All"; // Default to "All"
  Map<String, bool> _selectedAgeGroups = {
    "Under 18": false,
    "18-29": false,
    "30-39": false,
    "40-49": false,
    "50+": false,
  };

  // List of participants in the leaderboard
  final List<Map<String, dynamic>> _participants = [
    {
      'rank': 1,
      'name': 'Alex Cooper',
      'miles': '5 miles',
      'time': '35 Min 20 Sec',
      'avatar': 'assets/images/person.png',
      'pace': '7:04 / mile',
      'calories': '320 kcal',
      'gender': 'Female',
      'age': 25, // Age group: 18-29
    },
    {
      'rank': 2,
      'name': 'Jordan Lee',
      'miles': '4.8 miles',
      'time': '32 Min 10 Sec',
      'avatar': 'assets/images/person2.png',
      'pace': '6:42 / mile',
      'calories': '305 kcal',
      'gender': 'Male',
      'age': 32, // Age group: 30-39
    },
    {
      'rank': 3,
      'name': 'Taylor Brown',
      'miles': '4.5 miles',
      'time': '30 Min 46 Sec',
      'avatar': 'assets/images/person3.png',
      'pace': '6:50 / mile',
      'calories': '290 kcal',
      'gender': 'Female',
      'age': 21, // Age group: 18-29
    },
    {
      'rank': 4,
      'name': 'Morgan Freeman',
      'miles': '4.2 miles',
      'time': '28 Min 15 Sec',
      'avatar': 'assets/images/user_img.png',
      'pace': '6:43 / mile',
      'calories': '270 kcal',
      'gender': 'Male',
      'age': 55, // Age group: 50+
    },
    {
      'rank': 5,
      'name': 'Sam Smith',
      'miles': '3.8 miles',
      'time': '24 Min 10 Sec',
      'avatar': 'assets/images/person.png',
      'pace': '6:21 / mile',
      'calories': '245 kcal',
      'gender': 'Male',
      'age': 45, // Age group: 40-49
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filter participants based on search input query and active filter options
    final filtered = _participants.where((p) {
      // 1. Search Query Filter
      final matchesSearch = p['name'].toLowerCase().contains(_searchQuery.toLowerCase());
      if (!matchesSearch) return false;

      // 2. Gender Filter
      if (_selectedGender != "All") {
        if (p['gender'] != _selectedGender) return false;
      }

      // 3. Age Groups Filter
      final activeAgeFilters = _selectedAgeGroups.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();
      if (activeAgeFilters.isNotEmpty) {
        final age = p['age'] as int;
        bool ageMatch = false;
        for (final group in activeAgeFilters) {
          if (group == "Under 18" && age < 18) ageMatch = true;
          if (group == "18-29" && age >= 18 && age <= 29) ageMatch = true;
          if (group == "30-39" && age >= 30 && age <= 39) ageMatch = true;
          if (group == "40-49" && age >= 40 && age <= 49) ageMatch = true;
          if (group == "50+" && age >= 50) ageMatch = true;
        }
        if (!ageMatch) return false;
      }

      return true;
    }).toList();

    // Determine how many items to display based on the "View All" state
    final displayedCount = _showAll ? filtered.length : (filtered.length > 3 ? 3 : filtered.length);

    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.65), // Semi-transparent overlay background
      body: Center(
        child: Container(
          width: 335.w,
          constraints: BoxConstraints(maxHeight: 520.h),
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
                    widget.title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white.withOpacity(0.7),
                      size: 22.sp,
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
                                hintText: 'Search by participant name...',
                                hintStyle: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.4),
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

                  // Filter Tuning Icon (Triggers Filter Options overlay)
                  GestureDetector(
                    onTap: () async {
                      final result = await showDialog<Map<String, dynamic>>(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => FilterOptionsDialog(
                          initialGender: _selectedGender,
                          initialAgeGroups: _selectedAgeGroups,
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          _selectedGender = result['gender'];
                          _selectedAgeGroups = Map<String, bool>.from(result['ageGroups']);
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),

              // ── Participant List ────────────────────────────────
              Flexible(
                child: displayedCount == 0
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Text(
                          'No participants match filters',
                          style: GoogleFonts.inter(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 13.sp,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.only(top: 12.h),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: displayedCount,
                        separatorBuilder: (context, index) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final participant = filtered[index];
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
                            child: Container(
                              padding: EdgeInsets.all(12.r),
                              decoration: BoxDecoration(
                                color: const Color(0xFF131E25), // Row container bg
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      // Rank Badge (Gold, Silver, Bronze)
                                      _buildRankBadge(participant['rank']),
                                      SizedBox(width: 12.w),

                                      // Avatar Profile Image
                                      _buildAvatar(participant['avatar']),
                                      SizedBox(width: 12.w),

                                      // Participant Info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              participant['name'],
                                              style: GoogleFonts.inter(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              participant['miles'],
                                              style: GoogleFonts.inter(
                                                color: Colors.white.withOpacity(0.55),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Time and Expand Indicator
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Icon(
                                            isExpanded
                                                ? Icons.keyboard_arrow_up_rounded
                                                : Icons.keyboard_arrow_down_rounded,
                                            color: Colors.white.withOpacity(0.7),
                                            size: 20.sp,
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(
                                            participant['time'],
                                            style: GoogleFonts.inter(
                                              color: Colors.white.withOpacity(0.55),
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  // Expandable detailed information (Premium polish)
                                  if (isExpanded) ...[
                                    Padding(
                                      padding: EdgeInsets.only(top: 12.h, left: 4.w, right: 4.w),
                                      child: Divider(
                                        color: Colors.white.withOpacity(0.06),
                                        thickness: 1.h,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.h, left: 4.w, right: 4.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          _buildDetailStat("Pace", participant['pace']),
                                          _buildDetailStat("Energy", participant['calories']),
                                          _buildDetailStat("Gender", participant['gender']),
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
              if (filtered.length > 3)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showAll = !_showAll;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        _showAll ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                        color: const Color(0xFF266FEF),
                        size: 18.sp,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankBadge(int rank) {
    Color badgeColor;
    String rankText;
    if (rank == 1) {
      badgeColor = const Color(0xFFFFB300); // Gold
      rankText = "#1st";
    } else if (rank == 2) {
      badgeColor = const Color(0xFFC0C0C0); // Silver
      rankText = "#2nd";
    } else if (rank == 3) {
      badgeColor = const Color(0xFFCD7F32); // Bronze
      rankText = "#3rd";
    } else {
      badgeColor = Colors.white.withOpacity(0.3);
      rankText = "#${rank}th";
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: badgeColor.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: badgeColor, width: 1.5.w),
          ),
          alignment: Alignment.center,
          child: Text(
            '$rank',
            style: GoogleFonts.inter(
              color: badgeColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          rankText,
          style: GoogleFonts.inter(
            color: Colors.white.withOpacity(0.55),
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
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

// ── Filter Options Dialog Overlay ──────────────────────────────────────────
class FilterOptionsDialog extends StatefulWidget {
  final String initialGender;
  final Map<String, bool> initialAgeGroups;

  const FilterOptionsDialog({
    super.key,
    required this.initialGender,
    required this.initialAgeGroups,
  });

  @override
  State<FilterOptionsDialog> createState() => _FilterOptionsDialogState();
}

class _FilterOptionsDialogState extends State<FilterOptionsDialog> {
  late String _tempGender;
  late Map<String, bool> _tempAgeGroups;

  @override
  void initState() {
    super.initState();
    _tempGender = widget.initialGender;
    _tempAgeGroups = Map<String, bool>.from(widget.initialAgeGroups);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Container(
        width: 295.w,
        decoration: BoxDecoration(
          color: const Color(0xFF101B20), // Matching dialog background color
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
                  'Filter Options',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
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
            SizedBox(height: 20.h),

            // ── Gender Section ──
            Text(
              'Gender',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            _buildGenderOption("All"),
            SizedBox(height: 10.h),
            _buildGenderOption("Male"),
            SizedBox(height: 10.h),
            _buildGenderOption("Female"),
            SizedBox(height: 20.h),

            // ── Age Groups Section ──
            Text(
              'Age Groups',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            _buildAgeCheckbox("Under 18"),
            SizedBox(height: 10.h),
            _buildAgeCheckbox("18-29"),
            SizedBox(height: 10.h),
            _buildAgeCheckbox("30-39"),
            SizedBox(height: 10.h),
            _buildAgeCheckbox("40-49"),
            SizedBox(height: 10.h),
            _buildAgeCheckbox("50+"),
            SizedBox(height: 28.h),

            // ── Action Buttons ──
            Row(
              children: [
                // Clear All Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _tempGender = "All";
                        _tempAgeGroups.updateAll((key, value) => false);
                      });
                    },
                    child: Container(
                      height: 40.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: const Color(0xFF266FEF),
                          width: 1.5.w,
                        ),
                      ),
                      child: Text(
                        'Clear All',
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

                // Apply Filters Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context, {
                        'gender': _tempGender,
                        'ageGroups': _tempAgeGroups,
                      });
                    },
                    child: Container(
                      height: 40.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF266FEF),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Apply Filters',
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

  Widget _buildGenderOption(String gender) {
    final isSelected = _tempGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          _tempGender = gender;
        });
      },
      child: Row(
        children: [
          Container(
            width: 18.w,
            height: 18.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? Colors.white.withOpacity(0.85) : Colors.transparent,
              border: isSelected
                  ? null
                  : Border.all(
                      color: Colors.white.withOpacity(0.6),
                      width: 1.5.w,
                    ),
            ),
          ),
          SizedBox(width: 12.w),
          Text(
            gender,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeCheckbox(String ageGroup) {
    final isChecked = _tempAgeGroups[ageGroup] ?? false;
    return GestureDetector(
      onTap: () {
        setState(() {
          _tempAgeGroups[ageGroup] = !isChecked;
        });
      },
      child: Row(
        children: [
          Container(
            width: 18.w,
            height: 18.w,
            decoration: BoxDecoration(
              color: isChecked ? const Color(0xFF266FEF) : Colors.white,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: isChecked
                ? const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 13,
                  )
                : null,
          ),
          SizedBox(width: 12.w),
          Text(
            ageGroup,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.85),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
