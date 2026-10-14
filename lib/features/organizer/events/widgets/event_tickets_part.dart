import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/create_event_helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventTicketsPart extends StatelessWidget {
  final bool isPaid;
  final bool free;
  final bool ticketAccessibilityOpen;
  final bool accessCode;
  final TextEditingController ticketNameController;
  final TextEditingController ticketPriceController;
  final TextEditingController totalQuantityController;
  final TextEditingController minPerUserController;
  final TextEditingController maxPerUserController;
  final Function(bool) onFreeChanged;
  final Function(bool) onAccessibilityChanged;
  final Function(bool) onAccessCodeChanged;

  const EventTicketsPart({
    super.key,
    required this.isPaid,
    required this.free,
    required this.ticketAccessibilityOpen,
    required this.accessCode,
    required this.ticketNameController,
    required this.ticketPriceController,
    required this.totalQuantityController,
    required this.minPerUserController,
    required this.maxPerUserController,
    required this.onFreeChanged,
    required this.onAccessibilityChanged,
    required this.onAccessCodeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLabel("Free"),
              Switch(
                value: free,
                onChanged: onFreeChanged,
                activeColor: Colors.white,
                activeTrackColor: AppColor.c2196F3,
                inactiveTrackColor: AppColor.c707171,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLabel("Ticket Accessibility Open"),
              Switch(
                value: ticketAccessibilityOpen,
                onChanged: onAccessibilityChanged,
                activeColor: Colors.white,
                activeTrackColor: AppColor.c2196F3,
                inactiveTrackColor: AppColor.c707171,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLabel("Access Code"),
              Switch(
                value: accessCode,
                onChanged: onAccessCodeChanged,
                activeColor: Colors.white,
                activeTrackColor: AppColor.c2196F3,
                inactiveTrackColor: AppColor.c707171,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          buildLabel("Ticket Name"),
          CustomTextfieldWidget(
            hintText: "General Entry",
            controller: ticketNameController,
          ),
          if (isPaid) ...[
            SizedBox(height: 16.h),
            buildLabel("Ticket Price"),
            CustomTextfieldWidget(
              hintText: "100",
              controller: ticketPriceController,
              prefixText: "\$ ",
            ),
          ],
          SizedBox(height: 16.h),
          buildLabel("Total Quantity"),
          buildNumericField(totalQuantityController),

          SizedBox(height: 16.h),
          buildLabel("Min per User"),
          buildNumericField(minPerUserController),

          SizedBox(height: 16.h),
          buildLabel("Max per User"),
          buildNumericField(maxPerUserController),

          // SizedBox(height: 20.h),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 60.w),
          //   child: buildOutlineButton("+   Add Ticket", onTap: () {}),
          // ),
          // _buildQuickRegistrationCard(),
          // SizedBox(height: 100.h),
        ],
      ),
    );
  }
}
