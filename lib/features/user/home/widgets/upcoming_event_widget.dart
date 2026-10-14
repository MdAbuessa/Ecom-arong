import 'package:aarongonzales01/features/user/upcoming_events/presentation/upcoming_events_details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class UpcomingEventsSection extends StatefulWidget {
  const UpcomingEventsSection({super.key});

  @override
  State<UpcomingEventsSection> createState() => _UpcomingEventsSectionState();
}

class _UpcomingEventsSectionState extends State<UpcomingEventsSection> {
  final List<Map<String, dynamic>> events = [
    {
      "date": "15",
      "month": "Apr",
      "title": "5K City Run",
      "points": "50 pts",
      "image": "https://images.unsplash.com/photo-1551632811-561732d1e306",
    },
    {
      "date": "16",
      "month": "Apr",
      "title": "5K City Run",
      "points": "50 pts",
      "image": "https://images.unsplash.com/photo-1551632811-561732d1e306",
    },
    {
      "date": "17",
      "month": "Apr",
      "title": "5K City Run",
      "points": "50 pts",
      "image": "https://images.unsplash.com/photo-1551632811-561732d1e306",
    },
    {
      "date": "18",
      "month": "Apr",
      "title": "5K City Run",
      "points": "50 pts",
      "image": "https://images.unsplash.com/photo-1551632811-561732d1e306",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TITLE
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Upcoming Events",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 14),

          /// SUBTITLE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/coin.svg',
                  height: 12,
                  width: 12,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 4),
                Text(
                  "Earn Points & Spend in Shop",
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// CAROUSEL
          CarouselSlider.builder(
            itemCount: events.length,
            itemBuilder: (context, index, realIndex) {
              final event = events[index];

              return GestureDetector(
                onTap: () {
                  Get.to(UpcomingEventsDetailsScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// IMAGE CARD
                      Stack(
                        children: [
                          Container(
                            height: 105,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: NetworkImage(event["image"]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          /// BLUR BLUE EFFECT AT BOTTOM
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.6),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          /// DATE TAG
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xff1F2937),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    event["date"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    event["month"],
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      /// TITLE
                      Text(
                        event["title"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// POINTS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/images/coin.svg',
                            height: 12,
                            width: 12,
                            fit: BoxFit.cover,
                          ),

                          SizedBox(width: 4),
                          Text(
                            event["points"],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },

            options: CarouselOptions(
              height: 150,
              viewportFraction: 0.32,
              padEnds: false,
            ),
          ),
        ],
      ),
    );
  }
}
