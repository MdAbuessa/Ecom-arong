import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum RacerStatus { notRecorded, finished, dnf, dns }

class RacerGridCard extends StatelessWidget {
  final String bib;
  final String name;
  final RacerStatus status;
  final VoidCallback? onTap;
  final bool showBib;

  const RacerGridCard({
    super.key,
    required this.bib,
    required this.name,
    required this.status,
    this.onTap,
    this.showBib = true,
  });

  Color _getBackgroundColor() {
    switch (status) {
      case RacerStatus.notRecorded:
        return const Color(0xFF2A2E3D); // Dark grey
      case RacerStatus.finished:
        return const Color(0xFF386927); // Green
      case RacerStatus.dnf:
        return const Color(0xFF504521); // Brown/Yellow
      case RacerStatus.dns:
        return const Color(0xFF28233B); // Purple
    }
  }

  Widget? _getIcon() {
    switch (status) {
      case RacerStatus.notRecorded:
        return null;
      case RacerStatus.finished:
        return _buildIcon(Icons.check, Color(0xFF81C784)); // Lighter green bg
      case RacerStatus.dnf:
        return _buildIcon(Icons.priority_high, Color(0xFFFFD54F)); // Yellow bg
      case RacerStatus.dns:
        return _buildIcon(Icons.close, Color(0xFFB39DDB)); // Lighter purple bg
    }
  }

  Widget _buildIcon(IconData icon, Color bgColor) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.black, size: 12.sp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: status == RacerStatus.notRecorded
                ? const Color(0xFF4B5563)
                : _getBackgroundColor().withValues(alpha: 0.8),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showBib) ...[
                    Text(
                      bib,
                      textAlign: TextAlign.center,
                      style: TextFontStyle.textStyle16InterW600.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                  ],
                  Text(
                    name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextFontStyle.textStyle14InterW400.copyWith(
                      color: Colors.white,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (_getIcon() != null)
              Positioned(top: 6.h, right: 6.w, child: _getIcon()!),
          ],
        ),
      ),
    );
  }
}
