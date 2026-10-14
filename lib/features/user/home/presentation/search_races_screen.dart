import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchRacesScreen extends StatefulWidget {
  const SearchRacesScreen({super.key});

  @override
  State<SearchRacesScreen> createState() => _SearchRacesScreenState();
}

class _SearchRacesScreenState extends State<SearchRacesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF071112),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomBackButton(),
                  Text(
                    "Search races",
                    style: TextFontStyle.textStyle16InterW600.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                  const SizedBox(width: 44), // To balance the back button
                ],
              ),

              SizedBox(height: 30.h),

              /// Search Bar
              CustomTextfieldWidget(
                hintText: "Search races",
                controller: _searchController,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white70,
                  size: 20.sp,
                ),
              ),

              SizedBox(height: 24.h),

              /// Race Type Cards
              Row(
                children: [
                  Expanded(
                    child: _buildRaceTypeCard(
                      title: "Virtual Races",
                      icon: Icons.directions_run,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildRaceTypeCard(
                      title: "Physical Races",
                      icon: Icons.groups,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              /// Explore Activities Header
              Text(
                "Explore activities",
                style: TextFontStyle.textStyle16InterW600.copyWith(
                  fontSize: 18.sp,
                ),
              ),

              SizedBox(height: 20.h),

              /// Activity Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActivityIcon(
                    label: "Running",
                    icon: Icons.directions_run,
                  ),
                  _buildActivityIcon(
                    label: "Cycling",
                    icon: Icons.directions_bike,
                  ),
                  _buildActivityIcon(label: "Swimming", icon: Icons.pool),
                  _buildActivityIcon(label: "Hiking", icon: Icons.terrain),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRaceTypeCard({required String title, required IconData icon}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1C2526),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextFontStyle.textStyle14InterW500.copyWith(
              color: Colors.white,
            ),
          ),
          Icon(icon, color: const Color(0xFF2196F3), size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildActivityIcon({required String label, required IconData icon}) {
    return Column(
      children: [
        Container(
          width: 56.w,
          height: 56.w,
          decoration: BoxDecoration(
            color: const Color(0xFF1C2526),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(icon, color: const Color(0xFF2196F3), size: 24.sp),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          label,
          style: TextFontStyle.textStyle14InterW500.copyWith(
            fontSize: 13.sp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
