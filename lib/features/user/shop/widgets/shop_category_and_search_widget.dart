import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShopCategoryAndSearchWidget extends StatefulWidget {
  final Function(String) onCategorySelected;
  
  const ShopCategoryAndSearchWidget({super.key, required this.onCategorySelected});

  @override
  State<ShopCategoryAndSearchWidget> createState() =>
      _ShopCategoryAndSearchWidgetState();
}

class _ShopCategoryAndSearchWidgetState
    extends State<ShopCategoryAndSearchWidget> {
  String _selectedCategory = "All";

  final List<String> _categories = [
    "All",
    "Apparel",
    "Accessories",
    "Nutrition",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              ..._categories.map((category) {
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: _buildCategoryChip(
                    category,
                    _selectedCategory == category,
                  ),
                );
              }),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: const BoxDecoration(
                  color: Color(0xFF1C2526),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.tune, color: Colors.white, size: 16.sp),
              ),
            ],
          ),
        ),
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
                hintStyle: TextStyle(color: Colors.white54, fontSize: 14.sp),
                icon: Icon(Icons.search, color: Colors.white54, size: 20.sp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14.h),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
        widget.onCategorySelected(title);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2196F3) : const Color(0xFF1C2526),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
