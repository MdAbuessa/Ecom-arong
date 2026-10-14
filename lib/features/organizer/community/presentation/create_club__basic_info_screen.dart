import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/basic_info_part.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/banner_section_part.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'dart:developer' as dev;
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/features/organizer/community/model/club_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CreateClubBasicInfoScreen extends StatefulWidget {
  const CreateClubBasicInfoScreen({super.key});

  @override
  State<CreateClubBasicInfoScreen> createState() =>
      _CreateClubBasicInfoScreenState();
}

class _CreateClubBasicInfoScreenState extends State<CreateClubBasicInfoScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  // Step 1: Basic Info Controllers & State
  final _clubNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _instagramLinkController = TextEditingController();
  String _selectedTopic = "walking";
  final List<String> _topics = [
    "Walking",
    "Running",
    "Hiking",
    "Cycling",
    "Swimming",
  ];

  // Step 2: Banner Section State
  XFile? _profileImage;
  XFile? _coverImage;
  final List<Map<String, String>> _socialLinks = [];
  Club? _editingClub;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    dev.log(
      "CreateClubBasicInfoScreen didChangeDependencies: args=$args, args.runtimeType=${args.runtimeType}",
    );
    if (args is Club && _editingClub == null) {
      _editingClub = args;
      dev.log(
        "CreateClubBasicInfoScreen refilling fields for club: ${_editingClub!.name}",
      );
      _clubNameController.text = _editingClub!.name ?? '';
      _locationController.text = _editingClub!.location ?? '';
      _descriptionController.text = _editingClub!.description ?? '';
      if (_editingClub!.topic?.slug != null) {
        _selectedTopic = _editingClub!.topic!.slug!;
      }
      if (_editingClub!.socialLinks != null) {
        _socialLinks.clear();
        for (var link in _editingClub!.socialLinks!) {
          if (link.platform != null && link.url != null) {
            String type = '';
            if (link.platform == 'website') {
              type = "Social Media website Link";
            } else if (link.platform == 'instagram') {
              type = "Instagram Link";
            } else if (link.platform == 'facebook') {
              type = "Facebook Link";
            } else if (link.platform == 'tiktok') {
              type = "Tik Tok Link";
            } else if (link.platform == 'x') {
              type = "Twitter Link";
            }

            if (type.isNotEmpty) {
              _socialLinks.add({'type': type, 'url': link.url!});
            }
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _clubNameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _instagramLinkController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_clubNameController.text.trim().isEmpty) {
      ToastUtil.showShortToast("Club name is required");
      return;
    }
    if (_selectedTopic.trim().isEmpty) {
      ToastUtil.showShortToast("Topic must be selected");
      return;
    }
    if (_locationController.text.trim().isEmpty) {
      ToastUtil.showShortToast("Club location is required");
      return;
    }

    if (_currentIndex < 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _saveClub() async {
    final Map<String, String> linksMap = {};
    for (var link in _socialLinks) {
      final type = link['type'];
      final url = link['url'];
      if (type != null && url != null) {
        String key = '';
        if (type == "Social Media website Link") {
          key = 'website';
        } else if (type == "Instagram Link") {
          key = 'instagram';
        } else if (type == "Facebook Link") {
          key = 'facebook';
        } else if (type == "Tik Tok Link") {
          key = 'tiktok';
        } else if (type == "Twitter Link") {
          key = 'x';
        }

        if (key.isNotEmpty) {
          linksMap[key] = url;
        }
      }
    }

    if (_editingClub != null) {
      final res = await updateClubRxObj.updateClub(
        clubSlug: _editingClub!.slug!,
        name: _clubNameController.text.trim(),
        topicSlug: _selectedTopic.trim(),
        location: _locationController.text.trim(),
        description: _descriptionController.text.trim(),
        avatarPhotoPath: _profileImage?.path,
        coverPhotoPath: _coverImage?.path,
        socialLinks: linksMap,
      );

      if (res != null) {
        if (mounted) {
          Navigator.pop(context);
        }
      }
    } else {
      final res = await createClubRxObj.createClub(
        name: _clubNameController.text.trim(),
        topicSlug: _selectedTopic.trim(),
        location: _locationController.text.trim(),
        description: _descriptionController.text.trim(),
        avatarPhotoPath: _profileImage?.path,
        coverPhotoPath: _coverImage?.path,
        socialLinks: linksMap,
      );

      if (res != null) {
        if (mounted) {
          Navigator.pop(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF06113A), Colors.black, Colors.black],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                _buildAppBar(),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    children: [
                      BasicInfoPart(
                        clubNameController: _clubNameController,
                        selectedTopic: _selectedTopic,
                        topics: _topics,
                        onTopicChanged: (v) {
                          if (v != null) {
                            setState(() => _selectedTopic = v);
                          }
                        },
                        locationController: _locationController,
                        descriptionController: _descriptionController,
                        instagramLinkController: _instagramLinkController,
                        socialLinks: _socialLinks,
                      ),
                      BannerSectionPart(
                        profileImage: _profileImage,
                        coverImage: _coverImage,
                        initialProfileUrl: _editingClub?.avatarUrl,
                        initialCoverUrl: _editingClub?.coverUrl,
                        onProfilePicked: (file) =>
                            setState(() => _profileImage = file),
                        onCoverPicked: (file) =>
                            setState(() => _coverImage = file),
                      ),
                    ],
                  ),
                ),
                _buildBottomButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    String title = _editingClub != null ? "Edit Club" : "Basic Info";
    if (_currentIndex == 1) title = "Banner Section";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: _previousPage,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColor.c2196F3,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: TextFontStyle.textStyle16InterW600.copyWith(
              fontSize: 18.sp,
              color: AppColor.c2196F3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    final activeLoading = _editingClub != null
        ? updateClubRxObj.isLoading
        : createClubRxObj.isLoading;
    return ValueListenableBuilder<bool>(
      valueListenable: activeLoading,
      builder: (context, isLoading, child) {
        String text = _currentIndex == 1
            ? (_editingClub != null ? "Update club" : "Save club")
            : "Next";
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: 20.h,
            top: 10.h,
          ),
          child: ElevatedButton(
            onPressed: isLoading
                ? () {}
                : () {
                    if (_currentIndex == 1) {
                      _saveClub();
                    } else {
                      _nextPage();
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.c2196F3,
              minimumSize: Size(double.infinity, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
