import 'package:aarongonzales01/features/organizer/community/widgets/create_club_helper_widgets.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatsMetricsPart extends StatelessWidget {
  final int membersCount;
  final int postCount;
  final int activeChallenges;
  final int totalChallenges;
  final ValueChanged<int> onMembersCountChanged;
  final ValueChanged<int> onPostCountChanged;
  final ValueChanged<int> onActiveChallengesChanged;
  final ValueChanged<int> onTotalChallengesChanged;

  const StatsMetricsPart({
    super.key,
    required this.membersCount,
    required this.postCount,
    required this.activeChallenges,
    required this.totalChallenges,
    required this.onMembersCountChanged,
    required this.onPostCountChanged,
    required this.onActiveChallengesChanged,
    required this.onTotalChallengesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStepper(1),
          _buildNumericSpinner(
            "Members Count",
            membersCount,
            onMembersCountChanged,
          ),
          SizedBox(height: 16.h),
          _buildNumericSpinner("Post Count", postCount, onPostCountChanged),
          SizedBox(height: 16.h),
          _buildNumericSpinner(
            "Active Challenges",
            activeChallenges,
            onActiveChallengesChanged,
          ),
          SizedBox(height: 16.h),
          _buildNumericSpinner(
            "Total Challenges",
            totalChallenges,
            onTotalChallengesChanged,
          ),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }

  Widget _buildNumericSpinner(
    String label,
    int value,
    ValueChanged<int> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLabel(label),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$value",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => onChanged(value + 1),
                    child: const Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                  UIHelper.verticalSpace(6.h),
                  GestureDetector(
                    onTap: () {
                      if (value > 0) {
                        onChanged(value - 1);
                      }
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
