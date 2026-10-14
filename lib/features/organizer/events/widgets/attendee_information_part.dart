import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/features/organizer/events/widgets/create_event_helper_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendeeInformationPart extends StatefulWidget {
  final List<dynamic>? initialPresetQuestions;

  const AttendeeInformationPart({
    super.key,
    this.initialPresetQuestions,
  });

  @override
  State<AttendeeInformationPart> createState() =>
      AttendeeInformationPartState();
}

class AttendeeInformationPartState extends State<AttendeeInformationPart> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<Map<String, dynamic>> questions = [
    {"title": "First Name", "selected": true},
    {"title": "Last Name", "selected": false},
    {"title": "Email", "selected": true},
    {"title": "Phone Number", "selected": true},
    {"title": "Gender", "selected": false},
    {"title": "Age", "selected": true},
    {"title": "Date of Birth", "selected": false},
  ];

  final List<Map<String, dynamic>> customQuestions = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialPresetQuestions != null && widget.initialPresetQuestions!.isNotEmpty) {
      final keys = widget.initialPresetQuestions!.map((q) => q.key?.toString().toLowerCase()).toSet();
      for (var q in questions) {
        final searchKey = q["title"].toString().toLowerCase().replaceAll(' ', '_');
        q["selected"] = keys.contains(searchKey);
      }
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
          SizedBox(height: 10.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLabel("Preset Questions"),
              Icon(Icons.info_outline, color: Colors.grey, size: 20),
            ],
          ),

          SizedBox(height: 12.h),

          ...List.generate(
            questions.length,
            (index) => _buildQuestionTile(index),
          ),

          SizedBox(height: 20.h),

          buildLabel("Custom Questions"),

          Container(
            width: double.infinity,
            padding: customQuestions.isEmpty
                ? EdgeInsets.symmetric(vertical: 30.h)
                : EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: customQuestions.isEmpty
                ? Column(
                    children: [
                      Icon(
                        Icons.assignment_outlined,
                        color: Colors.grey,
                        size: 40,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "No custom questions added yet",
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: buildOutlineButton(
                          "+ Add Question",
                          onTap: () => _showAddQuestionDialog(context),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      ...List.generate(
                        customQuestions.length,
                        (index) => _buildCustomQuestionTile(index),
                      ),
                      SizedBox(height: 12.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.w),
                        child: buildOutlineButton(
                          "+ Add Question",
                          onTap: () => _showAddQuestionDialog(context),
                        ),
                      ),
                    ],
                  ),
          ),

          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildQuestionTile(int index) {
    final question = questions[index];
    return GestureDetector(
      onTap: () {
        setState(() {
          question["selected"] = !question["selected"];
        });
      },

      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),

        child: Row(
          children: [
            Icon(
              question["selected"]
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: question["selected"] ? AppColor.c2196F3 : Colors.grey,
              size: 20,
            ),

            SizedBox(width: 12.w),

            Text(
              question["title"],
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomQuestionTile(int index) {
    final question = customQuestions[index];
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              question["title"],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                customQuestions.removeAt(index);
              });
            },
            child: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddQuestionDialog(BuildContext context) {
    final questionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF0F1B2A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabel("Question"),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.1),
                              ),
                            ),
                            child: TextField(
                              controller: questionController,
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: "e.g., Do you have any allergies?",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () {
                            dialogSetState(() {
                              questionController.clear();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // buildLabel("Answer"),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Container(
                    //         padding: EdgeInsets.symmetric(
                    //           horizontal: 16.w,
                    //           vertical: 12.h,
                    //         ),
                    //         decoration: BoxDecoration(
                    //           color: Colors.white.withValues(alpha: 0.05),
                    //           borderRadius: BorderRadius.circular(12.r),
                    //           border: Border.all(
                    //             color: Colors.white.withValues(alpha: 0.1),
                    //           ),
                    //         ),
                    //         child: TextField(
                    //           controller: answerController,
                    //           style: const TextStyle(color: Colors.white),
                    //           decoration: const InputDecoration(
                    //             hintText: "e.g., Enter your answer here",
                    //             hintStyle: TextStyle(color: Colors.grey),
                    //             border: InputBorder.none,
                    //             isDense: true,
                    //             contentPadding: EdgeInsets.zero,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(width: 8.w),
                    //     GestureDetector(
                    //       onTap: () {
                    //         dialogSetState(() {
                    //           answerController.clear();
                    //         });
                    //       },
                    //       child: Container(
                    //         padding: EdgeInsets.all(10.w),
                    //         decoration: BoxDecoration(
                    //           color: Colors.redAccent.withValues(alpha: 0.1),
                    //           shape: BoxShape.circle,
                    //         ),
                    //         child: const Icon(
                    //           Icons.delete_outline,
                    //           color: Colors.redAccent,
                    //           size: 20,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 24.h),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (questionController.text.trim().isNotEmpty) {
                            setState(() {
                              customQuestions.add({
                                "title": questionController.text.trim(),
                                // "answer": answerController.text.trim(),
                                // "selected": true,
                              });
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: AppColor.c2196F3),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Add Question",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
