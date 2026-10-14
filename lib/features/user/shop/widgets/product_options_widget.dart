import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductOptionsWidget extends StatelessWidget {
  final int quantity;
  final Function(int) onQuantityChanged;
  final String selectedSize;
  final List<String> sizes;
  final Function(String) onSizeSelected;

  const ProductOptionsWidget({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
    required this.selectedSize,
    required this.sizes,
    required this.onSizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Quantity",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 36.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1C2526),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                    onPressed: () {
                      if (quantity > 0) {
                        onQuantityChanged(quantity - 1);
                      }
                    },
                  ),
                  Text(
                    quantity.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                    onPressed: () {
                      onQuantityChanged(quantity + 1);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(width: 32.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Size",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 8.h,
                children: sizes.map((size) {
                  final isSelected = selectedSize == size;
                  return GestureDetector(
                    onTap: () => onSizeSelected(size),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSelected
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: isSelected
                              ? const Color(0xFF2196F3)
                              : Colors.white54,
                          size: 18.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          size,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.white54,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
