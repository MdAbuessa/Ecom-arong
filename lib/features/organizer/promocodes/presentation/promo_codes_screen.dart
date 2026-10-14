import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/promocodes/widgets/promo_code_card.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoCodesScreen extends StatefulWidget {
  const PromoCodesScreen({super.key});

  @override
  State<PromoCodesScreen> createState() => _PromoCodesScreenState();
}

class _PromoCodesScreenState extends State<PromoCodesScreen> {
  final List<Map<String, String>> _allPromos = [
    {
      "title": "Summer Special Discount",
      "subtitle": "Summer Music Festival",
      "code": "SUM2-7X9K2L",
      "status": "Active",
      "discount": "40% OFF",
      "used": "35/100",
      "expires": "Feb 14, 2025",
    },
    {
      "title": "Summer Special Discount",
      "subtitle": "Summer Music Festival",
      "code": "SUM2-7X9K2L",
      "status": "Active",
      "discount": "40% OFF",
      "used": "35/100",
      "expires": "Feb 14, 2025",
    },
    {
      "title": "Summer Special Discount",
      "subtitle": "Summer Music Festival",
      "code": "SUM2-7X9K2L",
      "status": "Active",
      "discount": "40% OFF",
      "used": "35/100",
      "expires": "Feb 14, 2025",
    },
    {
      "title": "Summer Special Discount",
      "subtitle": "Summer Music Festival",
      "code": "SUM2-7X9K2L",
      "status": "Active",
      "discount": "40% OFF",
      "used": "35/100",
      "expires": "Feb 14, 2025",
    },
    {
      "title": "Summer Special Discount",
      "subtitle": "Summer Music Festival",
      "code": "SUM2-7X9K2L",
      "status": "Active",
      "discount": "40% OFF",
      "used": "35/100",
      "expires": "Feb 14, 2025",
    },
    {
      "title": "VIP Early Bird",
      "subtitle": "Tech Summit 2025",
      "code": "VIP1-K3M8NQ",
      "status": "Inactive",
      "discount": "40% OFF",
      "used": "35/100",
      "expires": "Feb 14, 2025",
    },
    {
      "title": "VIP Early Bird",
      "subtitle": "Tech Summit 2025",
      "code": "VIP1-K3M8NQ",
      "status": "Inactive",
      "discount": "40% OFF",
      "used": "35/100",
      "expires": "Feb 14, 2025",
    },
    {
      "title": "Flash Sale",
      "subtitle": "Food & Wine Carnival",
      "code": "FLS9-2P7XWR",
      "status": "Expired",
      "discount": "40% OFF",
      "used": "35/100",
      "expires": "Feb 14, 2025",
    },
    {
      "title": "Flash Sale",
      "subtitle": "Food & Wine Carnival",
      "code": "FLS9-2P7XWR",
      "status": "Expired",
      "discount": "40% OFF",
      "used": "35/100",
      "expires": "Feb 14, 2025",
    },
    {
      "title": "Flash Sale",
      "subtitle": "Food & Wine Carnival",
      "code": "FLS9-2P7XWR",
      "status": "Expired",
      "discount": "40% OFF",
      "used": "35/100",
      "expires": "Feb 14, 2025",
    },
  ];

  Widget _buildPromoList(List<Map<String, String>> items) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            NavigationService.navigateTo(
              Routes.promoCodeDetailsScreen,
              arguments: item,
            );
          },
          child: PromoCodeCard(
            title: item["title"]!,
            subtitle: item["subtitle"]!,
            code: item["code"]!,
            status: item["status"]!,
            discount: item["discount"]!,
            used: item["used"]!,
            expires: item["expires"]!,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeList = _allPromos
        .where((p) => p["status"] == "Active")
        .toList();
    final inactiveList = _allPromos
        .where((p) => p["status"] == "Inactive")
        .toList();
    final expiredList = _allPromos
        .where((p) => p["status"] == "Expired")
        .toList();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFF061115),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 90.w,
          leading: Padding(
            padding: EdgeInsets.only(left: 5.w, top: 5.h, bottom: 5.h),
            child: GestureDetector(
              onTap: () {
                NavigationService.goBack;
              },
              child: Center(
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: const BoxDecoration(
                    color: AppColor.c2196F3,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Promo Codes",
            style: TextFontStyle.textStyle24RobotoW600.copyWith(
              color: Colors.white,
              fontSize: 20.sp,
            ),
          ),
          bottom: TabBar(
            indicatorColor: AppColor.c2196F3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white38,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextFontStyle.textStyle14InterW500.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextFontStyle.textStyle14InterW500.copyWith(
              fontSize: 12.sp,
            ),
            tabs: const [
              Tab(text: "All (10)"),
              Tab(text: "Active (05)"),
              Tab(text: "Inactive (02)"),
              Tab(text: "Expired (03)"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPromoList(_allPromos),
            _buildPromoList(activeList),
            _buildPromoList(inactiveList),
            _buildPromoList(expiredList),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: AppColor.c2196F3,
          onPressed: () {
            NavigationService.navigateTo(Routes.createPromoCodeScreen);
          },
          child: Icon(Icons.add, color: Colors.white, size: 28.sp),
        ),
      ),
    );
  }
}
