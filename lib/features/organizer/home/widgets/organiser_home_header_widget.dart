import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/assets_helper/app_images.dart';
import 'package:aarongonzales01/features/user/profile/model/get_user_info_model.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class OrganiserHomeHeaderWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? image;
  final VoidCallback onTap;
  final VoidCallback onTapNotification;

  const OrganiserHomeHeaderWidget({
    super.key,
    this.image,
    required this.onTap,
    required this.onTapNotification,
  });

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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetUserInfoModel>(
      stream: getUserInfoRxObj.dataFetcher.stream,
      initialData: getUserInfoRxObj.dataFetcher.valueOrNull,
      builder: (context, snapshot) {
        final isLoading = !snapshot.hasData;
        final user = snapshot.data?.data?.user;

        final displayName =
            (user?.firstName?.isNotEmpty == true
                ? user!.firstName!
                : user?.username) ??
            '';

        final userRole = (user?.role?.isNotEmpty == true)
            ? user!.role![0].toUpperCase() + user.role!.substring(1)
            : 'Organiser';
        final userLocation = (user?.location?.isNotEmpty == true)
            ? user!.location!
            : 'Dhaka Runners Club';
        final subtitleText = "$userRole, $userLocation";
        final avatarUrl = user?.avatar;

        return AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: GestureDetector(
                onTap: onTap,
                child: Row(
                  children: [
                    if (isLoading)
                      _shimmerCircle(25.r)
                    else
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.cFFFFFF, width: 2),
                          image: DecorationImage(
                            image:
                                (avatarUrl != null &&
                                    avatarUrl.startsWith('http'))
                                ? NetworkImage(avatarUrl) as ImageProvider
                                : AssetImage(image ?? AppImages.organizer_img),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isLoading) ...[
                            _shimmerBox(width: 120.w, height: 18.h, radius: 6),
                            SizedBox(height: 6.h),
                            _shimmerBox(width: 160.w, height: 13.h, radius: 6),
                          ] else ...[
                            Text(
                              displayName,
                              style: TextFontStyle.textStyle24RobotoW600
                                  .copyWith(
                                    color: AppColor.cFFFFFF,
                                    fontSize: 20.sp,
                                  ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              subtitleText,
                              style: TextFontStyle.textStyle14InterW400
                                  .copyWith(
                                    color: AppColor.cD5D6D6,
                                    fontSize: 13.sp,
                                  ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: onTapNotification,
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: AppColor.c282828,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/images/notification.png',
                          width: 24.w,
                          height: 24.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h);
}
