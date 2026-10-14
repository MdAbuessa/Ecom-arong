import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterNowScreen extends StatefulWidget {
  const RegisterNowScreen({super.key});

  @override
  State<RegisterNowScreen> createState() => _RegisterNowScreenState();
}

class _RegisterNowScreenState extends State<RegisterNowScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  String _selectedGender = 'Male';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.c111827,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 16.h),

              /// CUSTOM APP BAR
              Row(
                children: [
                  const CustomBackButton(),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Register now",
                        style: GoogleFonts.inter(
                          color: const Color(0xFF2196F3),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 44.w), // To balance the back button
                ],
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 32.h),

                        /// FULL NAME
                        _buildLabel("Full Name"),
                        SizedBox(height: 8.h),
                        _buildTextField(
                          controller: _fullNameController,
                          hint: "Enter your full name",
                        ),

                        SizedBox(height: 24.h),

                        /// EMAIL ADDRESS
                        _buildLabel("Email Address"),
                        SizedBox(height: 8.h),
                        _buildTextField(
                          controller: _emailController,
                          hint: "Enter your mail",
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: 24.h),

                        /// PHONE NUMBER
                        _buildLabel("Phone Number"),
                        SizedBox(height: 8.h),
                        _buildTextField(
                          controller: _phoneController,
                          hint: "Enter your number",
                          keyboardType: TextInputType.phone,
                        ),

                        SizedBox(height: 24.h),

                        /// GENDER
                        _buildLabel("Gender"),
                        SizedBox(height: 8.h),
                        _buildDropdownField(),

                        SizedBox(height: 24.h),

                        /// DATE OF BIRTH
                        _buildLabel("Date of Birth"),
                        SizedBox(height: 8.h),
                        _buildTextField(
                          controller: _dobController,
                          hint: "DD/MM/YYYY",
                          readOnly: true,
                          onTap: () => _selectDate(context),
                          suffixIcon: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.white38,
                            size: 20.sp,
                          ),
                        ),

                        SizedBox(height: 48.h),

                        /// CHECK OUT BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              NavigationService.navigateTo(
                                Routes.checkoutScreen,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2196F3),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              "Check out",
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Colors.white38, fontSize: 14.sp),
        filled: true,
        fillColor: const Color(0xFF1F2937).withOpacity(0.5),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.white24, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Color(0xFF2196F3), width: 1),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937).withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedGender,
          dropdownColor: const Color(0xFF111827),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          isExpanded: true,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
          items: <String>['Male', 'Female', 'Other']
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
              .toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedGender = newValue;
              });
            }
          },
        ),
      ),
    );
  }
}
