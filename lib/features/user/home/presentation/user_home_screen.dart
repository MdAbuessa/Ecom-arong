import 'package:aarongonzales01/features/user/home/widgets/customcarousel_slider_widget.dart';
import 'package:aarongonzales01/features/user/home/widgets/suggested_for_you_custom_widget.dart';
import 'package:aarongonzales01/features/user/home/widgets/upcoming_event_widget.dart';
import 'package:aarongonzales01/features/user/home/widgets/user_home_header_widget.dart';
import 'package:aarongonzales01/features/user/home/widgets/next_adventure_custom_widget.dart';
import 'package:aarongonzales01/features/user/shop/widgets/shop_and_reward_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
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
            child: Column(
              children: [
                UserHomeHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // -------------- Custom Carousel Slider --------------
                        CustomCarouselSlider(),
                        // -------------- Upcoming Events --------------
                        UpcomingEventsSection(),
                        SizedBox(height: 20.h),
                        // -------------- Shop And Reward --------------
                        const ShopAndRewardWidget(),
                        SizedBox(height: 20.h),
                        // -------------- Next Adventure --------------
                        const NextAdventureCustomWidget(),
                        SizedBox(height: 20.h),
                        const SuggestedForYouCustomWidget(),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
