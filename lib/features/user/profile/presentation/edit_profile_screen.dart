// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentPhone;
  final String currentLocation;
  final String currentGender;
  final String currentDob;
  final String? currentAvatar;

  const EditProfileScreen({
    super.key,
    this.currentName = 'Ayana mera',
    this.currentEmail = 'ayana@gmail.com',
    this.currentPhone = '+1(555) 123-4567',
    this.currentLocation = 'United kingdom',
    this.currentGender = 'Female',
    this.currentDob = '15 Jun 2008',
    this.currentAvatar,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _locationController;
  late final TextEditingController _dobController;

  late String _selectedGender;
  File? _pickedImage;

  final List<String> _genderOptions = ['Select Gender', 'Male', 'Female'];

  Widget _buildAvatarImage() {
    final double size = 108.r;
    if (_pickedImage != null) {
      return Image.file(
        _pickedImage!,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    }
    String? fullImageUrl = widget.currentAvatar;
    if (fullImageUrl != null && fullImageUrl.isNotEmpty) {
      if (!fullImageUrl.startsWith('http')) {
        fullImageUrl =
            "https://admin.racerealm.com/${fullImageUrl.startsWith('/') ? fullImageUrl.substring(1) : fullImageUrl}";
      }
      return CachedNetworkImage(
        imageUrl: fullImageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => Image.asset(
          'assets/images/placeholder.jpg',
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/placeholder.jpg',
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(
      'assets/images/placeholder.jpg',
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _emailController = TextEditingController(text: widget.currentEmail);
    _phoneController = TextEditingController(text: widget.currentPhone);
    _locationController = TextEditingController(text: widget.currentLocation);
    _dobController = TextEditingController(text: widget.currentDob);

    // Normalize selected gender – display labels are 'Male' / 'Female'
    final raw = widget.currentGender.trim().toLowerCase();
    if (raw == 'male') {
      _selectedGender = 'Male';
    } else if (raw == 'female') {
      _selectedGender = 'Female';
    } else {
      _selectedGender = 'Select Gender';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0D1F2D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            _buildPickerOption(
              icon: Icons.photo_library_outlined,
              label: 'Choose from Gallery',
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 85,
                );
                if (image != null)
                  setState(() => _pickedImage = File(image.path));
              },
            ),
            _buildPickerOption(
              icon: Icons.camera_alt_outlined,
              label: 'Take a Photo',
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 85,
                );
                if (image != null)
                  setState(() => _pickedImage = File(image.path));
              },
            ),
            _buildPickerOption(
              icon: Icons.delete_outline,
              label: 'Remove Photo',
              isDestructive: true,
              onTap: () {
                Navigator.pop(context);
                setState(() => _pickedImage = null);
              },
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? const Color(0xFFEF4444) : Colors.white,
        size: 22.sp,
      ),
      title: Text(
        label,
        style: GoogleFonts.inter(
          color: isDestructive ? const Color(0xFFEF4444) : Colors.white,
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  Future<void> _saveChanges() async {
    FocusScope.of(context).unfocus();

    // Format dateOfBirth to yyyy-MM-dd
    String formattedDob = "";
    if (_dobController.text.isNotEmpty) {
      try {
        DateTime parsedDate = DateFormat(
          "d MMM yyyy",
        ).parse(_dobController.text);
        formattedDob = DateFormat("yyyy-MM-dd").format(parsedDate);
      } catch (e) {
        try {
          DateTime parsedDate = DateTime.parse(_dobController.text);
          formattedDob = DateFormat("yyyy-MM-dd").format(parsedDate);
        } catch (_) {}
      }
    }

    final success = await updateProfileRxObj.updateProfileRx(
      firstName: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      location: _locationController.text,
      gender: _selectedGender == 'Select Gender'
          ? ''
          : _selectedGender.toLowerCase(),
      dateOfBirth: formattedDob,
      avatarPath: _pickedImage?.path,
    );

    if (success) {
      // Refresh user details in the app
      await getUserInfoRxObj.fetchUserInfo();

      Navigator.pop(context, {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'location': _locationController.text,
        'gender': _selectedGender == 'Select Gender'
            ? ''
            : _selectedGender.toLowerCase(),
        'dob': _dobController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF061115),
        body: SafeArea(
          child: Column(
            children: [
              // ── Header ──────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomBackButton(),
                    Text(
                      'Personal Information',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 44.w),
                  ],
                ),
              ),

              // ── Scrollable body ──────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 24.h),

                      // ── Avatar with "Update photo" badge ────────────────
                      GestureDetector(
                        onTap: _pickImage,
                        child: SizedBox(
                          width: 120.r,
                          height: 120.r,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Dashed border ring
                              Container(
                                width: 120.r,
                                height: 120.r,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.18),
                                    width: 1.5.w,
                                  ),
                                ),
                              ),
                              // Avatar image
                              CircleAvatar(
                                radius: 54.r,
                                backgroundColor: const Color(0xFF1A2E3B),
                                child: ClipOval(child: _buildAvatarImage()),
                              ),
                              // Dark overlay
                              CircleAvatar(
                                radius: 54.r,
                                backgroundColor: Colors.black.withOpacity(0.45),
                              ),
                              // Camera icon + label
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 22.sp,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Update photo',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 28.h),

                      // ── Form fields ──────────────────────────────────────
                      _buildTextField(
                        label: 'Full Name',
                        controller: _nameController,
                      ),
                      _buildTextField(
                        label: 'Email address',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                      ),
                      _buildTextField(
                        label: 'Phone number',
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      _buildTextField(
                        label: 'Location',
                        controller: _locationController,
                      ),
                      _buildGenderDropdown(),
                      _buildDobAndAgeField(controller: _dobController),

                      SizedBox(height: 20.h),

                      // ── Save Changes button ──────────────────────────────
                      ValueListenableBuilder<bool>(
                        valueListenable: updateProfileRxObj.isLoading,
                        builder: (context, isLoading, child) {
                          return GestureDetector(
                            onTap: isLoading ? null : _saveChanges,
                            child: Container(
                              width: double.infinity,
                              height: 52.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFF266FEF),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: isLoading
                                  ? SizedBox(
                                      height: 24.r,
                                      width: 24.r,
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      'Update',
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Reusable text field ────────────────────────────────────────────────────
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
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
          keyboardType: keyboardType,
          readOnly: readOnly,
          style: GoogleFonts.inter(
            color: readOnly ? Colors.white.withOpacity(0.5) : Colors.white,
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.08),
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF266FEF),
                width: 1.5,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  // ── Gender dropdown ────────────────────────────────────────────────────────
  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          value: _selectedGender,
          dropdownColor: const Color(0xFF0D1F2D),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.white,
          ),
          style: GoogleFonts.inter(
            color: Colors.white,
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
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(0.08),
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF266FEF),
                width: 1.5,
              ),
            ),
          ),
          items: _genderOptions
              .map(
                (g) => DropdownMenuItem<String>(
                  value: g,
                  child: Text(
                    g,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (val) {
            if (val != null) setState(() => _selectedGender = val);
          },
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildDobAndAgeField({required TextEditingController controller}) {
    final age = _calculateAge(controller.text);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date of Birth',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () => _selectDob(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: controller,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF091115),
                      suffixIcon: Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.white.withOpacity(0.4),
                        size: 18.sp,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 14.h,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Colors.white.withOpacity(0.08),
                          width: 1.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: Color(0xFF266FEF),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Age',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: TextEditingController(text: "$age yrs"),
                readOnly: true,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF091115),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.08),
                      width: 1.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Colors.white.withOpacity(0.08),
                      width: 1.w,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _selectDob(BuildContext context) async {
    DateTime initialDate = DateTime(2008, 6, 15);
    if (_dobController.text.isNotEmpty) {
      try {
        initialDate = DateFormat("d MMM yyyy").parse(_dobController.text);
      } catch (_) {}
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF266FEF),
              onPrimary: Colors.white,
              surface: Color(0xFF101B20),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF101B20),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat("d MMM yyyy").format(picked);
      });
    }
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
