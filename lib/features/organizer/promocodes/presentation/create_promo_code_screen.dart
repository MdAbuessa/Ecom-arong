import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_save_button.dart';
import 'package:aarongonzales01/features/organizer/promocodes/widgets/promo_code_model.dart';
import 'package:aarongonzales01/features/organizer/promocodes/widgets/promo_code_spinner_input.dart';
import 'package:aarongonzales01/features/organizer/promocodes/widgets/promo_code_date_selector.dart';
import 'package:aarongonzales01/features/organizer/promocodes/widgets/discount_type_card.dart';
import 'package:aarongonzales01/features/organizer/promocodes/widgets/apply_to_card.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/all_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreatePromoCodeScreen extends StatefulWidget {
  const CreatePromoCodeScreen({super.key});

  @override
  State<CreatePromoCodeScreen> createState() => _CreatePromoCodeScreenState();
}

class _CreatePromoCodeScreenState extends State<CreatePromoCodeScreen> {
  final _nameController = TextEditingController(text: "General Entry");
  final _discountController = TextEditingController(text: "10");
  final _limitController = TextEditingController(text: "50");

  DiscountType _discountType = DiscountType.percentage;
  ApplyToType _applyToType = ApplyToType.single;

  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _mockEvents = [
    "SK City Run",
    "Jk City Run",
    "Summer Music Festival",
  ];

  String _selectedDropdownEvent = "SK City Run";
  final List<String> _selectedEvents = ["SK City Run"];

