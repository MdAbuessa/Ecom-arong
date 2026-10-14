import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/organizer/wallet/widgets/transaction_card.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  int _activeTabIndex = 0; // 0: All, 1: Pending, 2: Completed, 3: Rejected

  final List<Map<String, String>> _allTransactions = [
    {
      "amount": "\$1,000.00",
      "method": "Bank Transfer",
      "dateTime": "Apr 10, 2025 at 02:15 PM",
      "status": "Completed",
    },
    {
      "amount": "\$1,000.00",
      "method": "Bank Transfer",
      "dateTime": "Apr 10, 2025 at 02:15 PM",
      "status": "Completed",
    },
    {
      "amount": "\$1,000.00",
      "method": "Stripe",
      "dateTime": "Apr 10, 2025 at 02:15 PM",
      "status": "Pending",
    },
    {
      "amount": "\$1,000.00",
      "method": "Stripe",
      "dateTime": "Apr 10, 2025 at 02:15 PM",
      "status": "Pending",
    },
    {
      "amount": "\$1,000.00",
      "method": "Stripe",
      "dateTime": "Apr 10, 2025 at 02:15 PM",
      "status": "Pending",
    },
    {
      "amount": "\$1,000.00",
      "method": "Stripe",
      "dateTime": "Apr 10, 2025 at 02:15 PM",
      "status": "Pending",
    },
    {
      "amount": "\$1,000.00",
      "method": "Stripe",
      "dateTime": "Apr 10, 2025 at 02:15 PM",
      "status": "Pending",
    },
    {
      "amount": "\$1,000.00",
      "method": "Bank Transfer",
      "dateTime": "Apr 10, 2025 at 02:15 PM",
      "status": "Rejected",
    },
    {
      "amount": "\$1,000.00",
      "method": "Bank Transfer",
      "dateTime": "Apr 10, 2025 at 02:15 PM",
      "status": "Rejected",
    },
    {
      "amount": "\$1,000.00",
      "method": "Bank Transfer",
      "dateTime": "Apr 10, 2025 at 02:15 PM",
      "status": "Rejected",
    },
  ];

  List<Map<String, String>> get _filteredTransactions {
    switch (_activeTabIndex) {
      case 1:
        return _allTransactions.where((t) => t['status'] == 'Pending').toList();
      case 2:
        return _allTransactions.where((t) => t['status'] == 'Completed').toList();
      case 3:
        return _allTransactions.where((t) => t['status'] == 'Rejected').toList();
      case 0:
      default:
        return _allTransactions;
    }
  }

  Widget _buildTabItem(int index, String label) {
    final bool isActive = _activeTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTabIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextFontStyle.textStyle14InterW500.copyWith(
              color: isActive ? Colors.white : Colors.white54,
              fontSize: 12.sp,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 2.h,
            width: 65.w,
            color: isActive ? AppColor.c2196F3 : Colors.transparent,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredTransactions;

    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        onBackTap: () {
          NavigationService.goBack;
        },
        title: "All Transactions",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTabItem(0, "All (10)"),
                  SizedBox(width: 16.w),
                  _buildTabItem(1, "Pending (05)"),
                  SizedBox(width: 16.w),
                  _buildTabItem(2, "Completed (02)"),
                  SizedBox(width: 16.w),
                  _buildTabItem(3, "Rejected (03)"),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Transactions list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final t = filtered[index];
                return TransactionCard(
                  amount: t['amount']!,
                  method: t['method']!,
                  dateTime: t['dateTime']!,
                  status: t['status']!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
