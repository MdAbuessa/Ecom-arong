import 'dart:async';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/assets_helper/app_icons.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/organizer/race%20timer/widgets/container_widgets.dart';
import 'package:aarongonzales01/features/organizer/race%20timer/widgets/live_result_list_item.dart';
import 'package:aarongonzales01/features/organizer/race%20timer/widgets/racer_grid_card.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AllRecersRecordScreen extends StatefulWidget {
  const AllRecersRecordScreen({super.key});

  @override
  State<AllRecersRecordScreen> createState() => _AllRecersRecordScreenState();
}

class _AllRecersRecordScreenState extends State<AllRecersRecordScreen> {
  int _selectedTabIndex = 0;
  int _timerState = 0; // 0: running, 1: show button, 2: ended

  Timer? _timer;
  int _secondsElapsed = 0;
  bool liveShow = false;
  bool seeAllLiveResults = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _getFormattedTime() {
    int hours = _secondsElapsed ~/ 3600;
    int minutes = (_secondsElapsed % 3600) ~/ 60;
    int seconds = _secondsElapsed % 60;
    return "${hours.toString().padLeft(2, '0')}: ${minutes.toString().padLeft(2, '0')}: ${seconds.toString().padLeft(2, '0')}";
  }

  void _showSingleFieldEditDialog(
    String title,
    String label,
    String initialValue,
    Function(String newValue) onUpdate,
  ) {
    final controller = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            padding: EdgeInsets.all(20.w),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 24),
                    Text(
                      title,
                      style: TextFontStyle.textStyle16InterW600.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.close, color: Colors.white),
                    ),
                  ],
                ),
                UIHelper.verticalSpace(20),

                // Field Label
                Text(
                  label,
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    color: Colors.white70,
                  ),
                ),
                UIHelper.verticalSpace(8),

                // Text Field Input
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF141D26).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFF2E3E50)),
                  ),
                  child: TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(24),

                // Update Button
                GestureDetector(
                  onTap: () {
                    onUpdate(controller.text);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: AppColor.c2196F3,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Center(
                      child: Text(
                        "Update",
                        style: TextFontStyle.textStyle16InterW600.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRacerEditDialog(Map<String, dynamic> racer) {
    RacerStatus selectedStatus = racer["status"];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Widget buildStatusOption(
              RacerStatus status,
              String label,
              Color color,
            ) {
              bool isSelected = selectedStatus == status;
              return GestureDetector(
                onTap: () {
                  setDialogState(() {
                    selectedStatus = status;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF202938),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isSelected ? AppColor.c2196F3 : Colors.transparent,
                      width: 1.5.w,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 14.w,
                        height: 14.w,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        label,
                        style: TextFontStyle.textStyle16InterW600.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            Widget buildEditRow(String label, {VoidCallback? onEdit}) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: TextFontStyle.textStyle14InterW400.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: onEdit,
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1E293B),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          AppIcons.edit,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            return Dialog(
              backgroundColor: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Container(
                padding: EdgeInsets.all(20.w),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 24),
                        Text(
                          "Bib: ${racer["bib"] ?? 'N/A'}",
                          style: TextFontStyle.textStyle16InterW600.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.close, color: Colors.white),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(20),

                    // Status Choices
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: buildStatusOption(
                              RacerStatus.finished,
                              "Finished",
                              const Color(0xFF4CAF50),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: buildStatusOption(
                              RacerStatus.dnf,
                              "DNF",
                              const Color(0xFF9C6A14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 4.w),
                            child: buildStatusOption(
                              RacerStatus.dns,
                              "DNS",
                              const Color(0xFF5E35B1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: buildStatusOption(
                              RacerStatus.notRecorded,
                              "Not Recorded",
                              const Color(0xFF2A2E3D),
                            ),
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(20),

                    // Edit Options
                    buildEditRow(
                      "Edit Bib",
                      onEdit: () {
                        _showSingleFieldEditDialog(
                          "Edit Bib",
                          "Bib Number",
                          racer["bib"] ?? "",
                          (newValue) {
                            setState(() {
                              racer["bib"] = newValue;
                            });
                            setDialogState(() {});
                          },
                        );
                      },
                    ),
                    buildEditRow(
                      "Edit Racer Name",
                      onEdit: () {
                        _showSingleFieldEditDialog(
                          "Edit Racer Name",
                          "Racer Name",
                          racer["name"] ?? "",
                          (newValue) {
                            setState(() {
                              racer["name"] = newValue;
                            });
                            setDialogState(() {});
                          },
                        );
                      },
                    ),
                    buildEditRow(
                      "Edit Time",
                      onEdit: () {
                        _showSingleFieldEditDialog(
                          "Edit Time",
                          "Time",
                          racer["time"] ?? "--:--:--",
                          (newValue) {
                            setState(() {
                              racer["time"] = newValue;
                            });
                            setDialogState(() {});
                          },
                        );
                      },
                    ),
                    UIHelper.verticalSpace(24),

                    // Record Button
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          racer["status"] = selectedStatus;
                          if (selectedStatus == RacerStatus.finished) {
                            if (racer["time"] == null) {
                              racer["time"] = _getFormattedTime();
                            }
                          } else {
                            racer.remove("time");
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        decoration: BoxDecoration(
                          color: AppColor.c2196F3,
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: Center(
                          child: Text(
                            "Record",
                            style: TextFontStyle.textStyle16InterW600.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

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
          NavigationService.goBack;
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
                    child: GestureDetector(
                      onTap: () {
                        if (_timerState == 0) {
                          setState(() {
                            _timerState = 1;
                          });
                        } else if (_timerState == 1) {
                          setState(() {
                            _timerState = 2;
                            _timer?.cancel();
                          });
                        }
                      },
                      child: Container(
                        width: 200.w,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          color: _timerState == 1
                              ? AppColor.cD64545
                              : AppColor.c2196F3,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: _timerState == 1
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 16.w,
                                    height: 16.w,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(2.r),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "End Race",
                                    style: TextFontStyle.textStyle24RobotoW600
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                        ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    _getFormattedTime(),
                                    style: TextFontStyle.textStyle24RobotoW600
                                        .copyWith(color: Colors.white),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    _timerState == 2
                                        ? "Race Ended"
                                        : "Race in Progress",
                                    style: TextFontStyle.textStyle14InterW400
                                        .copyWith(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                  UIHelper.verticalSpace(20),

                  // Search Field
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: "Search racer",
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
                        onTap: () {
                          _showRacerEditDialog(racer);
                        },
                        bib: racer["bib"],
                        name: racer["name"],
                        status: racer["status"],
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
                        _buildLegendItem(Color(0xFF4CAF50), "Finished"),
                        _buildLegendItem(Color(0xFF9C6A14), "DNF"),
                        _buildLegendItem(Color(0xFF5E35B1), "DNS"),
                        _buildLegendItem(Color(0xFF2A2E3D), "Not Recorded"),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(24),

                  if (liveShow == true) ...[
                    // Live Results Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Live result",
                          style: TextFontStyle.textStyle16InterW600,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              seeAllLiveResults = !seeAllLiveResults;
                            });
                          },
                          child: Text(
                            seeAllLiveResults ? "See less" : "See all",
                            style: TextFontStyle.textStyle14InterW400.copyWith(
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white,
                            ),
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
                            color: const Color(0xFF1E3A5F),
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
                          // List Items (show 5 initially, show all when seeAllLiveResults is true)
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: seeAllLiveResults
                                ? allRacers.length
                                : (allRacers.length > 5 ? 5 : allRacers.length),
                            separatorBuilder: (context, index) => Divider(
                              color: Color(0xFF1E293B),
                              height: 1,
                              thickness: 1,
                            ),
                            itemBuilder: (context, index) {
                              final racer = allRacers[index];
                              return LiveResultListItem(
                                bib: racer["bib"],
                                name: racer["name"],
                                clock: racer["time"] ?? "--:--:--",
                                onEdit: () {
                                  _showRacerEditDialog(racer);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    UIHelper.verticalSpace(20),
                  ],

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContainerWidgets(
                          title: "Live results \nView Update",
                          onCall: () {
                            setState(() {
                              liveShow = !liveShow;
                            });
                          },
                        ),
                        ContainerWidgets(title: "Timing mode \nView Update"),
                        ContainerWidgets(title: "Restart race \nFalse start"),
                        ContainerWidgets(title: "Finish race\n completed"),
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
