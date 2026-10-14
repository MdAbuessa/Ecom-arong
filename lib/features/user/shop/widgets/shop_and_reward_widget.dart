import 'package:aarongonzales01/features/user/shop/widgets/shop_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopAndRewardWidget extends StatefulWidget {
  const ShopAndRewardWidget({super.key});

  @override
  State<ShopAndRewardWidget> createState() => _ShopAndRewardWidgetState();
}

class _ShopAndRewardWidgetState extends State<ShopAndRewardWidget> {
  final List<Map<String, dynamic>> shopProducts = [
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
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shop & Rewards",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                "See all",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        SizedBox(
          height: 300.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: shopProducts.length,
            itemBuilder: (context, index) {
              final product = shopProducts[index];
              return Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: ShopWidget(
                    imageUrl: product["imageUrl"],
                    title: product["title"],
                    points: product["points"],
                    price: product["price"],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
