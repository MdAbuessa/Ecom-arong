import 'package:flutter/material.dart';
import 'package:aarongonzales01/assets_helper/app_colors.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const CustomSearchField({
    super.key,
    this.controller,
    this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(color: AppColor.cFFFFFF),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:   TextStyle(color: AppColor.c797A7C, fontSize: 16),
        prefixIcon:   Icon(Icons.search, color: AppColor.c797A7C, size: 22),
        filled: true,
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,  
          horizontal: 20.0,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Color(0xFF183B56), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: AppColor.c1570EF, width: 1.5),
        ),
      ),
    );
  }
}
