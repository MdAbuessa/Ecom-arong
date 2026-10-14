import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/member_card_widget.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClubAllMemberScreen extends StatefulWidget {
  const ClubAllMemberScreen({super.key});

  @override
  State<ClubAllMemberScreen> createState() => _ClubAllMemberScreenState();
}

class _ClubAllMemberScreenState extends State<ClubAllMemberScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        title: "All Member",
        onBackTap: () {
          NavigationService.goBack;
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                "340 Total Members",
                style: TextFontStyle.textStyle16InterW600.copyWith(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              // Search Bar
              CustomTextfieldWidget(
                hintText: "Search member",
                controller: _searchController,
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColor.c797A7C,
                  size: 20.sp,
                ),
              ),
              SizedBox(height: 20.h),
              // Member List
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MemberCardWidget(
                      name: "Ayana mere",
                      location: "Oreland, USA",
                      image: index % 2 == 0
                          ? "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop"
                          : "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop",
                      onOptionsTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
