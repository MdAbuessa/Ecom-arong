import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_save_button.dart';
import 'package:aarongonzales01/features/organizer/home/widgets/home_stat_card_widget.dart';
import 'package:aarongonzales01/features/organizer/home/widgets/organiser_home_header_widget.dart';
import 'package:aarongonzales01/features/organizer/home/widgets/recent_event_card_widget.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/features/organizer/home/model/event_list_model.dart';
import 'package:aarongonzales01/helpers/dateuitl.dart';

class OrganizerHomeScreen extends StatefulWidget {
  const OrganizerHomeScreen({super.key});

  @override
  State<OrganizerHomeScreen> createState() => _OrganizerHomeScreenState();
}

class _OrganizerHomeScreenState extends State<OrganizerHomeScreen> {
  @override
  void initState() {
    super.initState();
    eventListRxObj.fetchEventList();
    getUserInfoRxObj.fetchUserInfo();
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
        backgroundColor: const Color(0xFF061115),
        appBar: OrganiserHomeHeaderWidget(
          onTap: () {
            NavigationService.navigateTo(Routes.organiserProfileScreen);
          },
          onTapNotification: () {
            NavigationService.navigateTo(Routes.notificationOrganizerScreen);
          },
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Grid for stats
                    Row(
                      children: [
                        Expanded(
                          child: HomeStatCardWidget(
                            title: "Total Events",
                            value: "12",
                            icon: Icons.calendar_today_outlined,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: HomeStatCardWidget(
                            title: "Participants",
                            value: "340",
                            icon: Icons.people_outline,
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(12),
                    Row(
                      children: [
                        Expanded(
                          child: HomeStatCardWidget(
                            title: "Total Revenue",
                            value: "12",
                            icon: Icons.attach_money,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: HomeStatCardWidget(
                            title: "Total Sell",
                            value: "150",
                            icon: Icons.trending_up,
                          ),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(32),

                    // Recent Events Section Header
                    StreamBuilder<EventListModel>(
                      stream: eventListRxObj.getEventListData,
                      builder: (context, snapshot) {
                        final events = snapshot.data?.data?.events ?? [];
                        final showSeeAll = events.length > 3;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Recent Events",
                                  style: TextFontStyle.textStyle14InterW500
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                if (showSeeAll)
                                  GestureDetector(
                                    onTap: () {
                                      NavigationService.navigateTo(
                                        Routes.allRecentEventsScreen,
                                      );
                                    },
                                    child: Text(
                                      "See all",
                                      style: TextFontStyle.textStyle14InterW400
                                          .copyWith(
                                            color: AppColor.cFFFFFF,
                                            fontSize: 12.sp,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: AppColor.cFFFFFF,
                                          ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            ValueListenableBuilder<bool>(
                              valueListenable: eventListRxObj.isLoading,
                              builder: (context, isLoading, child) {
                                if (isLoading) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 40.h,
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColor.c2196F3,
                                      ),
                                    ),
                                  );
                                }

                                if (events.isEmpty) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 40.h,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "No events found",
                                        style: TextStyle(
                                          color: Colors.white.withValues(
                                            alpha: 0.6,
                                          ),
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: events.length > 4
                                      ? 4
                                      : events.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    final event = events[index];

                                    String getStatus(Event ev) {
                                      final s = ev.status ?? "";
                                      if (s.isEmpty) return "";
                                      return s[0].toUpperCase() +
                                          s.substring(1).toLowerCase();
                                    }

                                    String getRevenue(Event ev) {
                                      final priceVal = ev.ticketPrice;
                                      if (priceVal == null) return "\$0";
                                      final double? price = double.tryParse(
                                        priceVal.toString(),
                                      );
                                      if (price == null) return "\$0";
                                      final int participants =
                                          ev.totalParticipant ?? 0;
                                      final revenue = price * participants;
                                      if (revenue == revenue.roundToDouble()) {
                                        return "\$${revenue.toInt()}";
                                      } else {
                                        return "\$${revenue.toStringAsFixed(2)}";
                                      }
                                    }

                                    String getFormattedDate(Event ev) {
                                      if (ev.startDate == null) return "";
                                      return DateFormatedUtils.getFormatedDate(
                                        ev.startDate!,
                                        "d MMM",
                                      );
                                    }

                                    return RecentEventCardWidget(
                                      onTap: () {
                                        NavigationService.navigateTo(
                                          Routes.detailsAndPublishScreen,
                                          arguments: event.slug,
                                        );
                                      },
                                      title: event.title ?? "Untitled Event",
                                      status: getStatus(event),
                                      date: getFormattedDate(event),
                                      participants:
                                          (event.totalParticipant ?? 0)
                                              .toString(),
                                      revenue: getRevenue(event),
                                      onDeleteTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            backgroundColor: const Color(
                                              0xFF0F1B2A,
                                            ),
                                            title: const Text(
                                              "Delete Event",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            content: const Text(
                                              "Are you sure you want to delete this event?",
                                              style: TextStyle(
                                                color: Colors.white70,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(ctx),
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(ctx);
                                                  final success =
                                                      await eventDeleteRxObj
                                                          .deleteEventRx(
                                                            event.slug!,
                                                          );
                                                  if (success) {
                                                    eventListRxObj
                                                        .fetchEventList();
                                                  }
                                                },
                                                child: const Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomSaveButton(
                onCall: () {
                  _showRaceTimerDialog(context);
                },
                btnText: "Race Timer",
                btnColor: AppColor.c2196F3,
              ),
            ),
            UIHelper.verticalSpace(120.h),
          ],
        ),
      ),
    );
  }

  void _showRaceTimerDialog(BuildContext context) {
    String selectedEvent = "(SK City Run)";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 24.w), // Balance the row
                        Text(
                          "Race Timer",
                          style: TextFontStyle.textStyle16InterW600,
                        ),
                        GestureDetector(
                          onTap: () => NavigationService.goBack,
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "Select Event",
                      style: TextFontStyle.textStyle14InterW500,
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF111827),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColor.c4B5563),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          dropdownColor: const Color(0xFF111827),
                          value: selectedEvent,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                          ),
                          items:
                              [
                                "(SK City Run)",
                                "(10K Marathon)",
                                "(Trail Run 15K)",
                                "(Fun Run 5K)",
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextFontStyle.textStyle14InterW400
                                        .copyWith(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setDialogState(() {
                                selectedEvent = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    CustomSaveButton(
                      onCall: () {
                        // NavigationService.goBack(); // close dialog
                        NavigationService.navigateTo(Routes.allRecersScreen);
                      },
                      btnText: "Next",
                      btnColor: AppColor.c2196F3,
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
}
