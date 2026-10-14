import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/create_club_helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialFeedPart extends StatelessWidget {
  final TextEditingController postTitleController;
  final TextEditingController postDateController;
  final TextEditingController externalLinkController;
  final TextEditingController postContentController;

  const SocialFeedPart({
    super.key,
    required this.postTitleController,
    required this.postDateController,
    required this.externalLinkController,
    required this.postContentController,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColor.c2196F3,
              onPrimary: Colors.white,
              surface: Color(0xFF0F1B2A),
              onSurface: Colors.white,
            ),
            dialogTheme: DialogThemeData(backgroundColor: Color(0xFF061115)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final String formatted =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      postDateController.text = formatted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStepper(3),
          buildLabel("Post Title"),
          CustomTextfieldWidget(
            hintText: "Enter post title",
            controller: postTitleController,
          ),
          SizedBox(height: 16.h),
          buildLabel("Post Date"),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              absorbing: true,
              child: CustomTextfieldWidget(
                hintText: "DD/MM/YYYY",
                controller: postDateController,
                suffixIcon: Icon(
                  Icons.calendar_month_outlined,
                  color: AppColor.c797A7C,
                  size: 20.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          buildLabel("External Link"),
          CustomTextfieldWidget(
            hintText: "Enter location", // Matching screenshot exactly
            controller: externalLinkController,
          ),
          SizedBox(height: 16.h),
          buildLabel("Post Content"),
          CustomTextfieldWidget(
            hintText: "Enter the content",
            controller: postContentController,
            maxLines: 4,
          ),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }
}
