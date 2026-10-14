import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/mail_card.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllMailScreen extends StatefulWidget {
  const AllMailScreen({super.key});

  @override
  State<AllMailScreen> createState() => _AllMailScreenState();
}

class _AllMailScreenState extends State<AllMailScreen> {
  int _selectedMailIndex = 0;

  final List<Map<String, String>> _mails = [
    {
      "name": "Ayana mere",
      "message": "Insert features buttons below sc..",
      "time": "1 hour ago",
    },
    {
      "name": "Angelina angle",
      "message": "Insert features buttons below sc..",
      "time": "1 hour ago",
    },
    {
      "name": "Alex Sohna",
      "message": "Your Verification Code for Register..",
      "time": "1 hour ago",
    },
    {
      "name": "Meera mehari",
      "message": "Insert features buttons below sc..",
      "time": "1 hour ago",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        onBackTap: () {
          NavigationService.goBack;
        },
        title: "All mail",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(_mails.length, (index) {
            final mail = _mails[index];
            return MailCard(
              name: mail["name"]!,
              message: mail["message"]!,
              time: mail["time"]!,
              isSelected: _selectedMailIndex == index,
              onTap: () {
                setState(() {
                  _selectedMailIndex = index;
                });
                NavigationService.navigateTo(Routes.emailPreviewScreen);
              },
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          NavigationService.navigateTo(Routes.orgEmailSendScreen);
        },
        backgroundColor: AppColor.cCAF0F8,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        icon: Icon(Icons.edit_outlined, color: AppColor.c2196F3, size: 20.sp),
        label: Text(
          "Compose",
          style: TextFontStyle.textStyle14InterW500.copyWith(
            color: AppColor.c2196F3,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
