import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ShopWidget extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String points;
  final String price;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;
  final VoidCallback? onFavoriteTap;
  final bool initialFavorite;

  const ShopWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.points,
    required this.price,
    this.onAddToCart,
    this.onFavoriteTap,
    this.onTap,
    this.initialFavorite = false,
  });

  @override
  State<ShopWidget> createState() => _ShopWidgetState();
}

class _ShopWidgetState extends State<ShopWidget> {
  bool isAddedToCart = false;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 185.w,
        padding: EdgeInsets.only(
          left: 12.w,
          right: 12.w,
          top: 12.w,
          bottom: 12.w,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF0D1B1E),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.05), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Image & Favorite Icon
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.03),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(widget.imageUrl, fit: BoxFit.contain),
                    ),
                  ),

                  Positioned(
                    top: 2.w,
                    right: 2.w,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });

                        widget.onFavoriteTap;
                      },
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : AppColor.c2196F3,
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              widget.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextFontStyle.textStyle16InterW600.copyWith(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/coin.svg',
                  height: 12,
                  width: 12,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 4.w),
                Flexible(
                  child: Text(
                    "Spend",
                    style: TextFontStyle.textStyle14InterW400.copyWith(
                      fontSize: 12.sp,
                      color: Colors.white70,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Flexible(
                  child: Text(
                    "${widget.points} pts",
                    style: TextFontStyle.textStyle14InterW500.copyWith(
                      fontSize: 12.sp,
                      color: const Color(0xFF2196F3),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "\$${widget.price}",
                    style: TextFontStyle.textStyle16InterW600.copyWith(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 4.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C2526),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Select",
                        style: TextFontStyle.textStyle14InterW500.copyWith(
                          fontSize: 11.sp,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 14.sp,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  isAddedToCart = !isAddedToCart;
                });
                widget.onAddToCart?.call();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.w),
                decoration: BoxDecoration(
                  color: isAddedToCart ? AppColor.c2196F3 : Colors.transparent,
                  border: Border.all(color: AppColor.c2196F3),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Flexible(
                      child: Text(
                        isAddedToCart ? "Added" : "Add To Cart",
                        style: TextFontStyle.textStyle14InterW500.copyWith(
                          fontSize: 13.sp,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
