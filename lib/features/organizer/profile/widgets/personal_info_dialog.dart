import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoDialog extends StatelessWidget {
  const PersonalInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1E2329),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), 
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bio",
              style: TextFontStyle.textStyle24RobotoW600.copyWith(
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Passionate organizer from NYC focusing on local marathons. Contact for custom events.",
              style: TextFontStyle.textStyle14InterW500.copyWith(
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 24),
            _buildInfoRow(
              Icons.mail_outline,
              "Email",
              "aarong@runorganizer.com",
            ),
            const SizedBox(height: 16),
            _buildInfoRow(Icons.phone_outlined, "Phone", "+1 (555) 123-4567"),
            const SizedBox(height: 16),
            _buildInfoRow(
              Icons.location_on_outlined,
              "Location",
              "New York, USA",
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              Icons.business_outlined,
              "Organization",
              "City Runners Organization",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54, size: 20),
        const SizedBox(width: 12),
        Text(
          label,
          style: TextFontStyle.textStyle14InterW500.copyWith(
            color: Colors.white54,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextFontStyle.textStyle14InterW500,
          ),
        ),
      ],
    );
  }
}
