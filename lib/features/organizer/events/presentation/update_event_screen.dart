import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:aarongonzales01/features/organizer/community/widgets/banner_section_part.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/attendee_information_part.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/basic_info_part.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/date_time_part.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/event_tickets_part.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/optional_settings_part.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:aarongonzales01/features/organizer/events/model/event_details_model.dart';

class UpdateEventScreen extends StatefulWidget {
  const UpdateEventScreen({super.key});

  @override
  State<UpdateEventScreen> createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final GlobalKey<BasicInfoPartState> _basicInfoKey =
      GlobalKey<BasicInfoPartState>();
  final GlobalKey<DateTimePartState> _dateTimeKey =
      GlobalKey<DateTimePartState>();
  final GlobalKey<AttendeeInformationPartState> _attendeeInfoKey =
      GlobalKey<AttendeeInformationPartState>();
  final GlobalKey<OptionalSettingsPartState> _optionalSettingsKey =
      GlobalKey<OptionalSettingsPartState>();

  // Basic Info Controllers
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationMapController = TextEditingController();

  // Ticketing Controllers
  final _ticketNameController = TextEditingController();
  final _ticketPriceController = TextEditingController();
  final _totalQuantityController = TextEditingController(text: '10');
  final _maxPerUserController = TextEditingController(text: '10');
  final _minPerUserController = TextEditingController(text: '1');

  // Validity & Timing State
  bool _isRecurring = true;
  List<String> selectedDays = ["Mon", "Wed"];
  final List<String> _days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  bool isPaid = true;
  bool ticketAccessibilityOpen = true;
  bool free = false;
  bool accessCode = true;
  bool _autoAssignRaceBib = true;
  String _visibility = 'Public';
  XFile? _profileImage;
  XFile? _coverImage;

