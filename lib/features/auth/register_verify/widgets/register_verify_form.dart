import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/helpers/di.dart';
import 'package:aarongonzales01/constants/app_constants.dart';
import 'package:aarongonzales01/networks/dio/dio.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterVerifyForm extends StatefulWidget {
  const RegisterVerifyForm({super.key});

  @override
  State<RegisterVerifyForm> createState() => _RegisterVerifyFormState();
}

class _RegisterVerifyFormState extends State<RegisterVerifyForm> {
  String _otpCode = "";

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String email = args?['email'] ?? "";
    final String otpToken = args?['otp_token'] ?? "";
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/forget_pass_verified_email_bg.png'),
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
                    'Verify Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),

              // Title and Subtitle
              Text(
                'Verify your email',
                style: TextStyle(
                  color: const Color(0xFF23A4FF),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Please enter the 4-digit code sent to your\nemail address.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 40.h),

              // OTP Fields
              OtpTextField(
                numberOfFields: 4,
                borderColor: Colors.white24,
                focusedBorderColor: const Color(0xFF23A4FF),
                showFieldAsBox: true,
                fieldWidth: 65.w,
                fieldHeight: 65.w,
                borderRadius: BorderRadius.circular(32.w),
                textStyle: TextStyle(color: Colors.white, fontSize: 20.sp),
                onCodeChanged: (String code) {
                  _otpCode = code;
                },
                onSubmit: (String verificationCode) {
                  _otpCode = verificationCode;
                },
              ),
              SizedBox(height: 32.h),

              // Resend Text
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Resend logic
                  },
                  child: Text(
                    'Resend code',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              // Continue Button
              ValueListenableBuilder<bool>(
                valueListenable: registerVerifyOtpRxObj.isLoading,
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
                              if (email.isEmpty || otpToken.isEmpty) {
                                ToastUtil.showShortToast(
                                  'Session expired. Please register again.',
                                );
                                return;
                              }

                              final success = await registerVerifyOtpRxObj
                                  .verifyOtpRx(
                                    otp: _otpCode,
                                    email: email,
                                    otpToken: otpToken,
                                  );

                              if (success) {
                                final verifyModelObj = registerVerifyOtpRxObj.dataFetcher.hasValue
                                    ? registerVerifyOtpRxObj.dataFetcher.value
                                    : null;
                                final accessToken = verifyModelObj?.data?.accessToken ?? "";
                                final refreshToken = verifyModelObj?.data?.refreshToken ?? "";

                                if (accessToken.isNotEmpty) {
                                  appData.write(kKeyIsLoggedIn, true);
                                  appData.write(kKeyAccessToken, accessToken);
                                  appData.write(kKeyRefreshToken, refreshToken);
                                  // After registration the user hasn't chosen a role yet
                                  appData.write(kKeyIsProfileSelected, false);
                                  appData.write(kKeyUserRole, '');
                                  DioSingleton.instance.update(accessToken);
                                }

                                debugPrint('================ VERIFY OTP SUCCESS ================');
                                debugPrint('Email: $email');
                                debugPrint('OTP Token: $otpToken');
                                debugPrint('OTP Code: $_otpCode');
                                debugPrint('Access Token: $accessToken');
                                debugPrint('Refresh Token: $refreshToken');
                                debugPrint('====================================================');

                                if (!context.mounted) return;
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          24.r,
                                        ),
                                      ),
                                      backgroundColor: const Color(0xFF1E222A),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 40.h,
                                          horizontal: 24.w,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/password_reset_success.svg',
                                              width: 120.w,
                                              height: 120.w,
                                            ),
                                            SizedBox(height: 32.h),
                                            Text(
                                              'Account Created\nSuccessfully!',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.bold,
                                                height: 1.3,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 16.h),
                                            Text(
                                              'Welcome aboard! You can now sign in and\nstart using your account.',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14.sp,
                                                height: 1.5,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            SizedBox(height: 40.h),
                                            const CircularProgressIndicator(
                                              color: Color(0xFF23A4FF),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );

                                Future.delayed(const Duration(seconds: 2), () {
                                  if (mounted) {
                                    NavigationService.goBack; // Close dialog
                                    NavigationService.navigateToReplacement(
                                      Routes.chooseRoleScreen,
                                    );
                                  }
                                });
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
    );
  }
}
