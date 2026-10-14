import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/create_event_helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateTimePart extends StatefulWidget {
  final bool isRecurring;
  final List<String> selectedDays;
  final List<String> days;
  final Function(bool) onRecurringChanged;
  final Function(String) onDayToggled;
  final DateTime? initialDate;

  const DateTimePart({
    super.key,
    required this.isRecurring,
    required this.selectedDays,
    required this.days,
    required this.onRecurringChanged,
    required this.onDayToggled,
    this.initialDate,
  });

  @override
  State<DateTimePart> createState() => DateTimePartState();
}

class DateTimePartState extends State<DateTimePart> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final TextEditingController dateController = TextEditingController();
  final List<Map<String, TextEditingController>> timeSlots = [];
  String repeatOption = "Weekly";

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      dateController.text = "${widget.initialDate!.day}/${widget.initialDate!.month}/${widget.initialDate!.year}";
      final hour = widget.initialDate!.hour.toString().padLeft(2, '0');
      final minute = widget.initialDate!.minute.toString().padLeft(2, '0');
      final endHour = ((widget.initialDate!.hour + 1) % 24).toString().padLeft(2, '0');
      timeSlots.add({
        "start": TextEditingController(text: "$hour:$minute"),
        "end": TextEditingController(text: "$endHour:$minute"),
      });
    } else {
      timeSlots.add({
        "start": TextEditingController(),
        "end": TextEditingController(),
      });
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    for (var slot in timeSlots) {
      slot["start"]?.dispose();
      slot["end"]?.dispose();
    }
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColor.c2196F3,
              onPrimary: Colors.white,
              surface: Color(0xFF0F1B2A),
              onSurface: Colors.white,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF0F1B2A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dateController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColor.c2196F3,
              onPrimary: Colors.white,
              surface: Color(0xFF0F1B2A),
              onSurface: Colors.white,
            ),
            dialogTheme: const DialogThemeData(
              backgroundColor: Color(0xFF0F1B2A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildStepper(1),
          Row(
            children: [
              Expanded(
                child: buildTabButton(
                  "single event",
                  !widget.isRecurring,
                  () => widget.onRecurringChanged(false),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: buildTabButton(
                  "Recurring Event",
                  widget.isRecurring,
                  () => widget.onRecurringChanged(true),
                ),
              ),
            ],
          ),
          if (widget.isRecurring) ...[
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabel("Repeat on"),
                  PopupMenuButton<String>(
                    offset: const Offset(0, 50),
                    color: const Color(0xFF0F1B2A),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    onSelected: (String value) {
                      setState(() {
                        repeatOption = value;
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'Daily',
                            child: Text(
                              'Daily',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Weekly',
                            child: Text(
                              'Weekly',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Monthly',
                            child: Text(
                              'Monthly',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'Yearly',
                            child: Text(
                              'Yearly',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                    child: buildDropdown(repeatOption, icon: Icons.refresh),
                  ),
                  SizedBox(height: 20.h),
                  buildLabel("Repeat on"),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 12.h,
                    children: widget.days.map((day) {
                      bool isSelected = widget.selectedDays.contains(day);
                      return GestureDetector(
                        onTap: () => widget.onDayToggled(day),
                        child: Container(
                          width: 65.w,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColor.c2196F3
                                : Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              day,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 20.h),
          buildLabel("Event Date"),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: CustomTextfieldWidget(
                hintText: "DD/MM/YYYY",
                controller: dateController,
                suffixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          buildLabel("Time Slot"),
          SizedBox(height: 12.h),
          ...List.generate(timeSlots.length, (index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: _buildTimeSlot(index + 1, timeSlots[index]),
            );
          }),
          SizedBox(height: 4.h),
          buildOutlineButton(
            "+ Add Time slot",
            fullWidth: true,
            onTap: () {
              setState(() {
                timeSlots.add({
                  "start": TextEditingController(),
                  "end": TextEditingController(),
                });
              });
            },
          ),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildTimeSlot(int index, Map<String, TextEditingController> slot) {
    final startController = slot["start"]!;
    final endController = slot["end"]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Slot $index",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  timeSlots.removeAt(index - 1);
                });
              },
              child: const Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
                size: 20,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, startController),
                child: AbsorbPointer(
                  child: CustomTextfieldWidget(
                    hintText: "Start time",
                    controller: startController,
                    suffixIcon: const Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: GestureDetector(
                onTap: () => _selectTime(context, endController),
                child: AbsorbPointer(
                  child: CustomTextfieldWidget(
                    hintText: "End time",
                    controller: endController,
                    suffixIcon: const Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
