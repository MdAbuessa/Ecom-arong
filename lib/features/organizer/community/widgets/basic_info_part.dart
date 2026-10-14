import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/create_club_helper_widgets.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/features/organizer/community/model/club_category_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicInfoPart extends StatefulWidget {
  final TextEditingController clubNameController;
  final String selectedTopic;
  final List<String> topics;
  final ValueChanged<String?> onTopicChanged;
  final TextEditingController locationController;
  final TextEditingController descriptionController;
  final TextEditingController instagramLinkController;

  final List<Map<String, String>> socialLinks;

  const BasicInfoPart({
    super.key,
    required this.clubNameController,
    required this.selectedTopic,
    required this.topics,
    required this.onTopicChanged,
    required this.locationController,
    required this.descriptionController,
    required this.instagramLinkController,
    required this.socialLinks,
  });

  @override
  State<BasicInfoPart> createState() => _BasicInfoPartState();
}

class _BasicInfoPartState extends State<BasicInfoPart> {
  bool _showSocialSection = false;
  bool _showDropdownMenu = false;
  String? _selectedLinkType;
  late List<Datum> _topicsList;

  final List<String> _linkTypes = [
    "Social Media website Link",
    "Instagram Link",
    "Facebook Link",
    "Tik Tok Link",
    "Twitter Link",
  ];

  @override
  void initState() {
    super.initState();
    _topicsList = widget.topics
        .map(
          (name) =>
              Datum(name: name, slug: name.toLowerCase().replaceAll(' ', '-')),
        )
        .toList();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final res = await clubCategoryListRxObj.fetchClubCategoryList();
    if (res != null && res.data != null) {
      final validData = res.data!
          .where((e) => e.name != null && e.slug != null)
          .toList();
      if (validData.isNotEmpty) {
        if (mounted) {
          setState(() {
            _topicsList = validData;
            final hasMatch = _topicsList.any(
              (e) => e.slug == widget.selectedTopic,
            );
            if (!hasMatch) {
              widget.onTopicChanged(_topicsList.first.slug);
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStepper(0),
          buildLabel("Club Name"),
          CustomTextfieldWidget(
            hintText: "Enter club name",
            controller: widget.clubNameController,
          ),
          SizedBox(height: 16.h),
          buildLabel("Topic"),
          _buildInteractiveTopicDropdown(),
          SizedBox(height: 16.h),
          buildLabel("Location"),
          CustomTextfieldWidget(
            hintText: "Enter location",
            controller: widget.locationController,
          ),
          SizedBox(height: 16.h),
          buildLabel("Description"),
          CustomTextfieldWidget(
            hintText: "Enter the description",
            controller: widget.descriptionController,
            maxLines: 4,
          ),
          SizedBox(height: 24.h),

          if (_showSocialSection) ...[
            // Image 1: Social Media Link Header Row
            GestureDetector(
              onTap: () {
                setState(() {
                  _showDropdownMenu = !_showDropdownMenu;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Social Media Link",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      _showDropdownMenu
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ),

            // Image 2: Dropdown options list
            if (_showDropdownMenu) ...[
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(
                    0xFF101B2B,
                  ), // Elegant matching dark menu background
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _linkTypes
                      .where(
                        (type) => !widget.socialLinks.any(
                          (link) => link['type'] == type,
                        ),
                      )
                      .map((type) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedLinkType = type;
                              _showDropdownMenu = false;
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Text(
                              type,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      })
                      .toList(),
                ),
              ),
            ],

            // Image 3: Input Field and selected item label
            if (_selectedLinkType != null && !_showDropdownMenu) ...[
              SizedBox(height: 8.h),
              buildLabel(_selectedLinkType!),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: CustomTextfieldWidget(
                        hintText: "Enter link",
                        controller: widget.instagramLinkController,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    ElevatedButton(
                      onPressed: () {
                        final urlText = widget.instagramLinkController.text
                            .trim();
                        if (urlText.isNotEmpty) {
                          final alreadyExists = widget.socialLinks.any(
                            (link) => link['type'] == _selectedLinkType,
                          );
                          if (alreadyExists) {
                            ToastUtil.showShortToast(
                              "This link type has already been added.",
                            );
                            return;
                          }
                          setState(() {
                            widget.socialLinks.add({
                              'type': _selectedLinkType!,
                              'url': urlText,
                            });
                            widget.instagramLinkController.clear();
                            _selectedLinkType = null;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.c2196F3,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        "Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
            ],

            if (widget.socialLinks.isNotEmpty) ...[
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.socialLinks.length,
                itemBuilder: (context, index) {
                  final item = widget.socialLinks[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['type'] ?? '',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.6),
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                item['url'] ?? '',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.socialLinks.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
            ],
          ],

          _buildAddLinkButton(),

          SizedBox(height: 120.h),
        ],
      ),
    );
  }

  Widget _buildInteractiveTopicDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: _topicsList.any((e) => e.slug == widget.selectedTopic)
              ? widget.selectedTopic
              : null,
          dropdownColor: const Color(0xFF0F1B2A),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          style: const TextStyle(color: Colors.white, fontSize: 14),
          onChanged: widget.onTopicChanged,
          onTap: _loadCategories,
          items: _topicsList.map((Datum item) {
            return DropdownMenuItem<String>(
              value: item.slug,
              child: Text(
                item.name ?? '',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAddLinkButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (!_showSocialSection) {
              _showSocialSection = true;
            } else {
              _selectedLinkType = null;
              _showDropdownMenu = true;
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColor.c2196F3.withValues(alpha: 0.6)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: AppColor.c2196F3, size: 16.sp),
              SizedBox(width: 8.w),
              Text(
                "Add Link",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
