import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SocialMediaPostScreen extends StatefulWidget {
  const SocialMediaPostScreen({super.key});

  @override
  State<SocialMediaPostScreen> createState() => _SocialMediaPostScreenState();
}

class _SocialMediaPostScreenState extends State<SocialMediaPostScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Dummy images to match the design screenshot
  final List<String> _selectedImages = [
    'assets/images/post1.png',
    'assets/images/post2.png',
    'assets/images/post6.png',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF0A1628), Color(0xFF0D1B38), Color(0xFF071020)],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUserRow(),
                        SizedBox(height: 24.h),
                        _buildInputLabel('Title'),
                        SizedBox(height: 8.h),
                        _buildInputField(
                          controller: _titleController,
                          hintText: 'type your title...',
                          maxLines: 1,
                        ),
                        SizedBox(height: 24.h),
                        _buildInputLabel('Description'),
                        SizedBox(height: 8.h),
                        _buildInputField(
                          controller: _descriptionController,
                          hintText: 'type your content...',
                          maxLines: 6,
                          height: 150.h,
                        ),
                        SizedBox(height: 24.h),
                        if (_selectedImages.isNotEmpty)
                          _buildImagePreviewGallery(),
                      ],
                    ),
                  ),
                ),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CustomBackButton(onTap: () => Get.back()),
          ),
          Text(
            'Create post',
            style: TextFontStyle.textStyle16InterW600.copyWith(
              color: Colors.white,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserRow() {
    return Row(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('assets/images/user_img.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          'Ayana Mera',
          style: TextFontStyle.textStyle16InterW600.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () async {
            try {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: ImageSource.camera);
              if (image != null) {
                setState(() {
                  _selectedImages.add(image.path);
                });
              }
            } catch (e) {
              debugPrint('Error picking image from camera: $e');
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Camera not available or permission denied.')),
                );
              }
            }
          },
          child: Icon(
            Icons.camera_alt_outlined,
            color: Colors.white,
            size: 28.sp,
          ),
        ),
        SizedBox(width: 16.w),
        GestureDetector(
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              setState(() {
                _selectedImages.add(image.path);
              });
            }
          },
          child: Icon(Icons.image_outlined, color: Colors.white, size: 28.sp),
        ),
      ],
    );
  }

  Widget _buildInputLabel(String text) {
    return Text(
      text,
      style: TextFontStyle.textStyle14InterW500.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
    double? height,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2C3545), // Dark grey input background
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextFontStyle.textStyle14InterW400.copyWith(
            color: Colors.white.withValues(alpha: 0.4),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
        ),
      ),
    );
  }

  Widget _buildImagePreviewGallery() {
    return SizedBox(
      height: 120.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedImages.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100.w,
            margin: EdgeInsets.only(right: 12.w),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                      image: _selectedImages[index].startsWith('assets/')
                          ? AssetImage(_selectedImages[index]) as ImageProvider
                          : FileImage(File(_selectedImages[index])),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {},
                    ),
                  ),
                ),
                Positioned(
                  top: 6.h,
                  right: 6.w,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedImages.removeAt(index);
                      });
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.redAccent,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: ElevatedButton(
        onPressed: () {
          // Handle post submission
          Get.back();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.c2196F3,
          minimumSize: Size(double.infinity, 56.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          elevation: 0,
        ),
        child: Text(
          'Post',
          style: TextFontStyle.textStyle16InterW600.copyWith(
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
