import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isDropdown;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final bool isPassword;

  const EditProfileField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.isDropdown = false,
    this.onTap,
    this.prefixIcon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextFontStyle.textStyle14InterW500.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            absorbing: isDropdown,
            child: CustomTextfieldWidget(
              hintText: hintText,
              controller: controller, 
              prefixIcon: prefixIcon,
              isPassword: isPassword,
              suffixIcon: isDropdown
                  ? Icon(Icons.keyboard_arrow_down, color: Colors.white54)
                  : null,
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
