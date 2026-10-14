import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/features/user/activity_history/model/activity_record_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivityHistoryScreen extends StatefulWidget {
  const ActivityHistoryScreen({super.key});

  @override
  State<ActivityHistoryScreen> createState() => _ActivityHistoryScreenState();
}

class _ActivityHistoryScreenState extends State<ActivityHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedFilter;

  // ── Static demo data ──────────────────────────────────────────────────
  final List<_ActivityGroup> _allGroups = const [
    _ActivityGroup(
      label: 'Today',
      records: [
        ActivityRecord(
          typeName: 'Walk',
          icon: Icons.directions_walk_rounded,
          distanceKm: 3.2,
          durationMin: 25,
          calories: 120,
          location: 'San Francisco → USA',
        ),
      ],
    ),
    _ActivityGroup(
      label: 'Yesterday',
      records: [
        ActivityRecord(
          typeName: 'Run',
          icon: Icons.directions_run_rounded,
          distanceKm: 2.1,
          durationMin: 18,
          calories: 120,
          location: 'San Francisco → USA',
        ),
      ],
    ),
    _ActivityGroup(
      label: 'This Week',
      records: [
        ActivityRecord(
          typeName: 'Hike',
          icon: Icons.directions_bike_rounded,
          distanceKm: 10,
          durationMin: 40,
          calories: 300,
          location: 'San Francisco → USA',
        ),
      ],
    ),
  ];

  List<_ActivityGroup> get _filteredGroups {
    return _allGroups
        .map((g) {
          final filteredRecords = g.records.where((r) {
            final matchesSearch =
                _searchQuery.isEmpty ||
                r.typeName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                r.location.toLowerCase().contains(_searchQuery.toLowerCase());
            final matchesFilter =
                _selectedFilter == null ||
                _selectedFilter == 'All' ||
                r.typeName.toLowerCase() == _selectedFilter!.toLowerCase();
            return matchesSearch && matchesFilter;
          }).toList();

          return _ActivityGroup(label: g.label, records: filteredRecords);
        })
        .where((g) => g.records.isNotEmpty)
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groups = _filteredGroups;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0A1628), Color(0xFF0D1B38), Color(0xFF071020)],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // ── APP BAR ──────────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const CustomBackButton(),
                      ),
                      Text(
                        'Activity History',
                        style: TextFontStyle.textStyle16InterW600.copyWith(
                          fontSize: 18.sp,
                          color: AppColor.cFFFFFF,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10.h),

                // ── SEARCH BAR ───────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      // Search field
                      Expanded(
                        child: Container(
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A2540),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: TextFontStyle.textStyle14InterW400.copyWith(
                              color: Colors.white,
                            ),
                            onChanged: (v) =>
                                setState(() => _searchQuery = v.trim()),
                            decoration: InputDecoration(
                              hintText: 'Search activity history',
                              hintStyle: TextFontStyle.textStyle14InterW400
                                  .copyWith(
                                    color: Colors.white.withValues(alpha: 0.4),
                                  ),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Colors.white.withValues(alpha: 0.5),
                                size: 20.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 14.h,
                              ),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10.w),

                      // Filter button
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          setState(() {
                            _selectedFilter = value == 'All' ? null : value;
                          });
                        },
                        color: const Color(0xFF1A2540),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        offset: const Offset(
                          0,
                          56,
                        ), // Adjust to make it appear below
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'All',
                            child: Text(
                              'All Activities',
                              style: TextFontStyle.textStyle14InterW400
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Run',
                            child: Text(
                              'Run',
                              style: TextFontStyle.textStyle14InterW400
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Hike',
                            child: Text(
                              'Hike',
                              style: TextFontStyle.textStyle14InterW400
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Walk',
                            child: Text(
                              'Walk',
                              style: TextFontStyle.textStyle14InterW400
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                        child: Container(
                          width: 48.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: _selectedFilter != null
                                ? AppColor
                                      .c2196F3 // Highlight if active
                                : const Color(0xFF1A2540),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.tune_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // ── LIST ─────────────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Activity groups
                        ...groups.map((group) => _buildGroup(group)),

                        SizedBox(height: 16.h),

                        // Weekly summary card
                        _WeeklySummaryCard(
                          totalKm: 25,
                          hours: 3,
                          minutes: 20,
                          calories: 1200,
                        ),

                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroup(_ActivityGroup group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          group.label,
          style: TextFontStyle.textStyle14InterW500.copyWith(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        ...group.records.map((r) => _ActivityCard(record: r)),
        SizedBox(height: 16.h),
      ],
    );
  }
}

// ── Group data class ──────────────────────────────────────────────────────────

class _ActivityGroup {
  final String label;
  final List<ActivityRecord> records;
  const _ActivityGroup({required this.label, required this.records});
}

// ── Activity card ─────────────────────────────────────────────────────────────

class _ActivityCard extends StatelessWidget {
  final ActivityRecord record;
  const _ActivityCard({required this.record});

  @override
  Widget build(BuildContext context) {
    final dist = record.distanceKm % 1 == 0
        ? '${record.distanceKm.toInt()} km'
        : '${record.distanceKm} km';

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF131E30),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Activity type row ────────────────────────────────────────
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A2B45),
                  shape: BoxShape.circle,
                ),
                child: Icon(record.icon, color: AppColor.c2196F3, size: 22.sp),
              ),
              SizedBox(width: 12.w),
              Text(
                record.typeName,
                style: TextFontStyle.textStyle16InterW600.copyWith(
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // ── Stats row ────────────────────────────────────────────────
          Row(
            children: [
              _StatChip(assetPath: 'assets/images/distance.png', label: dist),
              SizedBox(width: 20.w),
              _StatChip(
                assetPath: 'assets/images/time.png',
                label: '${record.durationMin} min',
              ),
              SizedBox(width: 20.w),
              _StatChip(
                assetPath: 'assets/images/cal.png',
                label: '${record.calories} Cal',
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // ── Location row ─────────────────────────────────────────────
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.white.withValues(alpha: 0.5),
                size: 14.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                record.location,
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Stat chip (icon + label) ──────────────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final String assetPath;
  final String label;
  const _StatChip({required this.assetPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(assetPath, width: 16.w, height: 16.h),
        SizedBox(width: 5.w),
        Text(
          label,
          style: TextFontStyle.textStyle14InterW400.copyWith(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13.sp,
          ),
        ),
      ],
    );
  }
}

// ── Weekly summary card ───────────────────────────────────────────────────────

class _WeeklySummaryCard extends StatelessWidget {
  final double totalKm;
  final int hours;
  final int minutes;
  final int calories;

  const _WeeklySummaryCard({
    required this.totalKm,
    required this.hours,
    required this.minutes,
    required this.calories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF131E30),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Summary',
            style: TextFontStyle.textStyle16InterW600.copyWith(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          _SummaryRow(
            assetPath: 'assets/images/distance.png',
            label: 'Distance: ${totalKm.toInt()} Km',
          ),
          SizedBox(height: 10.h),
          _SummaryRow(
            assetPath: 'assets/images/time.png',
            label: 'Time: ${hours}h ${minutes}m',
          ),
          SizedBox(height: 10.h),
          _SummaryRow(
            assetPath: 'assets/images/cal.png',
            label: 'Calories: ${calories}cal',
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String assetPath;
  final String label;
  const _SummaryRow({required this.assetPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(assetPath, width: 18.sp, height: 18.sp),
        SizedBox(width: 10.w),
        Text(
          label,
          style: TextFontStyle.textStyle14InterW400.copyWith(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
