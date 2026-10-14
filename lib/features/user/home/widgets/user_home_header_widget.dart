// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/common_widgets/profile_avatar.dart';
import 'package:aarongonzales01/features/user/home/presentation/notifications_screen.dart';
import 'package:aarongonzales01/features/user/home/presentation/search_races_screen.dart';
import 'package:aarongonzales01/features/user/profile/model/get_user_info_model.dart';
import 'package:aarongonzales01/features/user/profile/presentation/profile_screen.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class UserHomeHeader extends StatefulWidget {
  const UserHomeHeader({super.key});

  @override
  State<UserHomeHeader> createState() => _UserHomeHeaderState();
}

class _UserHomeHeaderState extends State<UserHomeHeader> {
  String _greetingText() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  void initState() {
    super.initState();
    // Refresh on every visit so avatar/name are always current
    getUserInfoRxObj.fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetUserInfoModel>(
      stream: getUserInfoRxObj.dataFetcher.stream,
      initialData: getUserInfoRxObj.dataFetcher.valueOrNull,
      builder: (context, snapshot) {
        final user = snapshot.data?.data?.user;
        final isLoading = !snapshot.hasData;
        final displayName =
            (user?.firstName?.isNotEmpty == true
                ? user!.firstName!
                : user?.username) ??
            '';

        return Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Stack(
            children: [
              /// Main Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const ProfileScreen());
                      },
                      child: Row(
                        children: [
                          /// Profile Image
                          if (isLoading)
                            _shimmerCircle(24)
                          else
                            ProfileAvatar(imageUrl: user?.avatar, radius: 24),

                          const SizedBox(width: 12),

                          /// Texts
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isLoading) ...[
                                  _shimmerBox(width: 100, height: 18, radius: 6),
                                  const SizedBox(height: 6),
                                  _shimmerBox(width: 80, height: 13, radius: 6),
                                ] else ...[
                                  Text(
                                    displayName.isNotEmpty
                                        ? 'Hello $displayName'
                                        : 'Hello',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _greetingText(),
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Icons
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SearchRacesScreen());
                        },
                        child: Image.asset(
                          'assets/images/search.png',
                          width: 24,
                          height: 24,
                        ),
                      ),

                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          'assets/images/location.png',
                          width: 24,
                          height: 24,
                        ),
                      ),

                      const SizedBox(width: 12),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/notification.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _shimmerCircle(double radius) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1E2830),
      highlightColor: const Color(0xFF2E3C4A),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: const Color(0xFF1E2830),
      ),
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF1E2830),
      highlightColor: const Color(0xFF2E3C4A),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: const Color(0xFF1E2830),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
