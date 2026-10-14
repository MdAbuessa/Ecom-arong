import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductColorPickerWidget extends StatelessWidget {
  final List<Color> colors;
  final int selectedColorIndex;
  final Function(int) onColorSelected;

  const ProductColorPickerWidget({
    super.key,
    required this.colors,
    required this.selectedColorIndex,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: List.generate(colors.length, (index) {
            final isSelected = selectedColorIndex == index;
            return GestureDetector(
              onTap: () => onColorSelected(index),
              child: Container(
                margin: EdgeInsets.only(right: 12.w),
                height: 32.w,
                width: 32.w,
                decoration: BoxDecoration(
                  color: colors[index],
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: const Color(0xFF2196F3), width: 2)
                      : Border.all(color: Colors.transparent),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
