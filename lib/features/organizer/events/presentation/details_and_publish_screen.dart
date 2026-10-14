import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/event_chip_widget.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/event_detail_item_widget.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/event_info_card_widget.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/features/organizer/events/model/event_details_model.dart';
import 'package:aarongonzales01/helpers/dateuitl.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';

class DetailsAndPublishScreen extends StatefulWidget {
  const DetailsAndPublishScreen({super.key});

  @override
  State<DetailsAndPublishScreen> createState() =>
      _DetailsAndPublishScreenState();
}

class _DetailsAndPublishScreenState extends State<DetailsAndPublishScreen> {
  String? _slug;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String && _slug == null) {
      _slug = args;
      eventDetailsRxObj.fetchEventDetails(_slug!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: ProfileAppBar(
          title: "Event Details",
          onBackTap: () {
            Navigator.pop(context);
          },
        ),
        body: ValueListenableBuilder<bool>(
          valueListenable: eventDetailsRxObj.isLoading,
          builder: (context, isLoading, child) {
            if (isLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColor.c2196F3),
              );
            }

            return StreamBuilder<EventDetailsModel>(
              stream: eventDetailsRxObj.getEventDetailsData,
              builder: (context, snapshot) {
                final event = snapshot.data?.data;

                if (event == null) {
                  return Center(
                    child: Text(
                      "No event details found",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 16.sp,
                      ),
                    ),
                  );
                }

                String getStatus(Data ev) {
                  final s = ev.status ?? "";
                  if (s.isEmpty) return "";
                  return s[0].toUpperCase() + s.substring(1).toLowerCase();
                }

                String getFormattedDate(Data ev) {
                  if (ev.startDate == null) return "";
                  return DateFormatedUtils.getFormatedDate(
                    ev.startDate!,
                    "d MMMM yyyy/hh:mm a",
                  );
                }

                String getDistance(Data ev) {
                  final d = ev.distanceMeters;
                  if (d == null || d.isEmpty) return "Not specified";
                  final meters = double.tryParse(d);
                  if (meters != null) {
                    if (meters >= 1000) {
                      final km = meters / 1000;
                      return "${km.toStringAsFixed(km == km.roundToDouble() ? 0 : 1)}K";
                    }
                    return "${meters.toInt()}m";
                  }
                  return d;
                }

                String? accessCode;
                for (var ticket in (event.tickets ?? [])) {
                  if (ticket.accessCodeEnabled == true &&
                      ticket.accessCode != null &&
                      ticket.accessCode!.isNotEmpty) {
                    accessCode = ticket.accessCode;
                    break;
                  }
                }

                final eventUrl = "https://racerealm.com/events/${event.slug}";

                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                event.title ?? "Untitled Event",
                                style: TextFontStyle.textStyle24RobotoW600
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 22.sp,
                                    ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                NavigationService.navigateTo(
                                  Routes.updateEventScreen,
                                  arguments: event,
                                );
                              },
                              child: Icon(
                                Icons.edit_outlined,
                                color: AppColor.c2196F3,
                                size: 24.sp,
                              ),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(25.h),
                        EventDetailItemWidget(
                          icon: Icons.calendar_today_outlined,
                          label: "Date & Time",
                          value: getFormattedDate(event),
                        ),
                        UIHelper.verticalSpace(18.h),
                        EventDetailItemWidget(
                          icon: Icons.category_outlined,
                          label: "Category",
                          value: event.category?.name ?? "Not specified",
                        ),
                        UIHelper.verticalSpace(18.h),
                        EventDetailItemWidget(
                          icon: Icons.circle_outlined,
                          label: "Status",
                          value: getStatus(event),
                        ),
                        UIHelper.verticalSpace(18.h),
                        EventDetailItemWidget(
                          icon: Icons.location_on_outlined,
                          label: "Location",
                          value: event.locationName ?? "Not specified",
                        ),
                        UIHelper.verticalSpace(18.h),
                        EventDetailItemWidget(
                          icon: Icons.group_outlined,
                          label: "Distance",
                          value: getDistance(event),
                        ),
                        UIHelper.verticalSpace(10.h),
                        Divider(
                          color: AppColor.cEDEEF0.withValues(alpha: 0.3),
                          thickness: 1.h,
                        ),
                        UIHelper.verticalSpace(10.h),
                        Text(
                          "Description",
                          style: TextFontStyle.textStyle14InterW400.copyWith(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          event.description ?? "No description provided.",
                          style: TextFontStyle.textStyle14InterW400.copyWith(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                        if (accessCode != null) ...[
                          UIHelper.verticalSpace(30.h),
                          Text(
                            "Access Code",
                            style: TextFontStyle.textStyle14InterW400.copyWith(
                              color: Colors.white70,
                              fontSize: 14.sp,
                            ),
                          ),
                          UIHelper.verticalSpace(8.h),
                          Builder(
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1C252E),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: Colors.white10),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      accessCode!,
                                      style: TextFontStyle.textStyle16InterW600
                                          .copyWith(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                          ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Clipboard.setData(
                                          ClipboardData(text: accessCode!),
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Access code copied to clipboard",
                                            ),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8.w),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.05,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.copy_outlined,
                                          color: AppColor.c2196F3,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                        if (event.tickets != null &&
                            event.tickets!.isNotEmpty) ...[
                          UIHelper.verticalSpace(16.h),
                          EventInfoCardWidget(
                            icon: Icons.confirmation_number_outlined,
                            title: "Tickets",
                            content: Column(
                              children: event.tickets!.map((ticket) {
                                final priceStr = ticket.isFree == true
                                    ? "Free"
                                    : "\$${ticket.price ?? '0'}";
                                final quantityStr =
                                    "Quantity: ${ticket.quantity ?? 0} • ${ticket.minPerUser ?? 1}-${ticket.maxPerUser ?? 1} per user";

                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: event.tickets!.last == ticket
                                        ? 0
                                        : 10.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ticket.name ?? "Standard Ticket",
                                              style: TextFontStyle
                                                  .textStyle14InterW500
                                                  .copyWith(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                  ),
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              quantityStr,
                                              style: TextFontStyle
                                                  .textStyle14InterW400
                                                  .copyWith(
                                                    color: Colors.white70,
                                                    fontSize: 12.sp,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        priceStr,
                                        style: TextFontStyle
                                            .textStyle16InterW600
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                            ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                        if (event.requiredAttendeeInfo != null &&
                            event.requiredAttendeeInfo!.isNotEmpty) ...[
                          UIHelper.verticalSpace(15.h),
                          EventInfoCardWidget(
                            icon: Icons.assignment_outlined,
                            title: "Attendee Information",
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Required Fields:",
                                  style: TextFontStyle.textStyle14InterW400
                                      .copyWith(
                                        color: Colors.white70,
                                        fontSize: 12.sp,
                                      ),
                                ),
                                UIHelper.verticalSpace(10.h),
                                Wrap(
                                  spacing: 8.w,
                                  runSpacing: 8.h,
                                  children: event.requiredAttendeeInfo!.map((
                                    info,
                                  ) {
                                    return EventChipWidget(
                                      label: info.label ?? info.key ?? "",
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                        UIHelper.verticalSpace(16.h),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 14.h,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1C252E),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: Colors.white10),
                                ),
                                child: Text(
                                  eventUrl,
                                  style: TextFontStyle.textStyle14InterW400
                                      .copyWith(
                                        color: Colors.white70,
                                        fontSize: 14.sp,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            UIHelper.horizontalSpace(10.w),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(text: eventUrl),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Link copied to clipboard"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.05),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.copy_outlined,
                                  color: AppColor.c2196F3,
                                  size: 22.sp,
                                ),
                              ),
                            ),
                            UIHelper.horizontalSpace(10.w),
                            GestureDetector(
                              onTap: () {
                                // Add share logic if needed
                              },
                              child: Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.05),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.ios_share,
                                  color: AppColor.c2196F3,
                                  size: 22.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
