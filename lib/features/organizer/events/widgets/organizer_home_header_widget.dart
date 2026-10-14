import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aarongonzales01/features/user/profile/presentation/profile_screen.dart';

class OrganizerEventHeader extends StatelessWidget {
  const OrganizerEventHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),

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
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage(
                          'assets/images/organizer_img.png',
                        ),
                      ),

                      const SizedBox(width: 12),

                      /// Texts
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Hello Organizer",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Manage your running events",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
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
                    onTap: () {},
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

                  /// Notification icon with circle bg
                  Container(
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
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
