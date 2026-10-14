import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aarongonzales01/networks/endpoints.dart' as endpoints;

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({
    super.key,
    required this.selectedImage,
    required this.onEditTap,
    this.imageUrl,
    this.showEditButton = true,
  });

  final File? selectedImage;
  final VoidCallback onEditTap;
  final String? imageUrl;
  final bool showEditButton;

  Widget _buildAvatarImage() {
    const double size = 112;
    if (selectedImage != null) {
      return Image.file(
        selectedImage!,
        width: size.r,
        height: size.r,
        fit: BoxFit.cover,
      );
    }
    String? fullImageUrl = imageUrl;
    if (fullImageUrl != null && fullImageUrl.isNotEmpty) {
      if (!fullImageUrl.startsWith('http')) {
        // Prepend base URL if it's a relative path
        fullImageUrl =
            "${endpoints.url}/${fullImageUrl.startsWith('/') ? fullImageUrl.substring(1) : fullImageUrl}";
      }
      return CachedNetworkImage(
        imageUrl: fullImageUrl,
        width: size.r,
        height: size.r,
        fit: BoxFit.cover,
        placeholder: (context, url) => Image.asset(
          'assets/images/placeholder.jpg',
          width: size.r,
          height: size.r,
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/placeholder.jpg',
          width: size.r,
          height: size.r,
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(
      'assets/images/placeholder.jpg',
      width: size.r,
      height: size.r,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(4.r),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 1.5.w,
            ),
          ),
          child: ClipOval(
            child: _buildAvatarImage(),
          ),
        ),
        if (showEditButton)
          Positioned(
            bottom: 2.r,
            right: 2.r,
            child: GestureDetector(
              onTap: onEditTap,
              child: Container(
                width: 30.r,
                height: 30.r,
                decoration: BoxDecoration(
                  color: const Color(0xFF266FEF),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF061115),
                    width: 2.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF266FEF).withOpacity(0.35),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 14.sp,
                ),
              ),
            ),
          ),
      ],
    );
  }
}