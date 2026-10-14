import 'package:aarongonzales01/features/organizer/navbar_organizer_menu.dart';
import 'package:aarongonzales01/features/user/user_navigation_menu.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:aarongonzales01/helpers/toast.dart';
import 'package:aarongonzales01/helpers/di.dart';
import 'package:aarongonzales01/constants/app_constants.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  String _selectedRole = ''; // 'Participant' or 'Organizer'

  @override
  Widget build(BuildContext context) {
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
              image: AssetImage('assets/images/register_bg.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60.h),
                    // Logo
                    Image.asset('assets/images/logo.png', height: 100.h),
                    SizedBox(height: 40.h),

                    // Titles
                    Text(
                      'Create an account as',
                      style: TextStyle(
                        color: const Color(0xFF23A4FF),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Select Participant to join an event or\nOrganizer to create one',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14.sp,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 50.h),

                    // Roles
                    _buildRoleCard('Participant'),
                    SizedBox(height: 20.h),
                    _buildRoleCard('Organizer'),

                    UIHelper.verticalSpace(36.h),

                    // Next Button
                    ValueListenableBuilder<bool>(
                      valueListenable: chooseRoleRxObj.isLoading,
                      builder: (context, isLoading, child) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    if (_selectedRole.isEmpty) {
                                      ToastUtil.showShortToast(
                                        'select your role',
                                      );
                                      return;
                                    }
                                    final success = await chooseRoleRxObj
                                        .updateRoleRx(role: _selectedRole);

                                    if (success) {
                                      // Persist role selection for startup routing
                                      appData.write(kKeyIsProfileSelected, true);
                                      appData.write(kKeyUserRole, _selectedRole.toLowerCase());

                                      Widget nextScreen;
                                      if (_selectedRole == 'Participant') {
                                        nextScreen = const UserNavigationMenu();
                                      } else {
                                        nextScreen =
                                            const NavbarOrganizerMenu();
                                      }
                                      if (!context.mounted) return;
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => nextScreen,
                                        ),
                                        (route) => false,
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedRole.isNotEmpty
                                  ? const Color(0xFF23A4FF)
                                  : const Color(0x809E9E9E),
                              disabledBackgroundColor: const Color(0x9923A4FF),
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              minimumSize: Size(double.infinity, 54.h),
                              fixedSize: Size(double.infinity, 54.h),
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
                                    'Next',
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
      ),
    );
  }

  Widget _buildRoleCard(String role) {
    bool isSelected = _selectedRole == role;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.transparent : const Color(0xFF1E222A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF23A4FF)
                : const Color(0xFF2E333D),
            width: 2,
          ),
        ),
        child: Center(
          child: Text(
            role,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
