import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_save_button.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllRecersScreen extends StatefulWidget {
  const AllRecersScreen({super.key});

  @override
  State<AllRecersScreen> createState() => _AllRecersScreenState();
}

class _AllRecersScreenState extends State<AllRecersScreen> {
  bool selectAll = false;
  List<Map<String, dynamic>> racers = [
    {"bib": "101", "name": "John doe", "selected": true},
    {"bib": "102", "name": "Ayana mere", "selected": false},
    {"bib": "103", "name": "Alex sobuj", "selected": false},
    {"bib": "104", "name": "Johan doon", "selected": false},
    {"bib": "105", "name": "Johan doon", "selected": false},
    {"bib": "106", "name": "Johan doon", "selected": true},
    {"bib": "107", "name": "Johan doon", "selected": true},
    {"bib": "108", "name": "Johan doon", "selected": false},
    {"bib": "109", "name": "Johan doon", "selected": false},
    {"bib": "110", "name": "Meherima mahi", "selected": true},
    {"bib": "111", "name": "Johan doon", "selected": true},
    {"bib": "112", "name": "Johan doon", "selected": true},
    {"bib": "113", "name": "Johan doon", "selected": false},
    {"bib": "115", "name": "Johan doon", "selected": false},
    {"bib": "116", "name": "Meherima mahi", "selected": true},
  ];

  void _toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (var racer in racers) {
        racer["selected"] = selectAll;
      }
    });
  }

  void _toggleRacer(int index, bool? value) {
    setState(() {
      racers[index]["selected"] = value ?? false;
      selectAll = racers.every((racer) => racer["selected"] == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColor.blackColor,
        appBar: ProfileAppBar(
          title: "All Racers",
          onBackTap: () {
            Navigator.pop(context);
          },
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1E293B).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Search bib number or name",
                    hintStyle: TextFontStyle.textStyle14InterW400.copyWith(
                      color: AppColor.c707171,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColor.c707171,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("100 racers", style: TextFontStyle.textStyle14InterW500),
                  Row(
                    children: [
                      SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: Checkbox(
                          value: selectAll,
                          onChanged: _toggleSelectAll,
                          checkColor: Colors.white,
                          activeColor: AppColor.c2196F3,
                          side: const BorderSide(color: AppColor.c707171),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Select All",
                        style: TextFontStyle.textStyle14InterW400.copyWith(
                          color: AppColor.c2196F3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(12),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Column(
                    children: [
                      Container(
                        color: const Color(0xFF1E3A5F), // Header background
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 32.w), // Space for checkbox
                            SizedBox(width: 16.w),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Bib",
                                style: TextFontStyle.textStyle14InterW500,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Name",
                                style: TextFontStyle.textStyle14InterW500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: racers.length,
                          separatorBuilder: (context, index) => const Divider(
                            color: Color(0xFF1E293B),
                            height: 1,
                            thickness: 1,
                          ),
                          itemBuilder: (context, index) {
                            final racer = racers[index];
                            return Container(
                              color: const Color(
                                0xFF111827,
                              ).withOpacity(0.5), // Row background
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: Checkbox(
                                      value: racer["selected"],
                                      onChanged: (val) =>
                                          _toggleRacer(index, val),
                                      checkColor: Colors.white,
                                      activeColor: AppColor.c2196F3,
                                      side: const BorderSide(
                                        color: AppColor.c707171,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 28.w),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      racer["bib"],
                                      style: TextFontStyle.textStyle14InterW500,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      racer["name"],
                                      style: TextFontStyle.textStyle14InterW500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: CustomSaveButton(
                  onCall: () {
                    NavigationService.navigateTo(Routes.allRecersRecordScreen);
                  },
                  btnText: "Start race",
                  btnColor: AppColor.c2196F3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
