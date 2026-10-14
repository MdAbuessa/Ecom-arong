import 'package:aarongonzales01/assets_helper/app_icons.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/user/shop/widgets/shop_category_and_search_widget.dart';
import 'package:aarongonzales01/features/user/shop/widgets/shop_sweat_equity_widget.dart';
import 'package:aarongonzales01/features/user/shop/widgets/shop_widget.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String _selectedCategory = "All";

  final List<Map<String, dynamic>> shopProducts = [
    {
      "imageUrl": 'assets/images/product1.png',
      "title": "Event Runner T-Shirt",
      "points": "200",
      "price": "20.00",
      "category": "Apparel",
    },
    {
      "imageUrl": 'assets/images/product2.png',
      "title": "Sports Water Bottle",
      "points": "100/200",
      "price": "12.00",
      "category": "Accessories",
    },
    {
      "imageUrl": 'assets/images/product1.png',
      "title": "Running Cap",
      "points": "200",
      "price": "10.00",
      "category": "Accessories",
    },
    {
      "imageUrl": 'assets/images/product1.png',
      "title": "Performance Hoodie",
      "points": "200",
      "price": "10.00",
      "category": "Apparel",
    },
    {
      "imageUrl": 'assets/images/product1.png',
      "title": "Event Backpack",
      "points": "200",
      "price": "30.00",
      "category": "Accessories",
    },
    {
      "imageUrl": 'assets/images/product2.png',
      "title": "Tech Performance",
      "points": "200",
      "price": "10.00",
      "category": "Apparel",
    },
    {
      "imageUrl": 'assets/images/product2.png',
      "title": "Sports Nutrition",
      "points": "200",
      "price": "10.00",
      "category": "Nutrition",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _selectedCategory == "All"
        ? shopProducts
        : shopProducts
              .where((product) => product["category"] == _selectedCategory)
              .toList();

    return Scaffold(
      appBar: ProfileAppBar(
        title: "Shop",
        icons: AppIcons.shopNew,
        icons1: AppIcons.favorite,
        onTap: () {
          NavigationService.navigateTo(Routes.cartScreen);
        },
        onTap1: () {
          NavigationService.navigateTo(Routes.favoritesListScreen);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            ShopCategoryAndSearchWidget(
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 290.h, 
                crossAxisSpacing: 12.w, 
                mainAxisSpacing: 16.h, 
              ), 
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ShopWidget(
                  onTap: () {
                    NavigationService.navigateTo(Routes.productDetailsScreen);
                  },
                  imageUrl: product["imageUrl"],
                  title: product["title"],
                  points: product["points"],
                  price: product["price"],
                );
              },
            ),
            const ShopSweatEquityWidget(),
            UIHelper.verticalSpace(100),
          ],
        ),
      ),
    );
  }
}
