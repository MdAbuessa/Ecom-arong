import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/user/club_details/presentation/club_details_screen.dart';
import 'package:aarongonzales01/features/user/social/model/get_club_list_model.dart';
import 'package:aarongonzales01/networks/api_acess.dart';

class ClubCard extends StatefulWidget {
  final Club club;

  const ClubCard({super.key, required this.club});

  @override
  State<ClubCard> createState() => _ClubCardState();
}

class _ClubCardState extends State<ClubCard> {
  late bool _isJoined;

  @override
  void initState() {
    super.initState();
    _isJoined = widget.club.isJoined ?? false;
  }

  @override
  void didUpdateWidget(covariant ClubCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isJoined = widget.club.isJoined ?? false;
  }

  ImageProvider _getImageProvider(String? path) {
    if (path == null || path.isEmpty) {
      return const AssetImage('assets/images/placeholder.jpg');
    }
    if (path.startsWith('assets/')) {
      return AssetImage(path);
    }
    if (path.startsWith('http')) {
      return NetworkImage(path);
    }
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return NetworkImage("https://admin.racerealm.com/$cleanPath");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.club.slug != null) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(color: AppColor.c2196F3),
            ),
          );
          final model = await clubDetailsRxObj.getClubDetails(widget.club.slug!);
          if (context.mounted) {
            Navigator.pop(context); // Dismiss loading dialog
            if (model != null) {
              Get.to(() => ClubDetailsScreen(clubModel: model));
            }
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF131E30), // Dark card background
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: _getImageProvider(widget.club.avatarUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.club.name ?? "",
                    style: TextFontStyle.textStyle16InterW600.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    widget.club.description ?? widget.club.topic?.name ?? "",
                    style: TextFontStyle.textStyle14InterW400.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 13.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${widget.club.totalMembers ?? 0}',
                        style: TextFontStyle.textStyle14InterW500.copyWith(
                          color: Colors.white,
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.white.withValues(alpha: 0.6),
                        size: 16.sp,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          widget.club.location ?? "",
                          style: TextFontStyle.textStyle14InterW400.copyWith(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 13.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  if (widget.club.topic?.name != null)
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A2540),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            widget.club.topic!.name!,
                            style: TextFontStyle.textStyle14InterW400.copyWith(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    height: 40.h,
                    child: OutlinedButton(
                      onPressed: () async {
                        if (widget.club.slug != null) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.c2196F3,
                              ),
                            ),
                          );
                          final res = await joinClubRxObj.joinClub(
                            widget.club.slug!,
                          );
                          if (context.mounted) {
                            Navigator.pop(context); // Dismiss loading dialog
                            if (res != null && res.success == true) {
                              setState(() {
                                _isJoined = res.data?.isJoined ?? !_isJoined;
                              });
                            }
                          }
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColor.c2196F3, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      child: Text(
                        _isJoined ? 'Joined Club' : 'Join Club',
                        style: TextFontStyle.textStyle12UrbanistW600.copyWith(
                          color: AppColor.c2196F3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
