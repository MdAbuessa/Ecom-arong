import 'dart:io';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/common_widgets/custom_image_picker_widget.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/create_event_helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class EventSection {}

class TitleSection extends EventSection {
  String text;
  TitleSection(this.text);
}

class TextSection extends EventSection {
  final TextEditingController controller = TextEditingController();
}

class ImageSection extends EventSection {
  String? imagePath;
  ImageSection(this.imagePath);
}

class BasicInfoPart extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController locationMapController;
  final TextEditingController descriptionController;
  final bool autoAssignRaceBib;
  final String visibility;
  final Function(bool) onAutoAssignChanged;
  final Function(String) onVisibilityChanged;
  final String? initialType;
  final String? initialCategory;
  final List<dynamic>? initialSections;

  const BasicInfoPart({
    super.key,
    required this.titleController,
    required this.locationController,
    required this.descriptionController,
    required this.autoAssignRaceBib,
    required this.visibility,
    required this.onAutoAssignChanged,
    required this.onVisibilityChanged,
    required this.locationMapController,
    this.initialType,
    this.initialCategory,
    this.initialSections,
  });

  @override
  State<BasicInfoPart> createState() => BasicInfoPartState();
}

class BasicInfoPartState extends State<BasicInfoPart> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final List<EventSection> addedSections = [];

  String selectedType = "Physical";
  final List<String> _types = ["Physical", "Online", "Hybrid"];

  String selectedCategory = "Hiking";
  final List<String> _categories = [
    "Hiking",
    "Running",
    "Walking",
    "Cycling",
    "Swimming",
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialType != null) {
      final matched = _types.firstWhere(
        (t) => t.toLowerCase() == widget.initialType!.toLowerCase(),
        orElse: () => "Physical",
      );
      selectedType = matched;
    }
    if (widget.initialCategory != null) {
      final matched = _categories.firstWhere(
        (c) => c.toLowerCase() == widget.initialCategory!.toLowerCase(),
        orElse: () => "Hiking",
      );
      selectedCategory = matched;
    }
    if (widget.initialSections != null) {
      for (var sec in widget.initialSections!) {
        final title = sec.title;
        final description = sec.description;
        final imageUrl = sec.imageUrl;

        if (title == "Text") {
          final tSec = TextSection();
          tSec.controller.text = description ?? "";
          addedSections.add(tSec);
        } else if (title == "Image") {
          addedSections.add(ImageSection(imageUrl));
        } else {
          addedSections.add(TitleSection(title ?? ""));
        }
      }
    }
  }

  @override
  void dispose() {
    for (var section in addedSections) {
      if (section is TextSection) {
        section.controller.dispose();
      }
    }
    super.dispose();
  }

  void _showAddSectionForm(BuildContext context) {
    String selectedType = "Title";
    final textController = TextEditingController();
    String? pickedImagePath;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF0F1B2A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: const Text(
                "Add Section",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: buildTabButton(
                              "Title",
                              selectedType == "Title",
                              () =>
                                  dialogSetState(() => selectedType = "Title"),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: buildTabButton(
                              "Text",
                              selectedType == "Text",
                              () => dialogSetState(() => selectedType = "Text"),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: buildTabButton(
                              "Image",
                              selectedType == "Image",
                              () =>
                                  dialogSetState(() => selectedType = "Image"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      if (selectedType == "Title") ...[
                        buildLabel("Title Text"),
                        CustomTextfieldWidget(
                          hintText: "Enter title text",
                          controller: textController,
                        ),
                      ] else if (selectedType == "Text") ...[
                        buildLabel("Text Content"),
                        CustomTextfieldWidget(
                          hintText: "Enter custom text content",
                          controller: textController,
                          maxLines: 4,
                        ),
                      ] else if (selectedType == "Image") ...[
                        buildLabel("Select Image"),
                        GestureDetector(
                          onTap: () {
                            showCustomImagePicker(
                              context: context,
                              onImagePicked: (pickedFile) {
                                dialogSetState(() {
                                  pickedImagePath = pickedFile.path;
                                });
                              },
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 120.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.white.withValues(alpha: 0.05),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                            ),
                            child: pickedImagePath != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: Image.file(
                                      File(pickedImagePath!),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : CustomPaint(
                                    painter: DashRectPainter(),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.image_outlined,
                                            color: Colors.grey,
                                            size: 30.sp,
                                          ),
                                          SizedBox(height: 6.h),
                                          Text(
                                            "Upload Image",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedType == "Title") {
                      if (textController.text.trim().isNotEmpty) {
                        setState(() {
                          addedSections.add(
                            TitleSection(textController.text.trim()),
                          );
                        });
                      }
                    } else if (selectedType == "Text") {
                      if (textController.text.trim().isNotEmpty) {
                        setState(() {
                          final textSection = TextSection();
                          textSection.controller.text = textController.text
                              .trim();
                          addedSections.add(textSection);
                        });
                      }
                    } else if (selectedType == "Image") {
                      if (pickedImagePath != null) {
                        setState(() {
                          addedSections.add(ImageSection(pickedImagePath));
                        });
                      }
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.c2196F3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildInteractiveDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: value,
          dropdownColor: const Color(0xFF0F1B2A),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          style: const TextStyle(color: Colors.white, fontSize: 14),
          onChanged: onChanged,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStepper(0),
          buildLabel("Event Title"),
          CustomTextfieldWidget(
            hintText: "Enter event title",
            controller: widget.titleController,
          ),
          SizedBox(height: 16.h),
          buildLabel("Event Type"),
          _buildInteractiveDropdown(
            value: selectedType,
            items: _types,
            onChanged: (v) => setState(() => selectedType = v!),
          ),
          SizedBox(height: 16.h),
          buildLabel("Event category"),
          _buildInteractiveDropdown(
            value: selectedCategory,
            items: _categories,
            onChanged: (v) => setState(() => selectedCategory = v!),
          ),
          SizedBox(height: 16.h),
          buildLabel("Location"),
          CustomTextfieldWidget(
            hintText: "Enter location",
            controller: widget.locationController,
          ),
          SizedBox(height: 16.h),
          buildLabel("Location map"),
          CustomTextfieldWidget(
            hintText: "Enter location map",
            controller: widget.locationMapController,
            prefixIcon: Icon(Icons.location_on, color: Colors.grey),
          ),
          SizedBox(height: 16.h),
          buildLabel("Description"),
          CustomTextfieldWidget(
            hintText: "Enter the description",
            controller: widget.descriptionController,
            maxLines: 4,
          ),

          // Render Dynamic Custom Sections if any exist
          if (addedSections.isNotEmpty) ...[
            SizedBox(height: 16.h),
            ...addedSections.asMap().entries.map((entry) {
              final index = entry.key;
              final section = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            section is TitleSection
                                ? "Custom Title Section"
                                : (section is TextSection
                                      ? "Custom Text Section"
                                      : "Custom Image Section"),
                            style: TextStyle(
                              color: AppColor.c2196F3,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                addedSections.removeAt(index);
                              });
                            },
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                              size: 18.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      if (section is TitleSection) ...[
                        Text(
                          section.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ] else if (section is TextSection) ...[
                        CustomTextfieldWidget(
                          hintText: "Enter custom text content",
                          controller: section.controller,
                          maxLines: 3,
                        ),
                      ] else if (section is ImageSection) ...[
                        if (section.imagePath != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: section.imagePath!.startsWith('http')
                                ? Image.network(
                                    section.imagePath!,
                                    height: 140.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(section.imagePath!),
                                    height: 140.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ],

          SizedBox(height: 20.h),
          Center(
            child: Text(
              "Add more sections to your event page",
              style: TextStyle(color: Colors.grey, fontSize: 12.sp),
            ),
          ),
          SizedBox(height: 12.h),
          buildOutlineButton(
            "+ Add Section",
            fullWidth: true,
            onTap: () => _showAddSectionForm(context),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLabel("Auto-assign race bib"),
              Switch(
                value: widget.autoAssignRaceBib,
                onChanged: widget.onAutoAssignChanged,
                activeColor: Colors.white,
                activeTrackColor: AppColor.c2196F3,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          buildLabel("Event Visibility"),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              children: [
                _buildVisibilityOption(
                  "Public",
                  "Anyone can discover and view this event",
                  Icons.public,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Divider(
                    color: Colors.white.withValues(alpha: 0.1),
                    height: 20.h,
                  ),
                ),
                _buildVisibilityOption(
                  "Private",
                  "Only accessible via direct link",
                  Icons.lock_outline,
                ),
              ],
            ),
          ),
          SizedBox(height: 120.h),
        ],
      ),
    );
  }

  Widget _buildVisibilityOption(String title, String subtitle, IconData icon) {
    bool isSelected = widget.visibility == title;
    return GestureDetector(
      onTap: () => widget.onVisibilityChanged(title),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: AppColor.c2196F3,
              size: 20,
            ),
            SizedBox(width: 12.w),
            Icon(icon, color: AppColor.c2196F3, size: 20),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
