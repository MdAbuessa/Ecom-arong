import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/user/home/presentation/suggested_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SuggestedForYouCustomWidget extends StatefulWidget {
  const SuggestedForYouCustomWidget({super.key});

  @override
  State<SuggestedForYouCustomWidget> createState() =>
      _SuggestedForYouCustomWidgetState();
}

class _SuggestedForYouCustomWidgetState
    extends State<SuggestedForYouCustomWidget> {
  final List<Map<String, dynamic>> suggestions = [
    {
      "title": "Run 100KM",
      "progressText": "Progress: 45%",
      "progress": 0.45,
      "image": "assets/images/suggested_for_you_img.png",
    },
    {
      "title": "Run 100KM",
      "progressText": "Progress: 45%",
      "progress": 0.45,
      "image": "assets/images/suggested_for_you_img.png",
    },
    {
      "title": "Run 100KM",
      "progressText": "Progress: 45%",
      "progress": 0.45,
      "image": "assets/images/suggested_for_you_img.png",
    },
    {
      "title": "Run 100KM",
      "progressText": "Progress: 45%",
      "progress": 0.45,
      "image": "assets/images/suggested_for_you_img.png",
    },
    {
      "title": "Run 100KM",
      "progressText": "Progress: 45%",
      "progress": 0.45,
      "image": "assets/images/suggested_for_you_img.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "Suggested For You",
              style: TextFontStyle.textStyle16InterW600.copyWith(
                fontSize: 20.sp,
                color: AppColor.cFFFFFF,
              ),
            ),
          ),

          SizedBox(height: 20.h),

          /// LIST
          SizedBox(
            height: 180.h,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              scrollDirection: Axis.horizontal,
              itemCount: suggestions.length,
              separatorBuilder: (context, index) => SizedBox(width: 16.w),
              itemBuilder: (context, index) {
                final suggestion = suggestions[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => const SuggestedScreen());
                  },
                  child: _SuggestionCard(suggestion: suggestion),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  final Map<String, dynamic> suggestion;

  const _SuggestionCard({required this.suggestion});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        image: DecorationImage(
          image: AssetImage(suggestion["image"]),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          /// GRADIENT OVERLAY
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),
          ),

          /// CONTENT
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  suggestion["title"],
                  style: TextFontStyle.textStyle16InterW600.copyWith(
                    fontSize: 18.sp,
                    color: AppColor.cFFFFFF,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  suggestion["progressText"],
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.cD5D6D6,
                  ),
                ),
                SizedBox(height: 12.h),

                /// PROGRESS BAR
                Stack(
                  children: [
                    Container(
                      height: 8.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: suggestion["progress"],
                      child: Container(
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2196F3),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
