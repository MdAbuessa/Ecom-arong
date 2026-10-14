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

Widget buildDropdown(String value, {IconData? icon}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppColor.c2196F3, size: 20),
              SizedBox(width: 12.w),
            ],
            Text(value, style: const TextStyle(color: Colors.white)),
          ],
        ),
        const Icon(Icons.keyboard_arrow_down, color: Colors.white),
      ],
    ),
  );
}

Widget buildOutlineButton(
  String text, {
  bool fullWidth = false,
  VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: fullWidth ? double.infinity : null,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.c2196F3),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 12.sp),
        ),
      ),
    ),
  );
}

Widget buildTabButton(String text, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isSelected ? AppColor.c2196F3 : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

class NumericFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  const NumericFieldWidget({super.key, required this.controller});

  @override
  State<NumericFieldWidget> createState() => _NumericFieldWidgetState();
}

class _NumericFieldWidgetState extends State<NumericFieldWidget> {
  void _increment() {
    int val = int.tryParse(widget.controller.text) ?? 0;
    setState(() {
      widget.controller.text = (val + 1).toString();
    });
  }

  void _decrement() {
    int val = int.tryParse(widget.controller.text) ?? 0;
    if (val > 0) {
      setState(() {
        widget.controller.text = (val - 1).toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.controller.text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: _increment,
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.grey,
                  size: 16,
                ),
              ),
              GestureDetector(
                onTap: _decrement,
                child: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                  size: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget buildNumericField(TextEditingController controller) {
  return NumericFieldWidget(controller: controller);
}

Widget buildStepper(int activeStep) {
  List<String> labels = [
    "Basic\nInfo",
    "Date &\n Time",
    "Banner\nSection",
    "Optional\nSettings",
  ];
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
                                : Colors.grey.withValues(alpha: 0.5)),
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
                            : Colors.grey,
                      ),
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            )
                          : Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: isActive ? Colors.white : Colors.grey,
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
                          : (isCompleted
                                ? AppColor.c2196F3
                                : Colors.grey.withValues(alpha: 0.5)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                labels[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
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