  Data? _eventData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Data && _eventData == null) {
      _eventData = args;
      _populateFields();
    }
  }

  void _populateFields() {
    if (_eventData == null) return;
    _titleController.text = _eventData!.title ?? '';
    _locationController.text = _eventData!.locationName ?? '';
    _descriptionController.text = _eventData!.description ?? '';
    _locationMapController.text = _eventData!.locationName ?? '';
    _autoAssignRaceBib = _eventData!.autoAssignRaceBib ?? true;

    final visibilityStr = _eventData!.visibility ?? 'Public';
    _visibility = visibilityStr.isEmpty
        ? 'Public'
        : visibilityStr[0].toUpperCase() +
              visibilityStr.substring(1).toLowerCase();

    if (_eventData!.tickets != null && _eventData!.tickets!.isNotEmpty) {
      final ticket = _eventData!.tickets!.first;
      _ticketNameController.text = ticket.name ?? '';
      _ticketPriceController.text = ticket.price?.toString() ?? '';
      _totalQuantityController.text = ticket.quantity?.toString() ?? '10';
      _minPerUserController.text = ticket.minPerUser?.toString() ?? '1';
      _maxPerUserController.text = ticket.maxPerUser?.toString() ?? '10';
      free = ticket.isFree ?? false;
      ticketAccessibilityOpen = ticket.isAccessOpen ?? true;
      accessCode = ticket.accessCodeEnabled ?? false;
    }

    if (_eventData!.startDate != null) {
      _isRecurring = _eventData!.hasRecurrence ?? true;
    }
  }

  void _nextPage() {
    if (_currentIndex < 5) {
      setState(() {
        _currentIndex++;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF06113A), Colors.black, Colors.black],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: [
                    BasicInfoPart(
                      key: _basicInfoKey,
                      titleController: _titleController,
                      locationController: _locationController,
                      descriptionController: _descriptionController,
                      autoAssignRaceBib: _autoAssignRaceBib,
                      visibility: _visibility,
                      onAutoAssignChanged: (v) =>
                          setState(() => _autoAssignRaceBib = v),
                      onVisibilityChanged: (v) =>
                          setState(() => _visibility = v),
                      locationMapController: _locationMapController,
                      initialType: _eventData?.type,
                      initialCategory: _eventData?.category?.name,
                      initialSections: _eventData?.sections,
                    ),
                    EventTicketsPart(
                      isPaid: isPaid,
                      free: free,
                      ticketAccessibilityOpen: ticketAccessibilityOpen,
                      accessCode: accessCode,
                      ticketNameController: _ticketNameController,
                      ticketPriceController: _ticketPriceController,
                      totalQuantityController: _totalQuantityController,
                      minPerUserController: _minPerUserController,
                      maxPerUserController: _maxPerUserController,
                      onFreeChanged: (v) => setState(() => free = v),
                      onAccessibilityChanged: (v) =>
                          setState(() => ticketAccessibilityOpen = v),
                      onAccessCodeChanged: (v) =>
                          setState(() => accessCode = v),
                    ),
                    AttendeeInformationPart(
                      key: _attendeeInfoKey,
                      initialPresetQuestions: _eventData?.requiredAttendeeInfo,
                    ),
                    DateTimePart(
                      key: _dateTimeKey,
                      isRecurring: _isRecurring,
                      selectedDays: selectedDays,
                      days: _days,
                      onRecurringChanged: (v) =>
                          setState(() => _isRecurring = v),
                      onDayToggled: (day) {
                        setState(() {
                          if (selectedDays.contains(day)) {
                            selectedDays.remove(day);
                          } else {
                            selectedDays.add(day);
                          }
                        });
                      },
                      initialDate: _eventData?.startDate,
                    ),
                    BannerSectionPart(
                      profileImage: _profileImage,
                      coverImage: _coverImage,
                      initialProfileUrl: _eventData?.coverUrl,
                      initialCoverUrl: _eventData?.coverUrl,
                      onProfilePicked: (file) =>
                          setState(() => _profileImage = file),
                      onCoverPicked: (file) =>
                          setState(() => _coverImage = file),
                    ),
                    OptionalSettingsPart(
                      key: _optionalSettingsKey,
                      initialStatus: _eventData?.status,
                      initialNotification:
                          _eventData?.reminder?.toString() != null
                          ? "${_eventData!.reminder} hours before event"
                          : null,
                    ),
                  ],
                ),
              ),
              _buildBottomButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    String title = "Basic Info";
    if (_currentIndex == 1) title = "Event Tickets";
    if (_currentIndex == 2) title = "Attendee information";
    if (_currentIndex == 3) title = "Date & Time";
    if (_currentIndex == 4) title = "Banner Section";
    if (_currentIndex == 5) title = "Optional Settings";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: _previousPage,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: const BoxDecoration(
                  color: AppColor.c2196F3,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          Text(
            title,
            style: TextFontStyle.textStyle16InterW600.copyWith(
              fontSize: 18.sp,
              color: AppColor.c2196F3,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitCreateEvent() async {
    if (_eventData == null) return;
    final basicInfoState = _basicInfoKey.currentState;
    final dateTimeState = _dateTimeKey.currentState;
    final attendeeInfoState = _attendeeInfoKey.currentState;
    final optionalSettingsState = _optionalSettingsKey.currentState;

    if (basicInfoState == null ||
        dateTimeState == null ||
        attendeeInfoState == null ||
        optionalSettingsState == null) {
      return;
    }

    final Map<String, dynamic> formDataMap = {};

    // 1. Basic Info
    formDataMap["event_title"] = _titleController.text.trim();
    formDataMap["event_type"] = basicInfoState.selectedType.toLowerCase();
    formDataMap["event_category_slug"] = basicInfoState.selectedCategory
        .toLowerCase();
    formDataMap["location"] = _locationController.text.trim();
    formDataMap["latitude"] = "58.258";
    formDataMap["longitude"] = "89.369";
    formDataMap["distance_meters"] = "50";
    formDataMap["description"] = _descriptionController.text.trim();

    // 2. Sections
    for (int i = 0; i < basicInfoState.addedSections.length; i++) {
      final section = basicInfoState.addedSections[i];
      if (section is TitleSection) {
        formDataMap["sections[$i][title]"] = section.text;
        formDataMap["sections[$i][description]"] = "";
      } else if (section is TextSection) {
        formDataMap["sections[$i][title]"] = "Text";
        formDataMap["sections[$i][description]"] = section.controller.text;
      } else if (section is ImageSection) {
        formDataMap["sections[$i][title]"] = "Image";
        formDataMap["sections[$i][description]"] = "";
        if (section.imagePath != null) {
          if (section.imagePath!.startsWith('http')) {
            formDataMap["sections[$i][image_url]"] = section.imagePath;
          } else {
            formDataMap["sections[$i][image]"] = await MultipartFile.fromFile(
              section.imagePath!,
              filename: section.imagePath!.split('/').last,
            );
          }
        }
      }
    }

    // 3. Optional Info / settings (bib, visibility)
    formDataMap["auto_assign_race_bib"] = _autoAssignRaceBib ? "true" : "false";
    formDataMap["event_visibility"] = _visibility.toLowerCase();

    // 4. Ticketing Info
    formDataMap["is_free"] = free ? "true" : "false";
    formDataMap["ticket_accessibility_open"] = ticketAccessibilityOpen
        ? "true"
        : "false";
    formDataMap["has_access_code"] = accessCode ? "true" : "false";
    if (accessCode) {
      formDataMap["access_code"] = "access";
    }
    formDataMap["ticket_name"] = _ticketNameController.text.trim();
    formDataMap["ticket_price"] = _ticketPriceController.text.trim();
    formDataMap["ticket_total_quantity"] = _totalQuantityController.text.trim();
    formDataMap["min_per_user"] = _minPerUserController.text.trim();
    formDataMap["max_per_user"] = _maxPerUserController.text.trim();

    // 5. Preset Questions (Attendee info)
    for (var q in attendeeInfoState.questions) {
      final key =
          "question_${q["title"].toString().toLowerCase().replaceAll(' ', '_')}";
      formDataMap[key] = q["selected"] ? "true" : "false";
    }

    // 6. Custom Questions
    for (var cq in attendeeInfoState.customQuestions) {
      if (formDataMap["question_custome[]"] == null) {
        formDataMap["question_custome[]"] = [cq["title"]];
      } else {
        (formDataMap["question_custome[]"] as List).add(cq["title"]);
      }
    }

    // 7. Event Date & Time (formatted as DD-MM-YYYY)
    final dateStr = dateTimeState.dateController.text.trim().replaceAll(
      '/',
      '-',
    );
    formDataMap["event_start_date"] = dateStr;
    formDataMap["event_end_date"] = dateStr;
    formDataMap["event_repeat_on"] = dateTimeState.repeatOption.toLowerCase();
    formDataMap["event_repeat_day"] = selectedDays.isNotEmpty
        ? selectedDays.first.toLowerCase()
        : "mon";

    // 8. Time slots
    for (int i = 0; i < dateTimeState.timeSlots.length; i++) {
      final slot = dateTimeState.timeSlots[i];
      formDataMap["time_slot[$i][start_time]"] = slot["start"]!.text.trim();
      formDataMap["time_slot[$i][end_time]"] = slot["end"]!.text.trim();
    }

    // 9. Event status & remainder
    formDataMap["event_status"] =
        optionalSettingsState.selectedStatus == "Draft" ? "draft" : "publish";
    formDataMap["event_remainder"] = optionalSettingsState
        .notificationController
        .text
        .trim();

    // 10. Cover Photo
    if (_coverImage != null) {
      formDataMap["cover_photo"] = await MultipartFile.fromFile(
        _coverImage!.path,
        filename: _coverImage!.name,
      );
    }

    final formData = FormData.fromMap(formDataMap);

    final success = await eventUpdateRxObj.updateEventRx(
      _eventData!.slug!,
      formData,
    );
    if (success && mounted) {
      // Invalidate dependencies so they auto-update
      eventDetailsRxObj.fetchEventDetails(_eventData!.slug!);
      eventListRxObj.fetchEventList();
      Navigator.pop(context);
    }
  }

  Widget _buildBottomButton() {
    String text = "Next ticketing";
    if (_currentIndex == 1) text = "Next attendee";
    if (_currentIndex >= 2) text = "Next";

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: ValueListenableBuilder<bool>(
        valueListenable: eventUpdateRxObj.isLoading,
        builder: (context, isLoading, child) {
          return ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    if (_currentIndex == 5) {
                      _submitCreateEvent();
                    } else {
                      _nextPage();
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.c2196F3,
              minimumSize: Size(double.infinity, 50.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    _currentIndex == 5 ? "Update Event" : text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
