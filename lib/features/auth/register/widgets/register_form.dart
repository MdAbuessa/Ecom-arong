import 'package:aarongonzales01/features/auth/register/widgets/auth_text_field.dart';
import 'package:aarongonzales01/features/auth/register/widgets/login_redirect_text.dart';
import 'package:aarongonzales01/features/auth/register/widgets/terms_checkbox.dart';
import 'package:aarongonzales01/features/auth/register/widgets/welcome_header.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onRegisterPressed() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty) {
      ToastUtil.showShortToast('Name is required to create an account.');
      return;
    }
    if (email.isEmpty) {
      ToastUtil.showShortToast('Email is required.');
      return;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      ToastUtil.showShortToast('Please enter a valid email address.');
      return;
    }
    if (password.isEmpty) {
      ToastUtil.showShortToast('Password is required.');
      return;
    }
    if (password.length < 6) {
      ToastUtil.showShortToast('Password must be at least 6 characters.');
      return;
    }
    if (confirmPassword.isEmpty) {
      ToastUtil.showShortToast('The password confirmation does not match.');
      return;
    }
    if (password != confirmPassword) {
      ToastUtil.showShortToast('The password confirmation does not match.');
      return;
    }
    if (!_acceptTerms) {
      ToastUtil.showShortToast('Please accept the Terms of Service and Privacy Policy.');
      return;
    }

    final success = await registerRxObj.registerRx(
      firstName: name,
      email: email,
      password: password,
      passwordConfirmation: confirmPassword,
      termsAndConditions: _acceptTerms ? 1 : 0,
    );

    if (success) {
      final registerModelObj = registerRxObj.dataFetcher.hasValue
          ? registerRxObj.dataFetcher.value
          : null;
      final otpToken = registerModelObj?.data?.otpToken ?? "";

      debugPrint('================ REGISTER SUCCESS ================');
      debugPrint('Email: $email');
      debugPrint('OTP Token: $otpToken');
      debugPrint('==================================================');

      NavigationService.navigateTo(
        Routes.registerVerifyScreen,
        arguments: {
          'email': email,
          'otp_token': otpToken,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/register_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const WelcomeHeader(),
              SizedBox(height: 40.h),

              // Full Name Field
              AuthTextField(
                controller: _nameController,
                label: 'Full Name',
                hintText: 'Enter your full name',
              ),
              SizedBox(height: 24.h),

              // Email Field
              AuthTextField(
                controller: _emailController,
                label: 'Email address',
                hintText: 'Enter your mail',
              ),
              SizedBox(height: 24.h),

              // Password Field
              AuthTextField(
                controller: _passwordController,
                label: 'Password',
                hintText: '**********',
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              SizedBox(height: 24.h),

              // Confirm Password Field
              AuthTextField(
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                hintText: '**********',
                obscureText: _obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: Colors.white54,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
              SizedBox(height: 16.h),

              // Terms and Privacy Policy
              TermsCheckbox(
                value: _acceptTerms,
                onChanged: (value) {
                  setState(() {
                    _acceptTerms = value ?? false;
                  });
                },
              ),
              SizedBox(height: 32.h),

              // Register Button
              ValueListenableBuilder<bool>(
                valueListenable: registerRxObj.isLoading,
                builder: (context, isLoading, child) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _onRegisterPressed,
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
                              'Register',
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
              SizedBox(height: 32.h),

              // Login Bottom Text
              const LoginRedirectText(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
