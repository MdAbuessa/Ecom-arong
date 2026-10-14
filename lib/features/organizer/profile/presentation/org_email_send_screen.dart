import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/common_widgets/custom_textfield_widget.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/audience_card.dart';
import 'package:aarongonzales01/features/organizer/profile/widgets/profile_app_bar.dart';
import 'package:aarongonzales01/helpers/navigation_service.dart';
import 'package:aarongonzales01/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrgEmailSendScreen extends StatefulWidget {
  const OrgEmailSendScreen({super.key});

  @override
  State<OrgEmailSendScreen> createState() => _OrgEmailSendScreenState();
}

class _OrgEmailSendScreenState extends State<OrgEmailSendScreen> {
  int _selectedAudienceIndex = 0; // 0: All, 1: Specific
  bool _isEventDropdownOpen = false;
  String _selectedEvent = "Choose an event";

  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final List<String> _events = [
    "Summer 5K Challenge(156 participants)",
    "Mountain Trail Marathon(89 participants)",
    "Trail Running Adventure(70 participants)",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      appBar: ProfileAppBar(
        onBackTap: () {
          NavigationService.goBack;
        },
        title: "Select Audience",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Audience Cards
            AudienceCard(
              title: "All Participants",
              subtitle: "Send to all registered participants across all events",
              isSelected: _selectedAudienceIndex == 0,
              onTap: () => setState(() {
                _selectedAudienceIndex = 0;
                _isEventDropdownOpen = false;
              }),
            ),
            AudienceCard(
              title: "Specific Event",
              subtitle: "Send to participants of a selected event",
              isSelected: _selectedAudienceIndex == 1,
              onTap: () => setState(() => _selectedAudienceIndex = 1),
            ),

            // Specific Event Dropdown (Popup)
            if (_selectedAudienceIndex == 1) ...[
              SizedBox(height: 8.h),
              _buildEventDropdown(),
            ],

            SizedBox(height: 32.h),

            // Header: Compose Email
            Row(
              children: [
                Icon(Icons.mail_outline, color: AppColor.c2196F3, size: 24.sp),
                SizedBox(width: 12.w),
                Text(
                  "Compose Email",
                  style: TextFontStyle.textStyle14InterW500.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 21.h),

            // Subject
            Text(
              "Subject",
              style: TextFontStyle.textStyle14InterW500.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            CustomTextfieldWidget(
              hintText: "Enter email subject",
              controller: _subjectController,
            ),

            SizedBox(height: 20.h),

            // Message
            Text(
              "Message",
              style: TextFontStyle.textStyle14InterW500.copyWith(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: const Color(0xFF0B1A20),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white10),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: null,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter your message",
                  hintStyle: TextStyle(color: Colors.white24, fontSize: 14.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.w),
                ),
              ),
            ),
            SizedBox(height: 40.h),

            // Footer
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.c2196F3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 12.h,
                    ),
                  ),
                  child: Text(
                    "Send",
                    style: TextFontStyle.textStyle16InterW600,
                  ),
                ),
                // const Spacer()
                UIHelper.horizontalSpace(20.w),
                _buildToolbarIcon(Icons.text_format),
                _buildToolbarIcon(Icons.attach_file),
                _buildToolbarIcon(Icons.link),
                _buildToolbarIcon(Icons.emoji_emotions_outlined),
                _buildToolbarIcon(Icons.warning_amber_rounded),
                _buildToolbarIcon(Icons.image_outlined),
                _buildToolbarIcon(Icons.edit_outlined),
                _buildToolbarIcon(Icons.delete_outline),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildEventDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B1A20),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.c2196F3.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                setState(() => _isEventDropdownOpen = !_isEventDropdownOpen),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: _isEventDropdownOpen
                        ? Colors.white10
                        : Colors.transparent,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    _selectedEvent,
                    style: TextFontStyle.textStyle14InterW500.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    _isEventDropdownOpen
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white54,
                  ),
                ],
              ),
            ),
          ),
          if (_isEventDropdownOpen)
            Column(
              children: _events.map((event) {
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedEvent = event;
                    _isEventDropdownOpen = false;
                  }),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Text(
                      event,
                      style: TextFontStyle.textStyle14InterW500.copyWith(
                        color: Colors.white70,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildToolbarIcon(IconData icon) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Icon(icon, color: Colors.white24, size: 20.sp),
    );
  }
}
