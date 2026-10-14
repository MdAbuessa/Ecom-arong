import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/user/shop/widgets/shop_widget.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesListScreen extends StatefulWidget {
  const FavoritesListScreen({super.key});

  @override
  State<FavoritesListScreen> createState() => _FavoritesListScreenState();
}

class _FavoritesListScreenState extends State<FavoritesListScreen> {
  final List<Map<String, dynamic>> favoriteProducts = [
    {
      "imageUrl": 'assets/images/product1.png',
      "title": "Event Runner T-Shirt",
      "points": "200",
      "price": "20.00",
    },
    {
      "imageUrl": 'assets/images/product2.png',
      "title": "Sports Water Bottle",
      "points": "100/200",
      "price": "12.00",
    },
    {
      "imageUrl": 'assets/images/product1.png',
      "title": "Running Cap",
      "points": "200",
      "price": "10.00",
    },
    {
      "imageUrl": 'assets/images/product1.png',
      "title": "Performance Hoodie",
      "points": "200",
      "price": "10.00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppBar(
        title: "My Wishlist",
        onBackTap: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1B1E),
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(color: Colors.white.withOpacity(0.05)),
                ),
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: "Search here",
                    hintStyle: TextStyle(
                      color: Colors.white54,
                      fontSize: 14.sp,
                    ),
                    icon: Icon(
                      Icons.search,
                      color: Colors.white54,
                      size: 20.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 330.h,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 16.h,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return ShopWidget(
                  onTap: () {
                    NavigationService.navigateTo(Routes.productDetailsScreen);
                  },
                  imageUrl: product["imageUrl"],
                  title: product["title"],
                  points: product["points"],
                  price: product["price"],
                  initialFavorite: true,
                );
              },
            ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }
}
