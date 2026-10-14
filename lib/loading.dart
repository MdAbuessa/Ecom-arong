import 'package:aarongonzales01/constants/app_constants.dart';
import 'package:aarongonzales01/features/auth/choose_role/presentation/choose_role_screen.dart';
import 'package:aarongonzales01/features/auth/login/presentation/login_screen.dart';
import 'package:aarongonzales01/features/organizer/navbar_organizer_menu.dart';
import 'package:aarongonzales01/features/user/user_navigation_menu.dart';
import 'package:aarongonzales01/helpers/di.dart';
import 'package:aarongonzales01/helpers/helper_methods.dart';
import 'package:aarongonzales01/splash_screen.dart';
import 'package:aarongonzales01/features/onboarding/presentation/onboarding_screen_one.dart';
import 'package:flutter/material.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  Future<void> loadInitialData() async {
    _isLoading = true;
    await setInitValue();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SplashScreen();
    } else {
      final bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;

      if (!isLoggedIn) {
        final bool firstTime = appData.read(kKeyfirstTime) ?? true;
        if (firstTime) {
          return const OnboardingScreenOne();
        } else {
          return const LoginScreen();
        }
      }

      final bool isProfileSelected = appData.read(kKeyIsProfileSelected) ?? false;
      final String role = (appData.read(kKeyUserRole) ?? '').toString().toLowerCase();

      if (isProfileSelected && role.isNotEmpty) {
        if (role == 'participant') {
          return const UserNavigationMenu();
        } else if (role == 'organizer') {
          return const NavbarOrganizerMenu();
        }
      }

      // Logged in but hasn't selected a role yet
      return const ChooseRoleScreen();
    }
  }
}
