import 'dart:io';

import 'package:aarongonzales01/features/user/profile/presentation/edit_profile_screen.dart';
import 'package:aarongonzales01/features/user/profile/widgets/dob_age_field.dart';
import 'package:aarongonzales01/features/user/profile/widgets/image_source_bottom_sheet.dart';
import 'package:aarongonzales01/features/user/profile/widgets/personal_information_field.dart';
import 'package:aarongonzales01/features/user/profile/widgets/personal_information_header.dart';
import 'package:aarongonzales01/features/user/profile/widgets/profile_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:aarongonzales01/networks/api_acess.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen>
    with WidgetsBindingObserver {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _locationController;
  late final TextEditingController _genderController;
  late final TextEditingController _dobController;

  File? _selectedImage;
  String? _avatarUrl;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _nameController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _phoneController = TextEditingController(text: "");
    _locationController = TextEditingController(text: "");
    _genderController = TextEditingController(text: "");
    _dobController = TextEditingController(text: "");
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final info = getUserInfoRxObj.dataFetcher.valueOrNull ?? await getUserInfoRxObj.fetchUserInfo();
    if (info != null && mounted) {
      final user = info.data?.user;
      setState(() {
        _nameController.text = user?.firstName ?? "";
        _emailController.text = user?.email ?? "";
        _phoneController.text = user?.phone ?? "";
        _locationController.text = user?.location ?? "";
        _genderController.text = user?.gender ?? "";
        _avatarUrl = user?.avatar;
        final dob = user?.dateOfBirth;
        if (dob != null) {
          _dobController.text = DateFormat("d MMM yyyy").format(dob);
        } else {
          _dobController.text = "";
        }
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Rebuild the widget when returning from the native camera UI
    // to prevent the white screen that occurs when Flutter's engine resumes.
    if (state == AppLifecycleState.resumed && mounted) {
      setState(() {});
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source, imageQuality: 85);

    if (picked != null) {
      setState(() => _selectedImage = File(picked.path));
    }
  }

  void _showImageSourceSheet() {
    showImageSourceBottomSheet(context: context, onSourceSelected: _pickImage);
  }

  Future<void> _updateProfile() async {
    final result = await Navigator.push<Map<String, String>>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          currentName: _nameController.text,
          currentEmail: _emailController.text,
          currentPhone: _phoneController.text,
          currentLocation: _locationController.text,
          currentGender: _genderController.text,
          currentDob: _dobController.text,
          currentAvatar: _avatarUrl,
        ),
      ),
    );

    if (result != null) {
      await _loadUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PersonalInformationHeader(),
              SizedBox(height: 24.h),

              ProfileAvatarWidget(
                selectedImage: _selectedImage,
                onEditTap: _showImageSourceSheet,
                imageUrl: _avatarUrl,
                showEditButton: false,
              ),
              SizedBox(height: 24.h),

              PersonalInformationField(
                label: "Full Name",
                controller: _nameController,
              ),
              PersonalInformationField(
                label: "Email address",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              PersonalInformationField(
                label: "Phone number",
                controller: _phoneController,
                keyboardType: TextInputType.phone,
              ),
              PersonalInformationField(
                label: "Location",
                controller: _locationController,
              ),
              PersonalInformationField(
                label: "Gender",
                controller: _genderController,
              ),
              DobAgeField(controller: _dobController),

              SizedBox(height: 16.h),

              GestureDetector(
                onTap: _updateProfile,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF266FEF),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
