import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/user/upcoming_events/presentation/upcoming_events_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class AdventureCard extends StatelessWidget {
  final Map<String, dynamic> adventure;

  const AdventureCard({super.key, required this.adventure});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(UpcomingEventsDetailsScreen());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE WITH BADGE
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.r),
                    image: DecorationImage(
                      image: NetworkImage(adventure["image"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// BOTTOM BLUR GRADIENT
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32.r),
                        bottomRight: Radius.circular(32.r),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ),

                /// BADGE
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 7.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2196F3),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.r),
                        bottomRight: Radius.circular(32.r),
                      ),
                    ),
                    child: Text(
                      adventure["badge"],
                      style: TextFontStyle.textStyle16InterW600.copyWith(
                        fontSize: 14.sp,
                        color: AppColor.cFFFFFF,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 14.h),

          /// TITLE
          Text(
            adventure["title"],
            style: TextFontStyle.textStyle24RobotoW600.copyWith(
              fontSize: 20.sp,
              color: AppColor.cFFFFFF,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 4.h),

          /// LOCATION
          Row(
            children: [
              Image.asset(
                'assets/images/location_icon.png',
                height: 12,
                width: 12,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  adventure["location"],
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    fontSize: 12.sp,
                    color: AppColor.cD5D6D6,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
