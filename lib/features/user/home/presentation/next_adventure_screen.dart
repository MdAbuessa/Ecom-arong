import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/features/user/home/widgets/adventure_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextAdventureScreen extends StatefulWidget {
  const NextAdventureScreen({super.key});

  @override
  State<NextAdventureScreen> createState() => _NextAdventureScreenState();
}

class _NextAdventureScreenState extends State<NextAdventureScreen> {
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
            image: DecorationImage(
              image: AssetImage('assets/images/home_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  // App Bar
                  SizedBox(height: 10.h),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const CustomBackButton(),
                      ),
                      Text(
                        'Find Your Next Adventure',
                        style: TextFontStyle.textStyle16InterW600.copyWith(
                          fontSize: 18.sp,
                          color: AppColor.cFFFFFF,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),
                  Expanded(
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
