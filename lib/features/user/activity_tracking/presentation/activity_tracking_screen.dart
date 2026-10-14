import 'dart:async';
import 'dart:math' as math;
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/features/user/activity_history/presentation/activity_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ActivityTrackingScreen extends StatefulWidget {
  const ActivityTrackingScreen({super.key});

  @override
  State<ActivityTrackingScreen> createState() => _ActivityTrackingScreenState();
}

enum TrackingStatus { initial, tracking, paused }

class _ActivityTrackingScreenState extends State<ActivityTrackingScreen> {
  // ── tab state ──────────────────────────────────────────────────────────
  int _selectedTab = 0; // 0=Walk 1=Run 2=Hike
  final List<String> _tabs = ['Walk', 'Run', 'Hike'];

  // ── stats ──────────────────────────────────────────────────────────────
  int _calories = 0;
  double _miles = 0.0;
  int _steps = 0;
  final int _stepGoal = 6000;

  // ── timer & tracking state ─────────────────────────────────────────────
  Timer? _timer;
  int _elapsedSeconds = 0;
  TrackingStatus _trackingStatus = TrackingStatus.initial;

  // ── date ───────────────────────────────────────────────────────────────
  DateTime _selectedDate = DateTime(2026, 2, 8);

  // ── distance unit toggle ───────────────────────────────────────────────
  bool _showKm = false; // false = Miles

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _elapsedSeconds++;
          // Simulate tracking updates
          if (_elapsedSeconds % 2 == 0) _steps += 3;
          if (_elapsedSeconds % 4 == 0) _calories++;
          if (_elapsedSeconds % 10 == 0) _miles += 0.01;
        });
      }
    });
    setState(() => _trackingStatus = TrackingStatus.tracking);
  }

  void _pauseTimer() {
    _timer?.cancel();
    setState(() => _trackingStatus = TrackingStatus.paused);
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _trackingStatus = TrackingStatus.initial;
      _elapsedSeconds = 0;
      _steps = 0;
      _miles = 0.0;
      _calories = 0;
    });
  }

  String _formatTime(int totalSeconds) {
    final h = totalSeconds ~/ 3600;
    final m = (totalSeconds % 3600) ~/ 60;
    final s = totalSeconds % 60;
    return '${h}h ${m}m ${s}s';
  }

  String _formatDate(DateTime d) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final year = d.year.toString().substring(2);
    return '${months[d.month - 1]} ${d.day.toString().padLeft(2, '0')}, $year';
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (ctx, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColor.c2196F3,
            onPrimary: Colors.white,
            surface: Color(0xFF1A2540),
            onSurface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _stepGoal > 0 ? (_steps / _stepGoal).clamp(0.0, 1.0) : 0.0;
    final completedPct = (progress * 100).toStringAsFixed(0);
    final distanceLabel = _showKm ? 'Km' : 'Miles';
    final distanceValue = _showKm ? (_miles * 1.60934) : _miles;

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
                // ── APP BAR ────────────────────────────────────────────
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
                        'Activity Tracking',
                        style: TextFontStyle.textStyle16InterW600.copyWith(
                          fontSize: 18.sp,
                          color: AppColor.cFFFFFF,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 14.h),

                // ── TAB SELECTOR ───────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: List.generate(_tabs.length, (i) {
                      final isSelected = _selectedTab == i;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedTab = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.only(right: 10.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColor.c2196F3
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            _tabs[i],
                            style: TextFontStyle.textStyle14InterW500.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.6),
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(height: 24.h),

                // ── STATS ROW ──────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatColumn(label: 'Calories', value: '$_calories'),
                      _StatColumn(
                        label: 'Active Time',
                        value: _formatTime(_elapsedSeconds),
                        valueSize: 22.sp,
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _showKm = !_showKm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _StatColumn(
                              label: distanceLabel,
                              value: distanceValue.toStringAsFixed(1),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 36.h),

                // ── CIRCULAR DIAL + HISTORY ────────────────────────────
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left spacer — mirrors the History button width so the
                      // dial stays visually centred on the screen.
                      SizedBox(width: 56.w),

                      // ── Dial ─────────────────────────────────────────────
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: 260.w,
                            height: 260.w,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Tick-mark ring
                                CustomPaint(
                                  size: Size(260.w, 260.w),
                                  painter: _DialPainter(progress: progress),
                                ),

                                // Inner content
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Date row
                                    GestureDetector(
                                      onTap: _pickDate,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            _formatDate(_selectedDate),
                                            style: TextFontStyle
                                                .textStyle14InterW500
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Icon(
                                            Icons.calendar_month_outlined,
                                            color: AppColor.c2196F3,
                                            size: 18.sp,
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 10.h),

                                    // Step count
                                    Text(
                                      '$_steps',
                                      style: TextFontStyle.textStyle16InterW600
                                          .copyWith(
                                            fontSize: 52.sp,
                                            color: AppColor.c2196F3,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),

                                    SizedBox(height: 8.h),

                                    // Step goal label
                                    Text(
                                      'Step Goal: $_stepGoal',
                                      style: TextFontStyle.textStyle16InterW600
                                          .copyWith(
                                            fontSize: 16.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                    ),

                                    SizedBox(height: 4.h),

                                    // Percentage
                                    Text(
                                      '$completedPct% Completed',
                                      style: TextFontStyle.textStyle14InterW400
                                          .copyWith(
                                            color: Colors.white.withValues(
                                              alpha: 0.55,
                                            ),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // ── History button — right edge ───────────────────────
                      SizedBox(
                        width: 56.w,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: GestureDetector(
                              onTap: () {
                                // TODO: navigate to history screen
                                Get.to(() => const ActivityHistoryScreen());
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.menu,
                                    color: Colors.white,
                                    size: 22.sp,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'History',
                                    style: TextFontStyle.textStyle14InterW400
                                        .copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.7,
                                          ),
                                          fontSize: 12.sp,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── TRACKING CONTROLS ──────────────────────────────────
                _buildTrackingControls(),

                SizedBox(height: 15.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrackingControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Pause / Resume Button
        GestureDetector(
          onTap: () {
            if (_trackingStatus == TrackingStatus.tracking) {
              _pauseTimer();
            } else {
              _startTimer();
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1A2540),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              children: [
                Icon(
                  _trackingStatus == TrackingStatus.tracking
                      ? Icons.pause
                      : Icons.play_arrow,
                  color: Colors.white,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  _trackingStatus == TrackingStatus.tracking
                      ? 'Pause'
                      : 'Resume',
                  style: TextFontStyle.textStyle16InterW600.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 16.w),
        // Stop Button
        GestureDetector(
          onTap: _stopTimer,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFF5252), // Red accent
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              children: [
                Icon(Icons.stop, color: Colors.white, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Stop',
                  style: TextFontStyle.textStyle16InterW600.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Stat column helper ────────────────────────────────────────────────────────

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  final double? valueSize;

  const _StatColumn({required this.label, required this.value, this.valueSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextFontStyle.textStyle14InterW400.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextFontStyle.textStyle16InterW600.copyWith(
            fontSize: valueSize ?? 26.sp,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ── Circular dial painter ─────────────────────────────────────────────────────

class _DialPainter extends CustomPainter {
  final double progress;
  static const int _tickCount = 60;

  const _DialPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    for (int i = 0; i < _tickCount; i++) {
      final angle = (i / _tickCount) * 2 * math.pi - math.pi / 2;
      final isMajor = i % 5 == 0;

      final tickLength = isMajor ? 14.0 : 8.0;
      final tickWidth = isMajor ? 2.5 : 1.5;

      final isFilled = (i / _tickCount) <= progress;

      final paint = Paint()
        ..color = isFilled
            ? const Color(0xFF2196F3)
            : Colors.white.withValues(alpha: isMajor ? 0.45 : 0.2)
        ..strokeWidth = tickWidth
        ..strokeCap = StrokeCap.round;

      final outerPoint = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      final innerPoint = Offset(
        center.dx + (radius - tickLength) * math.cos(angle),
        center.dy + (radius - tickLength) * math.sin(angle),
      );

      canvas.drawLine(innerPoint, outerPoint, paint);
    }
  }

  @override
  bool shouldRepaint(_DialPainter old) => old.progress != progress;
}
