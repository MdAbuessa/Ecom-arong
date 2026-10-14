import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KeypadViewScreen extends StatefulWidget {
  const KeypadViewScreen({super.key});

  @override
  State<KeypadViewScreen> createState() => _KeypadViewScreenState();
}

class _KeypadViewScreenState extends State<KeypadViewScreen> {
  final List<Map<String, dynamic>> finishedRacers = [
    {
      "bib": "101",
      "name": "John doe",
      "finishTime": "07:12 AM",
      "duration": "12:31",
    },
    {
      "bib": "105",
      "name": "Sabbir Ahmed",
      "finishTime": "07:13 AM",
      "duration": "13:05",
    },
    {
      "bib": "104",
      "name": "Marjia Islam",
      "finishTime": "07:15 AM",
      "duration": "13:40",
    },
    {
      "bib": "106",
      "name": "Tanvir Ahmed",
      "finishTime": "07:18 AM",
      "duration": "14:20",
    },
    {
      "bib": "108",
      "name": "Imtiaz Hasan",
      "finishTime": "07:19 AM",
      "duration": "15:02",
    },
    {
      "bib": "109",
      "name": "Shakib Hasan",
      "finishTime": "07:20 AM",
      "duration": "16:10",
    },
    {
      "bib": "102",
      "name": "Farhan Hasan",
      "finishTime": "07:24 AM",
      "duration": "16:58",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      appBar: ProfileAppBar(
        title: "Keypad View",
        onBackTap: () {
          NavigationService.goBack;
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: 90,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timer
                  Center(
                    child: Container(
                      width: 200.w,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      decoration: BoxDecoration(
                        color: AppColor.c2196F3,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          "00: 12: 45",
                          style: TextFontStyle.textStyle24RobotoW600.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(24),

                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Finished (24)",
                        style: TextFontStyle.textStyle14InterW500.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      Icon(
                        Icons.file_download_outlined,
                        color: AppColor.c2196F3,
                        size: 24.sp,
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(12),

                  // Search Field
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1E293B).withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search by bib number",
                        hintStyle: TextFontStyle.textStyle14InterW400.copyWith(
                          color: AppColor.c707171,
                        ),
                        prefixIcon: Icon(Icons.search, color: AppColor.c707171),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(12),

                  // Table
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: const Color(0xFF1E293B)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        // Header Row
                        Container(
                          color: const Color(0xFF1E3A5F),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Bib",
                                  style: TextFontStyle.textStyle14InterW500
                                      .copyWith(fontSize: 11.sp),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Name",
                                  style: TextFontStyle.textStyle14InterW500
                                      .copyWith(fontSize: 11.sp),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    "Finish Time",
                                    style: TextFontStyle.textStyle14InterW500
                                        .copyWith(fontSize: 11.sp),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    "Duration",
                                    style: TextFontStyle.textStyle14InterW500
                                        .copyWith(fontSize: 11.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // List Items
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: finishedRacers.length,
                          itemBuilder: (context, index) {
                            final racer = finishedRacers[index];
                            final bool isEven = index % 2 == 0;
                            return Container(
                              color: isEven
                                  ? const Color(0xFF2A2E3D)
                                  : const Color(0xFF1E293B),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.h,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      racer["bib"],
                                      style: TextFontStyle.textStyle14InterW500
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 11.sp,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      racer["name"],
                                      style: TextFontStyle.textStyle14InterW400
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 11.sp,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 4.h,
                                          horizontal: 6.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(
                                            0xFF386927,
                                          ), // Green bg
                                          borderRadius: BorderRadius.circular(
                                            4.r,
                                          ),
                                        ),
                                        child: Text(
                                          racer["finishTime"],
                                          style: TextFontStyle
                                              .textStyle14InterW500
                                              .copyWith(
                                                color: Colors.white,
                                                fontSize: 11.sp,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Text(
                                        racer["duration"],
                                        style: TextFontStyle
                                            .textStyle14InterW400
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 11.sp,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(24),

                  // View All Finished Button
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(color: AppColor.c2196F3),
                      ),
                      child: Center(
                        child: Text(
                          "View All Finished (24)",
                          style: TextFontStyle.textStyle14InterW500.copyWith(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(40),
                ],
              ),
            ),
          ),

          // Keypad Area
          // Container(
          //   color: const Color(0xFF141A27), // Darker keypad background
          //   padding: EdgeInsets.only(
          //     left: 4.w,
          //     right: 4.w,
          //     top: 8.h,
          //     bottom: 8.h + 85.h,
          //   ),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Row(
          //         children: [
          //           KeypadButton(number: "1", letters: ""),
          //           KeypadButton(number: "2", letters: "a b c"),
          //           KeypadButton(number: "3", letters: "d e f"),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           KeypadButton(number: "4", letters: "g h i"),
          //           KeypadButton(number: "5", letters: "j k l"),
          //           KeypadButton(number: "6", letters: "m n o"),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           KeypadButton(number: "7", letters: "p q r s"),
          //           KeypadButton(number: "8", letters: "t u v"),
          //           KeypadButton(number: "9", letters: "w x y z"),
          //         ],
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             child: GestureDetector(
          //               onTap: () {},
          //               child: Icon(
          //                 Icons.mic_none,
          //                 color: Colors.white,
          //                 size: 26.sp,
          //               ),
          //             ),
          //           ),
          //           KeypadButton(number: "0", letters: ""),
          //           Expanded(
          //             child: GestureDetector(
          //               onTap: () {},
          //               child: Icon(
          //                 Icons.backspace_outlined,
          //                 color: Colors.white,
          //                 size: 22.sp,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