  @override
  void dispose() {
    _nameController.dispose();
    _discountController.dispose();
    _limitController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColor.c2196F3,
              onPrimary: Colors.white,
              surface: Color(0xFF111C24),
              onSurface: Colors.white,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF081014),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "";
    final months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    final month = months[date.month - 1];
    return "$month ${date.day.toString().padLeft(2, '0')}, ${date.year}";
  }

  void _handleApplyToSelection(ApplyToType type) {
    setState(() {
      _applyToType = type;
      if (type == ApplyToType.single) {
        _selectedEvents.clear();
        _selectedEvents.add(_selectedDropdownEvent);
      } else if (type == ApplyToType.multiple) {
        if (!_selectedEvents.contains("SK City Run")) {
          _selectedEvents.add("SK City Run");
        }
        if (!_selectedEvents.contains("Jk City Run")) {
          _selectedEvents.add("Jk City Run");
        }
      } else {
        _selectedEvents.clear();
        _selectedEvents.addAll(_mockEvents);
      }
    });
  }

  void _handleDropdownEventChanged(String? val) {
    if (val == null) return;
    setState(() {
      _selectedDropdownEvent = val;
      if (_applyToType == ApplyToType.single) {
        _selectedEvents.clear();
        _selectedEvents.add(val);
      } else if (_applyToType == ApplyToType.multiple) {
        if (!_selectedEvents.contains(val)) {
          _selectedEvents.add(val);
        }
      }
    });
  }

  void _handleCheckboxToggle(String event, bool? checked) {
    if (checked == null) return;
    setState(() {
      if (_applyToType == ApplyToType.single) {
        _selectedEvents.clear();
        if (checked) {
          _selectedEvents.add(event);
          _selectedDropdownEvent = event;
        }
      } else {
        if (checked) {
          if (!_selectedEvents.contains(event)) {
            _selectedEvents.add(event);
          }
        } else {
          if (_selectedEvents.length > 1) {
            _selectedEvents.remove(event);
          }
        }
      }
    });
  }

  void _submitForm() {
    final name = _nameController.text.trim();
    final discountValStr = _discountController.text.trim();
    final limitStr = _limitController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a Promo Code Name"),
          backgroundColor: Color(0xFFD64545),
        ),
      );
      return;
    }

    final discountVal = int.tryParse(discountValStr) ?? 0;
    if (discountVal <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Discount value must be greater than 0"),
          backgroundColor: Color(0xFFD64545),
        ),
      );
      return;
    }

    final limit = int.tryParse(limitStr) ?? 0;
    if (limit <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Usage limit must be greater than 0"),
          backgroundColor: Color(0xFFD64545),
        ),
      );
      return;
    }

    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select start and end dates"),
          backgroundColor: Color(0xFFD64545),
        ),
      );
      return;
    }

    if (_endDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("End date cannot be before start date"),
          backgroundColor: Color(0xFFD64545),
        ),
      );
      return;
    }

    if (_selectedEvents.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select at least one event"),
          backgroundColor: Color(0xFFD64545),
        ),
      );
      return;
    }

    final cleanName = name.replaceAll(RegExp(r'[^a-zA-Z]'), '').toUpperCase();
    final prefix = cleanName.length >= 3 ? cleanName.substring(0, 3) : "PRM";
    final randomSuffix = UniqueKey().hashCode.toString().substring(0, 5);
    final promoCodeString =
        "$prefix-${_discountType == DiscountType.percentage ? 'PCT' : 'FIX'}$randomSuffix";

    final promoCode = PromoCode(
      name: name,
      discountType: _discountType,
      discountValue: discountVal,
      usageLimit: limit,
      startDate: _startDate,
      endDate: _endDate,
      applyTo: _applyToType,
      selectedEvents: List.from(_selectedEvents),
      promoCode: promoCodeString,
    );

    NavigationService.navigateTo(
      Routes.promoCodeCreatedScreen,
      arguments: promoCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 90.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 5.w, top: 5.h, bottom: 5.h),
          child: GestureDetector(
            onTap: () {
              NavigationService.goBack;
            },
            child: Center(
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  color: AppColor.c2196F3,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Create Promo Code",
          style: TextFontStyle.textStyle24RobotoW600.copyWith(
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel("Promo Code Name"),
            _buildTextField(
              controller: _nameController,
              hintText: "General Entry",
            ),
            SizedBox(height: 16.h),
            _buildLabel("Discount Type"),
            Row(
              children: [
                Expanded(
                  child: DiscountTypeCard(
                    isSelected: _discountType == DiscountType.percentage,
                    label: "Percentage (%)",
                    onTap: () {
                      setState(() {
                        _discountType = DiscountType.percentage;
                      });
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: DiscountTypeCard(
                    isSelected: _discountType == DiscountType.fixed,
                    label: "Fixed Amount (\$)",
                    onTap: () {
                      setState(() {
                        _discountType = DiscountType.fixed;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildLabel("Discount Value"),
            PromoCodeSpinnerInput(
              controller: _discountController,
              prefixText: _discountType == DiscountType.percentage ? "%" : "\$",
            ),
            SizedBox(height: 16.h),
            _buildLabel("Usage Limit"),
            PromoCodeSpinnerInput(
              controller: _limitController,
              prefixText: null,
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Start Date"),
                      PromoCodeDateSelector(
                        dateString: _startDate != null
                            ? _formatDate(_startDate)
                            : "Start time",
                        isSelected: _startDate != null,
                        onTap: () => _selectDate(context, true),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("End Date"),
                      PromoCodeDateSelector(
                        dateString: _endDate != null
                            ? _formatDate(_endDate)
                            : "End time",
                        isSelected: _endDate != null,
                        onTap: () => _selectDate(context, false),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            _buildLabel("Apply To"),
            ApplyToCard(
              isSelected: _applyToType == ApplyToType.single,
              title: "Single Event",
              subtitle: "Apply to one specific event",
              onTap: () => _handleApplyToSelection(ApplyToType.single),
            ),
            SizedBox(height: 12.h),
            ApplyToCard(
              isSelected: _applyToType == ApplyToType.multiple,
              title: "Multiple Events",
              subtitle: "Select multiple events",
              onTap: () => _handleApplyToSelection(ApplyToType.multiple),
            ),
            SizedBox(height: 12.h),
            ApplyToCard(
              isSelected: _applyToType == ApplyToType.all,
              title: "All Events",
              subtitle: "Current and future events",
              onTap: () => _handleApplyToSelection(ApplyToType.all),
            ),
            if (_applyToType != ApplyToType.all) ...[
              SizedBox(height: 20.h),
              _buildLabel("Select event"),
              _buildEventDropdown(),
              SizedBox(height: 20.h),
              _buildLabel("Selected event"),
              _buildSelectedEventsList(),
            ],
            SizedBox(height: 32.h),
            CustomSaveButton(
              btnText: 'Continue',
              onCall: () {
                _submitForm();
              },
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        label,
        style: TextFontStyle.textStyle14InterW500.copyWith(
          color: const Color(0xFF8E9AA5),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111A20),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF1C2A35), width: 1.w),
      ),
      child: TextField(
        controller: controller,
        cursorColor: AppColor.c2196F3,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white24),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildEventDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF111A20),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF1C2A35), width: 1.w),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDropdownEvent,
          dropdownColor: const Color(0xFF111A20),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white54),
          isExpanded: true,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          onChanged: _handleDropdownEventChanged,
          items: _mockEvents.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                "($item)",
                style: const TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSelectedEventsList() {
    final itemsToShow = _applyToType == ApplyToType.single
        ? [_selectedDropdownEvent]
        : _mockEvents;

    return Column(
      children: itemsToShow.map((event) {
        final isChecked = _selectedEvents.contains(event);
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFF111A20),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF1C2A35), width: 1.w),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("($event)", style: const TextStyle(color: Colors.white)),
              Checkbox(
                value: isChecked,
                activeColor: AppColor.c2196F3,
                checkColor: Colors.white,
                side: const BorderSide(color: Color(0xFF454F5B)),
                onChanged: (val) => _handleCheckboxToggle(event, val),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
