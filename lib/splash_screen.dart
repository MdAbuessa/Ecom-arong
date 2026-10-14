import 'dart:math';
import 'package:aarongonzales01/assets_helper/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _loaderController;

  @override
  void initState() {
    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _loaderController.dispose();
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
              image: AssetImage(AppImages.bg),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: const Alignment(0, -0.5),
                  child: SizedBox(
                    width: 190.w,
                    child: Image.asset(AppImages.logo, fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 110.h,
                  child: Center(
                    child: _DotLoader(controller: _loaderController),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DotLoader extends StatelessWidget {
  const _DotLoader({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    const dotColor = Color(0xFF23A4FF);

    return SizedBox(
      width: 76.w,
      height: 76.w,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: List.generate(10, (index) {
              final angle = ((2 * 3.141592653589793) / 10) * index;
              final progress = (index - controller.value * 10 + 10) % 10;
              final normalized = progress / 10;
              final opacity = 0.18 + (1 - normalized) * 0.82;
              final size = 5.w + (1 - normalized) * 7.w;

              return Transform.translate(
                offset: Offset(24.w * cos(angle), 24.w * sin(angle)),
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: dotColor.withValues(alpha: opacity),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
