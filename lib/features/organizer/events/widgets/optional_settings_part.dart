import 'package:aarongonzales01/features/organizer/events/widgets/create_event_helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionalSettingsPart extends StatefulWidget {
  final String? initialStatus;
  final String? initialNotification;

  const OptionalSettingsPart({
    super.key,
    this.initialStatus,
    this.initialNotification,
  });

  @override
  State<OptionalSettingsPart> createState() => OptionalSettingsPartState();
}

class OptionalSettingsPartState extends State<OptionalSettingsPart>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String selectedStatus = "Ongoing";
  final List<String> _statusOptions = ["Ongoing", "Draft"];
  final TextEditingController notificationController = TextEditingController(
    text: "2",
  );

  @override
  void initState() { 
    super.initState();
    if (widget.initialStatus != null) {
      final matched = _statusOptions.firstWhere(
        (s) => s.toLowerCase() == widget.initialStatus!.toLowerCase(),
        orElse: () => "Ongoing",
      );
      selectedStatus = matched;
    }
    if (widget.initialNotification != null) {
      notificationController.text = widget.initialNotification!;
    }
  }

  @override
  void dispose() {
    notificationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStepper(3),
          buildLabel("Event Status"),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: selectedStatus,
                dropdownColor: const Color(0xFF0F1B2A),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(color: Colors.white, fontSize: 14),
                onChanged: (val) {
                  setState(() {
                    selectedStatus = val!;
                  });
                },
                items: _statusOptions.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(
                      status,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          buildLabel("Notification Remainder"),
          buildNumericField(notificationController),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }
}
