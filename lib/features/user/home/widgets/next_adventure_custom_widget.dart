import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/user/home/presentation/next_adventure_screen.dart';
import 'package:aarongonzales01/features/user/home/widgets/adventure_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class NextAdventureCustomWidget extends StatefulWidget {
  const NextAdventureCustomWidget({super.key});

  @override
  State<NextAdventureCustomWidget> createState() =>
      _NextAdventureCustomWidgetState();
}

class _NextAdventureCustomWidgetState extends State<NextAdventureCustomWidget> {
  final List<Map<String, dynamic>> adventures = [
    {
      "title": "5K City Run",
      "location": "San Francisco -> USA",
      "badge": "New",
      "image": "https://images.unsplash.com/photo-1551632811-561732d1e306",
    },
    {
      "title": "5K City Run",
      "location": "San Francisco -> USA",
      "badge": "New",
      "image": "https://images.unsplash.com/photo-1551632811-561732d1e306",
    },
    {
      "title": "5K City Run",
      "location": "San Francisco -> USA",
      "badge": "Popular",
      "image": "https://images.unsplash.com/photo-1551632811-561732d1e306",
    },
    {
      "title": "5K City Run",
      "location": "San Francisco -> USA",
      "badge": "New",
      "image": "https://images.unsplash.com/photo-1551632811-561732d1e306",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Find Your Next Adventure",
                style: TextFontStyle.textStyle16InterW600.copyWith(
                  fontSize: 20.sp,
                  color: AppColor.cFFFFFF,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(const NextAdventureScreen());
                },
                child: Text(
                  "See all",
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    color: AppColor.cFFFFFF,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          /// GRID
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: adventures.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 24.h,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (context, index) {
              final adventure = adventures[index];
              return AdventureCard(adventure: adventure);
            },
          ),
        ],
      ),
    );
  }
}
