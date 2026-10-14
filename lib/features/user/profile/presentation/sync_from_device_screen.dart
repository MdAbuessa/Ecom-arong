// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SyncFromDeviceScreen extends StatefulWidget {
  const SyncFromDeviceScreen({super.key});

  @override
  State<SyncFromDeviceScreen> createState() => _SyncFromDeviceScreenState();
}

class _SyncFromDeviceScreenState extends State<SyncFromDeviceScreen> {
  int _selectedDeviceIndex = 5; // Default selection highlighted on "Strava" (index 5) matching the screenshot

  final List<String> _devices = [
    'Garmin',
    'Apple Watch',
    'Fitbit',
    'Samsung Health / Watch',
    'Google Fit',
    'Strava',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115), // Matching deep dark background
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                const CustomBackButton(),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 40.w), // Offset the back button space to center title
                      child: Text(
                        'Sync from Device',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12.h),

              // ── Hero Device Icon ──
              Container(
                width: 76.w,
                height: 76.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF266FEF),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.smartphone_rounded,
                  color: Colors.white,
                  size: 36.sp,
                ),
              ),
              SizedBox(height: 20.h),

              // ── Title & Subtitle ──
              Text(
                'Connect Your Device',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  'Sync activities from your fitness tracker or smartwatch',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 28.h),

              // ── Platforms list ──
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _devices.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final deviceName = _devices[index];
                  final isSelected = _selectedDeviceIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDeviceIndex = index;
                      });
                    },
                    child: Container(
                      height: 46.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF101B20), // Dark card bg color
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF266FEF)
                              : Colors.white.withOpacity(0.04),
                          width: isSelected ? 1.5.w : 1.w,
                        ),
                      ),
                      child: Text(
                        deviceName,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 24.h),

              // ── Sync Now Bottom Button ──
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF101B20),
                      content: Text(
                        'Device sync started successfully!',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  );
                  Navigator.pop(context); // Go back
                },
                child: Container(
                  width: double.infinity,
                  height: 48.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF266FEF),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Text(
                    'Sync Now',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
