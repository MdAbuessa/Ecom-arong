import 'dart:io';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/assets_helper/app_images.dart';
import 'package:aarongonzales01/common_widgets/custom_save_button.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/edit_profile_field.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/image_source_sheet.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _orgController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with dummy data
    // _nameController.text = "Helal clubr";
    // _emailController.text = "aarong@runorganizer.com";
    // _phoneController.text = "+1(555) 123-4567";
    // _orgController.text = "City Runners Organization";
    // _locationController.text = "New York, USA";
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          ImageSourceSheet(onSourceSelected: (source) => _pickImage(source)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        title: "Personal Information",
        onBackTap: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            // Profile Image Picker
            Center(
              child: GestureDetector(
                onTap: () => _showImageSourceDialog(context),
                child: Stack(
                  children: [
                    Container(
                      height: 110.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white24, width: 2),
                      ),
                      child: ClipOval(
                        child: _selectedImage != null
                            ? Image.file(_selectedImage!, fit: BoxFit.cover)
                            : Image.asset(
                                AppImages.organizer_img,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Container(
                      height: 110.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Update photo",
                            style: TextFontStyle.textStyle14InterW500.copyWith(
                              color: AppColor.cFFFFFF,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.h),

            EditProfileField(
              label: "Full Name",
              hintText: "Enter your full name",
              controller: _nameController,
            ),
            EditProfileField(
              label: "Email address",
              hintText: "Enter your email",
              controller: _emailController,
            ),
            EditProfileField(
              label: "Phone number",
              hintText: "+1(555) 123-4567",
              controller: _phoneController,
            ),
            EditProfileField(
              label: "Organization",
              hintText: "Enter organization name",
              controller: _orgController,
            ),
            EditProfileField(
              label: "Location",
              hintText: "Select your location",
              controller: _locationController,
              // isDropdown: true,
              onTap: () {},
              prefixIcon: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(AppImages.location, color: AppColor.cFFFFFF),
              ),
            ),
            SizedBox(height: 20.h),
            CustomSaveButton(
              btnText: 'Save Changes',
              onCall: () {
                // NavigationService.goBack;
              },
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
