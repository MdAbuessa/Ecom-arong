import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class ForgetPasswordVerifyScreen extends StatefulWidget {
  const ForgetPasswordVerifyScreen({super.key});

  @override
  State<ForgetPasswordVerifyScreen> createState() =>
      _ForgetPasswordVerifyScreenState();
}

class _ForgetPasswordVerifyScreenState
    extends State<ForgetPasswordVerifyScreen> {
  String _otpCode = "";
  String? _newOtpToken;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String email = args?['email'] ?? "";
    final String otpToken = args?['otp_token'] ?? "";
    final String currentOtpToken = _newOtpToken ?? otpToken;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/images/forget_pass_verified_email_bg.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  // App Bar equivalent
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFF23A4FF),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 6.w),
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Text(
                        'Verified Your Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),

                  // Description Text
                  Text(
                    'Check your inbox to find the verification code and\nenter the code below.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14.sp,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 40.h),

                  // OTP Field
                  OtpTextField(
                    numberOfFields: 4,
                    borderColor: Colors.white24,
                    enabledBorderColor: Colors.white24,
                    focusedBorderColor: const Color(0xFF23A4FF),
                    showFieldAsBox: true,
                    fieldWidth: 60.w,
                    fieldHeight: 60.w,
                    borderRadius: BorderRadius.circular(30.w), // Circle shape
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    onCodeChanged: (String code) {
                      _otpCode = code;
                    },
                    onSubmit: (String verificationCode) {
                      _otpCode = verificationCode;
                    },
                  ),
                  SizedBox(height: 32.h),

                  // Resend Code
                  Center(
                    child: ValueListenableBuilder<bool>(
                      valueListenable: resendOtpRxObj.isLoading,
                      builder: (context, isLoading, child) {
                        return TextButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  if (email.isEmpty ||
                                      currentOtpToken.isEmpty) {
                                    ToastUtil.showShortToast(
                                      'Session expired. Please try again.',
                                    );
                                    return;
                                  }
                                  final resendModel = await resendOtpRxObj
                                      .resendOtpRx(
                                        email: email,
                                        otpToken: currentOtpToken,
                                      );
                                  if (resendModel != null) {
                                    final newToken = resendModel.data?.otpToken;
                                    if (newToken != null &&
                                        newToken.isNotEmpty) {
                                      setState(() {
                                        _newOtpToken = newToken;
                                      });
                                    }
                                  }
                                },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: isLoading
                              ? SizedBox(
                                  height: 16.h,
                                  width: 16.h,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Resend Code',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Continue Button
                  ValueListenableBuilder<bool>(
                    valueListenable: verifyForgetPasswordOtpRxObj.isLoading,
                    builder: (context, isLoading, child) {
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  if (_otpCode.length != 4) {
                                    ToastUtil.showShortToast(
                                      'Please enter the 4-digit code.',
                                    );
                                    return;
                                  }
                                  if (email.isEmpty ||
                                      currentOtpToken.isEmpty) {
                                    ToastUtil.showShortToast(
                                      'Session expired. Please try again.',
                                    );
                                    return;
                                  }

                                  final verifyModel =
                                      await verifyForgetPasswordOtpRxObj
                                          .verifyOtpRx(
                                            otp: _otpCode,
                                            email: email,
                                            otpToken: currentOtpToken,
                                          );

                                  if (verifyModel != null) {
                                    if (!context.mounted) return;

                                    NavigationService.navigateToWithArgs(
                                      Routes.updatePasswordScreen,
                                      {
                                        'email': email,
                                        'reset_token':
                                            verifyModel.data?.resetToken ?? "",
                                      },
                                    );
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         const UpdatePasswordScreen(),
                                    //     settings: RouteSettings(
                                    //       arguments: {
                                    //         'email': email,
                                    //         'reset_token':
                                    //             verifyModel.data?.resetToken ??
                                    //             "",
                                    //       },
                                    //     ),
                                    //   ),
                                    // );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF23A4FF),
                            disabledBackgroundColor: const Color(0x9923A4FF),
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? SizedBox(
                                  height: 20.h,
                                  width: 20.h,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Continue',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
