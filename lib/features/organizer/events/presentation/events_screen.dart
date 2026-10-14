import 'dart:async';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/assets_helper/app_icons.dart';
import 'package:aarongonzales01/common_widgets/custom_save_button.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/delete_event_dialog_widget.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/event_status_card_widget.dart';
import 'package:aarongonzales01/features/organizer/home/widgets/custom_search_field.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:aarongonzales01/helpers/dateuitl.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/features/organizer/home/model/event_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ["Publish", "Draft"];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchEvents();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _fetchEvents(isLoadMore: true);
    }
  }

  void _fetchEvents({bool isLoadMore = false}) {
    String? status;
    if (_selectedTab == 0) {
      status = "publish";
    } else if (_selectedTab == 1) {
      status = "draft";
    }

    eventListRxObj.fetchEventList(
      query: _searchController.text,
      status: status,
      perPage: 20,
      isLoadMoreAction: isLoadMore,
    );
  }

  void _onTabChanged(int index) {
    setState(() {
      _selectedTab = index;
    });
    _fetchEvents();
  }

  Future<void> _editEvent(String slug) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: AppColor.c2196F3),
      ),
    );

    try {
      await eventDetailsRxObj.fetchEventDetails(slug);
      final details = eventDetailsRxObj.dataFetcher.value;
      if (mounted) {
        Navigator.pop(context); // Dismiss loading dialog
        if (details.data != null) {
          NavigationService.navigateTo(
            Routes.updateEventScreen,
            arguments: details.data,
          );
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Dismiss loading dialog
      }
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      appBar: ProfileAppBar(title: "My Events"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSearchField(
              hintText: "Search events",
              controller: _searchController,
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(_tabs.length, (index) {
                return GestureDetector(
                  onTap: () => _onTabChanged(index),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: _selectedTab == index
                          ? AppColor.c2196F3
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      _tabs[index],
                      style: TextFontStyle.textStyle16InterW600.copyWith(
                        color: _selectedTab == index
                            ? Colors.white
                            : Colors.white70,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: eventListRxObj.isLoading,
                builder: (context, isLoading, child) {
                  if (isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.c2196F3),
                    );
                  }
                  return StreamBuilder<EventListModel>(
                    stream: eventListRxObj.getEventListData,
                    builder: (context, snapshot) {
                      final events = snapshot.data?.data?.events ?? [];

                      if (events.isEmpty) {
                        return Center(
                          child: Text(
                            "No events found",
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 16.sp,
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: events.length,
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

                                return EventStatusCardWidget(
                                  onTapEdit: () => _editEvent(event.slug!),
                                  onTapDelete: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return DeleteEventDialogWidget(
                                          onConfirmDelete: () {
                                            Navigator.pop(
                                              context,
                                            ); // Close dialog
                                            eventDeleteRxObj
                                                .deleteEventRx(event.slug!)
                                                .then((success) {
                                                  if (success) {
                                                    _fetchEvents();
                                                  }
                                                });
                                          },
                                        );
                                      },
                                    );
                                  },
                                  onTapViewDetails: () {
                                    NavigationService.navigateTo(
                                      Routes.detailsAndPublishScreen,
                                      arguments: event.slug,
                                    );
                                  },
                                  title: event.title ?? "Untitled Event",
                                  location: event.location ?? "Not specified",
                                  date: getFormattedDate(event),
                                  participants: (event.totalParticipant ?? 0)
                                      .toString(),
                                  revenue: getRevenue(event),
                                  status: getStatus(event),
                                  progress:
                                      (event.completeParcentage ?? 0) / 100.0,
                                );
                              },
                            ),
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: eventListRxObj.isLoadMore,
                            builder: (context, isLoadMore, child) {
                              if (isLoadMore) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColor.c2196F3,
                                    ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            if (_selectedTab == 0)
              CustomSaveButton(
                btnText: 'Create Event', 
                icon: AppIcons.plus,
                onCall: () {
                  NavigationService.navigateTo(Routes.createEventScreen);
                },
              ),
            UIHelper.verticalSpace(100.h),
          ],
        ),
      ),
    );
  }
}
