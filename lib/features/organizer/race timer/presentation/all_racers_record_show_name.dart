import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/organizer/race%20timer/widgets/container_widgets.dart';
import 'package:aarongonzales01/features/organizer/race%20timer/widgets/live_result_list_item.dart';
import 'package:aarongonzales01/features/organizer/race%20timer/widgets/racer_grid_card.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllRacersRecordShowName extends StatefulWidget {
  const AllRacersRecordShowName({super.key});

  @override
  State<AllRacersRecordShowName> createState() =>
      _AllRacersRecordShowNameState();
}

class _AllRacersRecordShowNameState extends State<AllRacersRecordShowName> {
  int _selectedTabIndex = 0;

  final List<Map<String, dynamic>> allRacers = [
    {"bib": "101", "name": "Rahim Uddin", "status": RacerStatus.notRecorded},
    {"bib": "102", "name": "Arafat Islam", "status": RacerStatus.notRecorded},
    {
      "bib": "103",
      "name": "Shakib Hasan",
      "status": RacerStatus.finished,
      "time": "25:58:0",
    },
    {"bib": "104", "name": "Tanvir Ahmed", "status": RacerStatus.notRecorded},
    {
      "bib": "105",
      "name": "Rifat Karim",
      "status": RacerStatus.finished,
      "time": "24:58:0",
    },
    {"bib": "106", "name": "Tanjila Akter", "status": RacerStatus.notRecorded},
    {"bib": "107", "name": "Rahim Uddin", "status": RacerStatus.notRecorded},
    {"bib": "108", "name": "Rahim Uddin", "status": RacerStatus.notRecorded},
    {"bib": "109", "name": "Rahim Uddin", "status": RacerStatus.dnf},
    {"bib": "110", "name": "Rahim Uddin", "status": RacerStatus.notRecorded},
    {
      "bib": "111",
      "name": "Rahim Uddin",
      "status": RacerStatus.finished,
      "time": "23:58:0",
    },
    {"bib": "112", "name": "Rahim Uddin", "status": RacerStatus.notRecorded},
    {"bib": "113", "name": "Rahim Uddin", "status": RacerStatus.notRecorded},
    {"bib": "114", "name": "Rahim Uddin", "status": RacerStatus.notRecorded},
    {"bib": "115", "name": "Rahim Uddin", "status": RacerStatus.dnf},
    {"bib": "116", "name": "Rahim Uddin", "status": RacerStatus.notRecorded},
    {
      "bib": "117",
      "name": "Rahim Uddin",
      "status": RacerStatus.finished,
      "time": "22:58:0",
    },
    {"bib": "118", "name": "Rahim Uddin", "status": RacerStatus.notRecorded},
    {"bib": "119", "name": "Farhan Ahmed", "status": RacerStatus.dns},
    {"bib": "120", "name": "Mim Akter", "status": RacerStatus.dns},
  ];

  List<Map<String, dynamic>> get _displayedRacers {
    if (_selectedTabIndex == 1) {
      return allRacers
          .where((r) => r["status"] == RacerStatus.finished)
          .toList();
    } else if (_selectedTabIndex == 2) {
      return allRacers.where((r) => r["status"] == RacerStatus.dnf).toList();
    } else if (_selectedTabIndex == 3) {
      return allRacers.where((r) => r["status"] == RacerStatus.dns).toList();
    }
    return allRacers;
  }

  Widget _buildTab(int index, String title) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColor.c2196F3 : Colors.transparent,
              width: 2.h,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextFontStyle.textStyle14InterW500.copyWith(
            color: isSelected ? Colors.white : AppColor.cD5D6D6,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12.w,
          height: 12.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextFontStyle.textStyle14InterW400.copyWith(
            color: AppColor.cD5D6D6,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalCount = allRacers.length;
    int finishedCount = allRacers
        .where((r) => r["status"] == RacerStatus.finished)
        .length;
    int dnfCount = allRacers
        .where((r) => r["status"] == RacerStatus.dnf)
        .length;
    int dnsCount = allRacers
        .where((r) => r["status"] == RacerStatus.dns)
        .length;

    return Scaffold(
      backgroundColor: AppColor.blackColor,
      appBar: ProfileAppBar(
        title: "All Racers",
        onBackTap: () {
          NavigationService.goBack();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 20.w,
                right: 20.w,
                top: 10.h,
                bottom: 100.h,
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
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "00: 12: 45",
                            style: TextFontStyle.textStyle24RobotoW600.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Race in Progress",
                            style: TextFontStyle.textStyle14InterW400.copyWith(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(20),

                  // Search Field
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1E293B).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search racer",
                        hintStyle: TextFontStyle.textStyle14InterW400.copyWith(
                          color: AppColor.c707171,
                        ),
                        prefixIcon: Icon(Icons.search, color: AppColor.c707171),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(20),
                  // Tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTab(0, "All Racers ($totalCount)"),
                      _buildTab(1, "Finished ($finishedCount)"),
                      _buildTab(2, "DNF($dnfCount)"),
                      _buildTab(3, "DNS($dnsCount)"),
                    ],
                  ),
                  UIHelper.verticalSpace(16),

                  // Racers Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.zero, // This removes the default extra space
                    itemCount: _displayedRacers.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8.w,
                      mainAxisSpacing: 8.h,
                      childAspectRatio: 0.90,
                    ),
                    itemBuilder: (context, index) {
                      final racer = _displayedRacers[index];
                      return RacerGridCard(
                        bib: racer["bib"],
                        name: racer["name"],
                        status: racer["status"],
                        showBib: false,
                      );
                    },
                  ),
                  // UIHelper.verticalSpace(20),

                  // Legend
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLegendItem(const Color(0xFF4CAF50), "Finished"),
                        _buildLegendItem(const Color(0xFF9C6A14), "DNF"),
                        _buildLegendItem(const Color(0xFF5E35B1), "DNS"),
                        _buildLegendItem(
                          const Color(0xFF2A2E3D),
                          "Not Recorded",
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(24),
                  // Live Results Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Live result",
                        style: TextFontStyle.textStyle16InterW600,
                      ),
                      Text(
                        "See all",
                        style: TextFontStyle.textStyle14InterW400.copyWith(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(12),
                  // Live Results List
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: const Color(0xFF1E293B)),
                    ),
                    child: Column(
                      children: [
                        // List Header
                        Container(
                          color: Color(0xFF1E3A5F),
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          child: Row(
                            children: [
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
                              Expanded(
                                flex: 2,
                                child: Center(
                                  child: Text(
                                    "Time",
                                    style: TextFontStyle.textStyle14InterW500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Text(
                                "Action",
                                style: TextFontStyle.textStyle14InterW500,
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: allRacers
                              .where((r) => r["status"] == RacerStatus.finished)
                              .length,
                          separatorBuilder: (context, index) => const Divider(
                            color: Color(0xFF1E293B),
                            height: 1,
                            thickness: 1,
                          ),
                          itemBuilder: (context, index) {
                            final finishedRacers = allRacers
                                .where(
                                  (r) => r["status"] == RacerStatus.finished,
                                )
                                .toList();
                            final racer = finishedRacers[index];
                            return LiveResultListItem(
                              bib: racer["bib"],
                              name: "John doe",
                              clock: racer["time"],
                              onEdit: () {},
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContainerWidgets(title: "Live results \nView Update"),
                        ContainerWidgets(title: "Live results \nView Update"),
                        ContainerWidgets(title: "Live results \nView Update"),
                        ContainerWidgets(title: "Live results \nView Update"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
