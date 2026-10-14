import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:aarongonzales01/common_widgets/custom_save_button.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/create_club_helper_widgets.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/helpers/toast.dart';

class CreateSocialFeedScreen extends StatefulWidget {
  const CreateSocialFeedScreen({super.key});

  @override
  State<CreateSocialFeedScreen> createState() => _CreateSocialFeedScreenState();
}

class _CreateSocialFeedScreenState extends State<CreateSocialFeedScreen> {
  final _formKey = GlobalKey<FormState>();
  final _captionController = TextEditingController();
  final List<XFile> _images = [];
  final List<XFile> _videos = [];
  String? _clubSlug;
  final ImagePicker _picker = ImagePicker();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String && _clubSlug == null) {
      _clubSlug = args;
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        setState(() {
          _images.addAll(pickedFiles);
        });
      }
    } catch (e) {
      ToastUtil.showShortToast("Failed to pick images");
    }
  }

  Future<void> _pickVideo() async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _videos.add(pickedFile);
        });
      }
    } catch (e) {
      ToastUtil.showShortToast("Failed to pick video");
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _removeVideo(int index) {
    setState(() {
      _videos.removeAt(index);
    });
  }

  Future<void> _submitForm() async {
    if (_clubSlug == null) {
      ToastUtil.showShortToast("Error: Club slug is missing");
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final success = await socialFeedCreateRxObj.createSocialFeedRx(
      clubSlug: _clubSlug!,
      caption: _captionController.text,
      imagePaths: _images.map((file) => file.path).toList(),
      videoPaths: _videos.map((file) => file.path).toList(),
    );

    if (success) {
      if (mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => NavigationService.goBack,
          child: Container(
            margin: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
              color: AppColor.c2196F3,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 16.sp,
            ),
          ),
        ),
        title: Text(
          "Create Feed",
          style: TextFontStyle.textStyle16InterW600.copyWith(
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabel("Caption"),
              CustomTextfieldWidget(
                hintText: "Write something here...",
                controller: _captionController,
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Caption is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              
              // Images section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildLabel("Images"),
                  GestureDetector(
                    onTap: _pickImages,
                    child: Row(
                      children: [
                        Icon(Icons.add_photo_alternate_outlined, color: AppColor.c2196F3, size: 20.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "Add Images",
                          style: TextStyle(color: AppColor.c2196F3, fontSize: 13.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_images.isNotEmpty) ...[
                SizedBox(
                  height: 100.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 12.w),
                            width: 100.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              image: DecorationImage(
                                image: FileImage(File(_images[index].path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 4.h,
                            right: 16.w,
                            child: GestureDetector(
                              onTap: () => _removeImage(index),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(2.w),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 14.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.h),
              ],
              SizedBox(height: 8.h),

              // Videos section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildLabel("Videos"),
                  GestureDetector(
                    onTap: _pickVideo,
                    child: Row(
                      children: [
                        Icon(Icons.video_call_outlined, color: AppColor.c2196F3, size: 20.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "Add Video",
                          style: TextStyle(color: AppColor.c2196F3, fontSize: 13.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_videos.isNotEmpty) ...[
                Column(
                  children: List.generate(_videos.length, (index) {
                    final filename = _videos[index].name;
                    return Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.video_file, color: Colors.white54, size: 24.sp),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              filename,
                              style: TextStyle(color: Colors.white, fontSize: 13.sp),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _removeVideo(index),
                            child: Icon(
                              Icons.close,
                              color: Colors.redAccent,
                              size: 20.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(height: 16.h),
              ],
              SizedBox(height: 40.h),
              
              ValueListenableBuilder<bool>(
                valueListenable: socialFeedCreateRxObj.isLoading,
                builder: (context, isLoading, child) {
                  return CustomSaveButton(
                    btnText: "Publish Feed",
                    isLoading: isLoading,
                    onCall: _submitForm,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
