import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:aarongonzales01/common_widgets/custom_save_button.dart';
import 'package:aarongonzales01/common_widgets/custom_image_picker_widget.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/create_club_helper_widgets.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/helpers/toast.dart';

class CreateNewChallengesScreen extends StatefulWidget {
  const CreateNewChallengesScreen({super.key});

  @override
  State<CreateNewChallengesScreen> createState() =>
      _CreateNewChallengesScreenState();
}

class _CreateNewChallengesScreenState extends State<CreateNewChallengesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _goalValueController = TextEditingController();

  String _selectedGoalType = "steps";
  final List<String> _goalTypes = ["steps", "distance", "swimming"];

  DateTime? _startDate;
  DateTime? _endDate;
  XFile? _thumbnailImage;
  String? _clubSlug;

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
    _titleController.dispose();
    _descriptionController.dispose();
    _goalValueController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColor.c2196F3,
              onPrimary: Colors.white,
              surface: Color(0xFF0F1B2A),
              onSurface: Colors.white,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF0F1B2A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        if (_endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = null;
        }
      });
    }
  }

  Future<void> _selectEndDate() async {
    if (_startDate == null) {
      ToastUtil.showShortToast("Please select start date first");
      return;
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate!.add(const Duration(days: 1)),
      firstDate: _startDate!,
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColor.c2196F3,
              onPrimary: Colors.white,
              surface: Color(0xFF0F1B2A),
              onSurface: Colors.white,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF0F1B2A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  Future<void> _submitForm() async {
    if (_clubSlug == null) {
      ToastUtil.showShortToast("Error: Club slug is missing");
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_startDate == null || _endDate == null) {
      ToastUtil.showShortToast("Please pick start and end dates");
      return;
    }

    if (_thumbnailImage == null) {
      ToastUtil.showShortToast("Please pick a challenge thumbnail");
      return;
    }

    final String startDateStr = DateFormat("yyyy-MM-dd").format(_startDate!);
    final String endDateStr = DateFormat("yyyy-MM-dd").format(_endDate!);

    final success = await challengeCreateRxObj.createChallengeRx(
      clubSlug: _clubSlug!,
      title: _titleController.text,
      description: _descriptionController.text,
      goalType: _selectedGoalType,
      goalValue: _goalValueController.text,
      startDate: startDateStr,
      endDate: endDateStr,
      thumbnailPath: _thumbnailImage!.path,
    );

    if (success) {
      clubChallengeListRxObj.fetchClubChallengeList(slug: _clubSlug!);
      clubShowRxObj.fetchClubShow(_clubSlug!);
      if (mounted) {
        NavigationService.goBack;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat("yyyy-MM-dd");

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
          "Create New Challenge",
          style: TextFontStyle.textStyle16InterW600.copyWith(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLabel("Challenge Title"),
                CustomTextfieldWidget(
                  hintText: "Enter challenge title",
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Title is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                buildLabel("Description"),
                CustomTextfieldWidget(
                  hintText: "Enter challenge description",
                  controller: _descriptionController,
                  maxLines: 4,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Description is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel("Goal Type"),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                width: 1.w,
                                color: AppColor.c797A7C.withValues(alpha: 0.5),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedGoalType,
                                dropdownColor: const Color(0xFF0F1B2A),
                                isExpanded: true,
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: AppColor.c797A7C,
                                  size: 20.sp,
                                ),
                                style: TextFontStyle.textStyle13PoppinsW500
                                    .copyWith(
                                      fontSize: 14.sp,
                                      color: AppColor.cFFFFFF,
                                      fontWeight: FontWeight.w400,
                                    ),
                                items: _goalTypes.map((type) {
                                  return DropdownMenuItem<String>(
                                    value: type,
                                    child: Text(
                                      type[0].toUpperCase() + type.substring(1),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() {
                                      _selectedGoalType = val;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel("Goal Value"),
                          CustomTextfieldWidget(
                            hintText: "1000",
                            controller: _goalValueController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Goal is required";
                              }
                              if (double.tryParse(value) == null) {
                                return "Must be a number";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel("Start Date"),
                          GestureDetector(
                            onTap: _selectStartDate,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  width: 1.w,
                                  color: AppColor.c797A7C.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _startDate != null
                                        ? dateFormat.format(_startDate!)
                                        : "Pick Start Date",
                                    style: TextFontStyle.textStyle13PoppinsW500
                                        .copyWith(
                                          fontSize: 14.sp,
                                          color: _startDate != null
                                              ? AppColor.cFFFFFF
                                              : AppColor.c797A7C,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: AppColor.c797A7C,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel("End Date"),
                          GestureDetector(
                            onTap: _selectEndDate,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  width: 1.w,
                                  color: AppColor.c797A7C.withValues(
                                    alpha: 0.5,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _endDate != null
                                        ? dateFormat.format(_endDate!)
                                        : "Pick End Date",
                                    style: TextFontStyle.textStyle13PoppinsW500
                                        .copyWith(
                                          fontSize: 14.sp,
                                          color: _endDate != null
                                              ? AppColor.cFFFFFF
                                              : AppColor.c797A7C,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  Icon(
                                    Icons.calendar_today_outlined,
                                    color: AppColor.c797A7C,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                buildLabel("Thumbnail Upload"),
                GestureDetector(
                  onTap: () => showCustomImagePicker(
                    context: context,
                    onImagePicked: (file) {
                      setState(() {
                        _thumbnailImage = file;
                      });
                    },
                  ),
                  child: SizedBox(
                    height: 150.h,
                    width: double.infinity,
                    child: _thumbnailImage != null
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              image: DecorationImage(
                                image: FileImage(File(_thumbnailImage!.path)),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : CustomPaint(
                            painter: DashRectPainter(),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    color: AppColor.c2196F3,
                                    size: 40.sp,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "Upload Thumbnail",
                                    style: TextStyle(
                                      color: AppColor.c797A7C,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 32.h),
                ValueListenableBuilder<bool>(
                  valueListenable: challengeCreateRxObj.isLoading,
                  builder: (context, isLoading, child) {
                    return CustomSaveButton(
                      btnText: "Create Challenge",
                      isLoading: isLoading,
                      onCall: _submitForm,
                    );
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
