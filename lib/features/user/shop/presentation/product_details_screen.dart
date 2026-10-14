import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/common_widgets/custom_save_button.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/user/shop/widgets/product_buy_now_dialog_widget.dart';
import 'package:aarongonzales01/features/user/shop/widgets/product_color_picker_widget.dart';
import 'package:aarongonzales01/features/user/shop/widgets/product_image_gallery_widget.dart';
import 'package:aarongonzales01/features/user/shop/widgets/product_info_widget.dart';
import 'package:aarongonzales01/features/user/shop/widgets/product_options_widget.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _quantity = 0;
  String _selectedSize = 'M';
  int _selectedColorIndex = 1;

  final List<Color> _colors = [
    const Color(0xFF4A4E69),
    Colors.white,
    const Color(0xFF4527A0),
    const Color(0xFF2196F3),
    const Color(0xFF787186),
  ];

  final List<String> _sizes = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B1E),
      appBar: ProfileAppBar(
        title: "Shop",
        onBackTap: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProductImageGalleryWidget(),
            SizedBox(height: 16.h),
            const ProductInfoWidget(),
            SizedBox(height: 20.h),
            ProductColorPickerWidget(
              colors: _colors,
              selectedColorIndex: _selectedColorIndex,
              onColorSelected: (index) {
                setState(() {
                  _selectedColorIndex = index;
                });
              },
            ),
            SizedBox(height: 24.h),
            ProductOptionsWidget(
              quantity: _quantity,
              onQuantityChanged: (qty) {
                setState(() {
                  _quantity = qty;
                });
              },
              selectedSize: _selectedSize,
              sizes: _sizes,
              onSizeSelected: (size) {
                setState(() {
                  _selectedSize = size;
                });
              },
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                Expanded(
                  child: CustomSaveButton(
                    btnColor: AppColor.c111827,
                    borderColor: AppColor.c2196F3,
                    btnText: "Buy Now",
                    onCall: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ProductBuyNowDialogWidget(),
                      );
                    },
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: CustomSaveButton(
                    btnText: "Add to cart",
                    onCall: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
