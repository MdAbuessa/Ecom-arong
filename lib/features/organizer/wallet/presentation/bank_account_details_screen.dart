import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/features/organizer/wallet/widgets/withdraw_request.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankAccountDetailsScreen extends StatefulWidget {
  final WithdrawRequest request;

  const BankAccountDetailsScreen({super.key, required this.request});

  @override
  State<BankAccountDetailsScreen> createState() => _BankAccountDetailsScreenState();
}

class _BankAccountDetailsScreenState extends State<BankAccountDetailsScreen> {
  final TextEditingController _holderNameController = TextEditingController(text: "John Organizer");
  String _selectedBank = "ABC Bank";
  final TextEditingController _accountNumberController = TextEditingController(text: "1234 5678 9012");
  final TextEditingController _routingNumberController = TextEditingController(text: "110000123");
  final TextEditingController _swiftController = TextEditingController(text: "");

  final List<String> _banksList = [
    "ABC Bank",
    "Chase Bank",
    "Bank of America",
    "Wells Fargo",
    "CitiBank",
  ];

  void _showBankSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B232A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: const BorderSide(color: Color(0x0DFFFFFF)),
        ),
        title: Text(
          "Select Bank",
          style: TextFontStyle.textStyle16InterW600.copyWith(color: Colors.white),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _banksList.length,
            itemBuilder: (context, index) {
              final bankName = _banksList[index];
              return ListTile(
                title: Text(
                  bankName,
                  style: TextFontStyle.textStyle14InterW500.copyWith(
                    color: _selectedBank == bankName ? AppColor.c2196F3 : Colors.white70,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedBank = bankName;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleNextTap() {
    if (_holderNameController.text.trim().isEmpty ||
        _accountNumberController.text.trim().isEmpty ||
        _routingNumberController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF2D1214),
          content: Text(
            "Please fill all required bank details.",
            style: TextFontStyle.textStyle14InterW500.copyWith(color: const Color(0xFFE74C3C)),
          ),
        ),
      );
      return;
    }

    final updatedRequest = widget.request.copyWith(
      holderName: _holderNameController.text,
      bankName: _selectedBank,
      accountNumber: _accountNumberController.text,
      routingNumber: _routingNumberController.text,
      swift: _swiftController.text.isNotEmpty ? _swiftController.text : null,
    );

    NavigationService.navigateTo(Routes.reviewWithdrawalScreen, arguments: updatedRequest);
  }

  Widget _buildTextFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: TextFontStyle.textStyle14InterW500.copyWith(
          color: Colors.white70,
          fontSize: 13.sp,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextFontStyle.textStyle14InterW400.copyWith(color: Colors.white30),
      filled: true,
      fillColor: const Color(0xFF141C22),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: Color(0x0DFFFFFF)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: Color(0x0DFFFFFF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: const BorderSide(color: AppColor.c2196F3, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        onBackTap: () {
          NavigationService.goBack;
        },
        title: "Bank Account Details",
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextFieldLabel("Account Holder Name"),
                    TextField(
                      controller: _holderNameController,
                      style: TextFontStyle.textStyle14InterW500.copyWith(color: Colors.white),
                      decoration: _inputDecoration("Enter holder name"),
                    ),
                    SizedBox(height: 16.h),

                    _buildTextFieldLabel("Bank Name"),
                    GestureDetector(
                      onTap: _showBankSelectionDialog,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF141C22),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: const Color(0x0DFFFFFF)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedBank,
                              style: TextFontStyle.textStyle14InterW500.copyWith(color: Colors.white),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white70,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    _buildTextFieldLabel("Account Number"),
                    TextField(
                      controller: _accountNumberController,
                      style: TextFontStyle.textStyle14InterW500.copyWith(color: Colors.white),
                      decoration: _inputDecoration("Enter account number"),
                    ),
                    SizedBox(height: 16.h),

                    _buildTextFieldLabel("Routing Number"),
                    TextField(
                      controller: _routingNumberController,
                      style: TextFontStyle.textStyle14InterW500.copyWith(color: Colors.white),
                      decoration: _inputDecoration("Enter your number"),
                    ),
                    SizedBox(height: 16.h),

                    _buildTextFieldLabel("SWIFT/ IFWSC (optional)"),
                    TextField(
                      controller: _swiftController,
                      style: TextFontStyle.textStyle14InterW500.copyWith(color: Colors.white),
                      decoration: _inputDecoration("Enter swift"),
                    ),
                  ],
                ),
              ),
            ),
            // Persistent Button at bottom
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Container(
                width: double.infinity,
                height: 52.h,
                decoration: BoxDecoration(
                  color: AppColor.c2196F3,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: TextButton(
                  onPressed: _handleNextTap,
                  child: Text(
                    "Review & Submit",
                    style: TextFontStyle.textStyle16InterW600.copyWith(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
