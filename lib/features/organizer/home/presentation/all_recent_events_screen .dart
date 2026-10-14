import 'dart:async';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/features/organizer/home/widgets/recent_event_card_widget.dart';
import 'package:aarongonzales01/features/organizer/home/widgets/custom_search_field.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/dateuitl.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/features/organizer/home/model/event_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllRecentEventsScreen extends StatefulWidget {
  const AllRecentEventsScreen({super.key});

  @override
  State<AllRecentEventsScreen> createState() => _AllRecentEventsScreenState();
}

class _AllRecentEventsScreenState extends State<AllRecentEventsScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Load first page of events with 20 items per page
    eventListRxObj.fetchEventList(query: "", perPage: 20);
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      eventListRxObj.fetchEventList(query: _searchController.text, perPage: 20);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      eventListRxObj.fetchEventList(
        query: _searchController.text,
        perPage: 20,
        isLoadMoreAction: true,
      );
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
      appBar: ProfileAppBar(
        title: "All Recent Events",
        onBackTap: () {
          NavigationService.goBack;
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0.w),
        child: Column(
          children: [
            CustomSearchField(
              hintText: "Search events",
              controller: _searchController,
            ),
            SizedBox(height: 16.h),
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
                              color: Colors.white.withValues(alpha: 0.6),
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
                                  participants: (event.totalParticipant ?? 0)
                                      .toString(),
                                  revenue: getRevenue(event),
                                  onDeleteTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        backgroundColor: const Color(0xFF0F1B2A),
                                        title: const Text(
                                          "Delete Event",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: const Text(
                                          "Are you sure you want to delete this event?",
                                          style: TextStyle(color: Colors.white70),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(ctx),
                                            child: const Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.pop(ctx);
                                              final success = await eventDeleteRxObj.deleteEventRx(event.slug!);
                                              if (success) {
                                                eventListRxObj.fetchEventList();
                                              }
                                            },
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
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
          ],
        ),
      ),
    );
  }
}
