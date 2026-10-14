import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DobAgeField extends StatelessWidget {
  const DobAgeField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final age = _calculateAge(controller.text);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: _buildField(
            label: "Date of Birth",
            controller: controller,
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 3,
          child: _buildField(
            label: "Age",
            controller: TextEditingController(
              text: "$age yrs",
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required TextAlign textAlign,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          readOnly: true,
          textAlign: textAlign,
          style: GoogleFonts.inter(
            color: Colors.white.withOpacity(0.8),
            fontSize: 15.sp,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF091115),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            enabledBorder: _border(),
            focusedBorder: _border(),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: Colors.white.withOpacity(0.08),
        width: 1.w,
      ),
    );
  }

  int _calculateAge(String dobString) {
    if (dobString.isEmpty) return 0;

    try {
      DateTime dob;

      try {
        dob = DateFormat("d MMM yyyy").parse(dobString);
      } catch (_) {
        dob = DateTime.parse(dobString);
      }

      final today = DateTime.now();
      int age = today.year - dob.year;

      if (today.month < dob.month ||
          (today.month == dob.month && today.day < dob.day)) {
        age--;
      }

      return age < 0 ? 0 : age;
    } catch (_) {
      return 0;
    }
  }
}