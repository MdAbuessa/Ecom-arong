import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/user/shop/widgets/cart_item_widget.dart';
import 'package:aarongonzales01/features/user/shop/widgets/cart_order_info_widget.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      "image": "assets/images/product1.png",
      "title": "Event Backpack",
      "size": "M",
      "color": "White",
      "price": 20.00,
      "quantity": 1,
      "isSelected": true,
    },
    {
      "image": "assets/images/product2.png",
      "title": "Running Cap",
      "size": "Regular",
      "color": "White",
      "price": 12.00,
      "quantity": 1,
      "isSelected": true,
    },
    {
      "image": "assets/images/product1.png",
      "title": "Event Backpack",
      "size": "Regular",
      "color": "Blue",
      "price": 30.00,
      "quantity": 1,
      "isSelected": true,
    },
  ];

  double get _subtotal {
    double total = 0;
    for (var item in _cartItems) {
      if (item['isSelected']) {
        total += item['price'] * item['quantity'];
      }
    }
    return total;
  }

  final double _pointDiscount = 10.00;
  final double _deliveryFee = 5.00;

  double get _totalAmount {
    if (_subtotal == 0) return 0.0;
    final total = _subtotal - _pointDiscount + _deliveryFee;
    return total > 0 ? total : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B1E),
      appBar: ProfileAppBar(
        title: "Cart",
        onBackTap: () {
          NavigationService.goBack;
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: _cartItems.length,
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.white.withOpacity(0.05), height: 32.h),
              itemBuilder: (context, index) {
                final item = _cartItems[index];
                return CartItemWidget(
                  item: item,
                  onToggleSelection: () {
                    setState(() {
                      item['isSelected'] = !item['isSelected'];
                    });
                  },
                  onIncreaseQuantity: () {
                    setState(() {
                      item['quantity']++;
                    });
                  },
                  onDecreaseQuantity: () {
                    if (item['quantity'] > 1) {
                      setState(() {
                        item['quantity']--;
                      });
                    }
                  },
                  onDelete: () {
                    setState(() {
                      _cartItems.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
          CartOrderInfoWidget(
            subtotal: _subtotal,
            pointDiscount: _pointDiscount,
            deliveryFee: _deliveryFee,
            totalAmount: _totalAmount,
            onCheckout: () {},
          ),
        ],
      ),
    );
  }
}
