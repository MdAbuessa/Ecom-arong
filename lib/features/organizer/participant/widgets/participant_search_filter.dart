import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aarongonzales01/features/organizer/home/widgets/custom_search_field.dart';

class ParticipantSearchFilter extends StatelessWidget {
  const ParticipantSearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: CustomSearchField(hintText: "Search members")),
        UIHelper.horizontalSpace(8.w),
        CircleAvatar(
          radius: 24.r,
          backgroundColor: Color(0xFF1E2E3D),
          child: Icon(Icons.tune_rounded, color: Colors.white, size: 22.sp),
        ),
      ],
    );
  }
}
