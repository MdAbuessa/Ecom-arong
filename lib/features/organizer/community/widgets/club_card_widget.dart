import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aarongonzales01/features/organizer/community/model/club_list_model.dart';

class ClubCardWidget extends StatefulWidget {
  final String title;
  final String location;
  final String members;
  final String events;
  final String image;
  final VoidCallback onViewDetails;
  final VoidCallback onEdit;
  final Future<void> Function() onDelete;
  final String? description;
  final List<SocialLink>? socialLinks;

  const ClubCardWidget({
    super.key,
    required this.title,
    required this.location,
    required this.members,
    required this.events,
    required this.image,
    required this.onViewDetails,
    required this.onEdit,
    required this.onDelete,
    this.description,
    this.socialLinks,
  });

  @override
  State<ClubCardWidget> createState() => _ClubCardWidgetState();
}

class _ClubCardWidgetState extends State<ClubCardWidget> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2128), // Dark navy card color
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextFontStyle.textStyle16InterW600.copyWith(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: AppColor.c797A7C,
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          widget.location,
                          style: TextFontStyle.textStyle14InterW400.copyWith(
                            color: AppColor.c797A7C,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.only(left: 60.w), // Align with text
            child: Row(
              children: [
                Icon(
                  Icons.people_outline,
                  color: AppColor.c797A7C,
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  widget.members,
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    color: AppColor.c797A7C,
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.calendar_today_outlined,
                  color: AppColor.c797A7C,
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  "${widget.events} Events",
                  style: TextFontStyle.textStyle14InterW400.copyWith(
                    color: AppColor.c797A7C,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          if (widget.description != null && widget.description!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.only(left: 60.w),
              child: Text(
                widget.description!,
                style: TextFontStyle.textStyle14InterW400.copyWith(
                  color: AppColor.c797A7C.withValues(alpha: 0.8),
                  fontSize: 12.sp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          if (widget.socialLinks != null && widget.socialLinks!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.only(left: 60.w),
              child: Wrap(
                spacing: 8.w,
                children: widget.socialLinks!.map((link) {
                  IconData iconData = Icons.link;
                  if (link.platform == 'instagram') {
                    iconData = Icons.camera_alt_outlined;
                  } else if (link.platform == 'facebook') {
                    iconData = Icons.facebook;
                  } else if (link.platform == 'tiktok') {
                    iconData = Icons.music_note;
                  } else if (link.platform == 'x') {
                    iconData = Icons.close;
                  }
                  return Icon(iconData, color: AppColor.c2196F3, size: 16.sp);
                }).toList(),
              ),
            ),
          ],
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: widget.onViewDetails,
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.c2196F3, width: 1.w),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        "View details",
                        style: TextFontStyle.textStyle16InterW600.copyWith(
                          color: AppColor.c2196F3,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              _ActionIcon(icon: Icons.edit_outlined, onTap: widget.onEdit),
              SizedBox(width: 12.w),
              _ActionIcon(
                icon: Icons.delete_outline,
                onTap: _isDeleting
                    ? () {}
                    : () async {
                        setState(() {
                          _isDeleting = true;
                        });
                        await widget.onDelete();
                        if (mounted) {
                          setState(() {
                            _isDeleting = false;
                          });
                        }
                      },
                color: Colors.red.withOpacity(0.1),
                iconColor: Colors.red,
                isLoading: _isDeleting,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final Color? iconColor;
  final bool isLoading;

  const _ActionIcon({
    required this.icon,
    required this.onTap,
    this.color,
    this.iconColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: color ?? AppColor.c282828,
          shape: BoxShape.circle,
        ),
        child: isLoading
            ? SizedBox(
                width: 18.sp,
                height: 18.sp,
                child: CircularProgressIndicator(
                  color: iconColor ?? Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Icon(icon, color: iconColor ?? Colors.white, size: 18.sp),
      ),
    );
  }
}
