// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomLogoutWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final Future<void> Function()? onTap;
  const CustomLogoutWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  State<CustomLogoutWidget> createState() => _CustomLogoutWidgetState();
}

class _CustomLogoutWidgetState extends State<CustomLogoutWidget> {
  bool _isLoading = false;

  Future<void> _handleYes() async {
    if (_isLoading || widget.onTap == null) return;
    setState(() => _isLoading = true);
    try {
      await widget.onTap!();
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 28.h),
        decoration: BoxDecoration(
          color: const Color(0xFF101B20),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.white.withOpacity(0.04), width: 1.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Dialog Title ──
            Text(
              widget.title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),

            // ── Subtitle ──
            Text(
              widget.subtitle,
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.55),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 28.h),

            // ── Action Buttons ──
            Row(
              children: [
                // No Button
                Expanded(
                  child: GestureDetector(
                    onTap: _isLoading ? null : () => Navigator.pop(context, false),
                    child: Container(
                      height: 48.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _isLoading
                            ? const Color(0xFF1E2830).withOpacity(0.5)
                            : const Color(0xFF1E2830),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Text(
                        "No",
                        style: GoogleFonts.inter(
                          color: _isLoading
                              ? Colors.white.withOpacity(0.4)
                              : Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14.w),

                // Yes Button
                Expanded(
                  child: GestureDetector(
                    onTap: _handleYes,
                    child: Container(
                      height: 48.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF4949),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              "Yes",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15.sp,
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
