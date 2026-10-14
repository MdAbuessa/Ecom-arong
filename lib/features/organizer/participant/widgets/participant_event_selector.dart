import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParticipantEventSelector extends StatelessWidget {
  final String selectedEvent;
  final VoidCallback? onTap;

  const ParticipantEventSelector({
    super.key,
    required this.selectedEvent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Event",
            style: TextFontStyle.textStyle16InterW600.copyWith(
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 8.h),
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "($selectedEvent)",
                  style: TextFontStyle.textStyle14InterW500.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white70,
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
