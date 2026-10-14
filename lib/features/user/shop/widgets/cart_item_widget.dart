import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemWidget extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onToggleSelection;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback onDecreaseQuantity;
  final VoidCallback onDelete;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onToggleSelection,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Image.asset(item['image'], fit: BoxFit.contain),
          ),
        ),
        SizedBox(width: 16.w),
        // Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item['title'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onToggleSelection,
                    child: Container(
                      width: 18.w,
                      height: 18.w,
                      decoration: BoxDecoration(
                        color: item['isSelected']
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: item['isSelected']
                              ? Colors.white
                              : Colors.white54,
                        ),
                      ),
                      child: item['isSelected']
                          ? Icon(Icons.check, color: Colors.black, size: 14.sp)
                          : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                "Size: ${item['size']}   Color: ${item['color']}",
                style: TextStyle(color: Colors.white54, fontSize: 12.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                "\$${item['price'].toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Quantity Adjuster
                  Container(
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          constraints: const BoxConstraints(),
                          iconSize: 16.sp,
                          icon: const Icon(Icons.remove, color: Colors.white54),
                          onPressed: onDecreaseQuantity,
                        ),
                        Text(
                          item['quantity'].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                        IconButton(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          constraints: const BoxConstraints(),
                          iconSize: 16.sp,
                          icon: const Icon(Icons.add, color: Colors.white54),
                          onPressed: onIncreaseQuantity,
                        ),
                      ],
                    ),
                  ),
                  // Delete Icon
                  GestureDetector(
                    onTap: onDelete,
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
