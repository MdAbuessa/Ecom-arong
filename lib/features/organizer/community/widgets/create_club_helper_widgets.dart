import 'dart:ui';
import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildLabel(String label) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget buildStepper(int activeStep) {
  List<String> labels = ["Basic\nInfo", "Banner\nSection"];
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 20.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(labels.length, (index) {
        bool isActive = index == activeStep;
        bool isCompleted = index < activeStep;
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: index == 0
                          ? Colors.transparent
                          : (isCompleted || isActive
                                ? AppColor.c2196F3
                                : AppColor.cFFFFFF),
                    ),
                  ),
                  Container(
                    width: 30.w,
                    height: 30.w,
                    decoration: BoxDecoration(
                      color: isActive || isCompleted
                          ? AppColor.c2196F3
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive || isCompleted
                            ? AppColor.c2196F3
                            : AppColor.cFFFFFF,
                      ),
                    ),
                    child: Center(
                      child: isCompleted
                          ? Icon(Icons.check, color: Colors.white, size: 16)
                          : Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: isActive
                                    ? AppColor.cFFFFFF
                                    : AppColor.cFFFFFF,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: index == labels.length - 1
                          ? Colors.transparent
                          : (isCompleted ? AppColor.c2196F3 : AppColor.cFFFFFF),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                labels[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: isActive || isCompleted
                      ? AppColor.c2196F3
                      : Colors.white,
                ),
              ),
            ],
          ),
        );
      }),
    ),
  );
}

class DashCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 3;
    double startAngle = 0;

    final double circumference = 2 * 3.14159 * (size.width / 2);
    final int dashCount = (circumference / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < dashCount; i++) {
      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        startAngle,
        dashWidth / (size.width / 2),
        false,
        paint,
      );
      startAngle += (dashWidth + dashSpace) / (size.width / 2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DashRectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.5)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const double dashWidth = 5;
    const double dashSpace = 3;

    Path path = Path();
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(12),
      ),
    );

    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0;
      while (distance < pathMetric.length) {
        canvas.drawPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
