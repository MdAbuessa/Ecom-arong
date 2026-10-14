import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/common_widgets/custom_button.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:aarongonzales01/features/user/upcoming_events/presentation/ticket_purchases_pup_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccessCodeScreen extends StatefulWidget {
  const AccessCodeScreen({super.key});

  @override
  State<AccessCodeScreen> createState() => _AccessCodeScreenState();
}

class _AccessCodeScreenState extends State<AccessCodeScreen> {
  final TextEditingController _accessCodeController = TextEditingController();

  @override
  void dispose() {
    _accessCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/home_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    /// CUSTOM APP BAR
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 10.h,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const CustomBackButton(),
                          ),
                          Text(
                            'Access Code',
                            style: TextFontStyle.textStyle16InterW600.copyWith(
                              fontSize: 18.sp,
                              color: AppColor.cFFFFFF,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            children: [
                              SizedBox(height: 60.h),

                              /// LOCK ICON
                              Container(
                                height: 120.w,
                                width: 120.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.05),
                                ),
                                child: Center(
                                  child: Container(
                                    height: 80.w,
                                    width: 80.w,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColor.c2196F3,
                                    ),
                                    child: Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                      size: 40.sp,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 30.h),

                              /// EVENT ACCESS TITLE
                              Text(
                                'Event Access',
                                style: TextFontStyle.textStyle16InterW600
                                    .copyWith(
                                      fontSize: 22.sp,
                                      color: AppColor.cFFFFFF,
                                    ),
                              ),

                              SizedBox(height: 10.h),

                              /// DESCRIPTION
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40.w),
                                child: Text(
                                  'This event request a valid access code provided by the organizer.',
                                  textAlign: TextAlign.center,
                                  style: TextFontStyle.textStyle14InterW400
                                      .copyWith(
                                        color: AppColor.c797A7C,
                                        height: 1.5,
                                      ),
                                ),
                              ),

                              SizedBox(height: 40.h),

                              /// LABEL
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Enter Access Code',
                                  style: TextFontStyle.textStyle14InterW500
                                      .copyWith(color: AppColor.cFFFFFF),
                                ),
                              ),

                              SizedBox(height: 12.h),

                              /// TEXT FIELD
                              CustomTextfieldWidget(
                                hintText: 'Enter access code',
                                controller: _accessCodeController,
                              ),

                              SizedBox(
                                height: 120.h,
                              ), // Space for bottom button
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// NEXT BUTTON
              Positioned(
                bottom: 60.h,
                left: 20.w,
                right: 20.w,
                child: CustomButton(
                  text: 'Next',
                  backgroundColor: AppColor.c2196F3,
                  onPressed: () {
                    Get.to(() => const TicketPurchasesPupUpScreen());
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
