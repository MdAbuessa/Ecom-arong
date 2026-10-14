import 'package:aarongonzales01/assets_helper/app_colors.dart';
import 'package:aarongonzales01/assets_helper/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ParticipantsTable extends StatelessWidget {
  final List<Map<String, dynamic>> participants;

  const ParticipantsTable({super.key, required this.participants});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1B263B),
        borderRadius: BorderRadius.circular(12.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Blue Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            color: AppColor.c2196F3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Participants (360)",
                  style: TextFontStyle.textStyle16InterW600,
                ),
                Icon(Icons.download_outlined, color: Colors.white),
              ],
            ),
          ),
          // Table Body
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- FIXED COLUMNS (Bib) ---
                  Column(
                    children: [
                      // Header
                      Row(
                        children: [
                          _cell(text: "Bib", width: 60, isHeader: true),
                        ],
                      ),
                      // Rows
                      ...participants.map(
                        (p) =>
                            Row(children: [_cell(text: p["bib"], width: 60)]),
                      ),
                    ],
                  ),
                  // --- SCROLLABLE COLUMNS (Name, Email, Event, Status, etc.) ---
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          // Header
                          Row(
                            children: [
                              _cell(text: "Name", width: 180, isHeader: true),
                              _cell(text: "Email", width: 200, isHeader: true),
                              _cell(text: "Event", width: 160, isHeader: true),
                              _cell(text: "Status", width: 120, isHeader: true),
                              _cell(
                                text: "Distance",
                                width: 100,
                                isHeader: true,
                              ),
                              _cell(text: "Time", width: 100, isHeader: true),
                              _cell(text: "Action", width: 70, isHeader: true),
                            ],
                          ),
                          // Rows
                          ...participants.map(
                            (p) => Row(
                              children: [
                                _nameCell(p),
                                _cell(text: p["email"], width: 200),
                                _cell(text: p["event"], width: 160),
                                _statusCell(p["status"], 120),
                                _cell(text: p["distance"], width: 100),
                                _cell(text: p["time"], width: 100),
                                _cell(
                                  text: "",
                                  width: 70,
                                  child: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Unified Cell Builder
  Widget _cell({
    required String text,
    required double width,
    bool isHeader = false,
    Widget? child,
  }) {
    return Container(
      width: width.w,
      height: isHeader ? 50.h : 70.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: isHeader ? const Color(0xFF233549) : Colors.transparent,
        border: !isHeader
            ? Border(
                bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
              )
            : null,
      ),
      child:
          child ??
          Text(
            text,
            style: isHeader
                ? TextFontStyle.textStyle14InterW500.copyWith(
                    color: Colors.white60,
                  )
                : TextFontStyle.textStyle14InterW400.copyWith(
                    color: Colors.white,
                  ),
            maxLines: isHeader ? 1 : 2,
            overflow: TextOverflow.ellipsis,
          ),
    );
  }

  // Name Cell with Avatar
  Widget _nameCell(Map<String, dynamic> p) {
    return _cell(
      text: "",
      width: 180,
      child: Row(
        children: [
          CircleAvatar(radius: 18.r, backgroundImage: NetworkImage(p["image"])),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              p["name"],
              style: TextFontStyle.textStyle14InterW400.copyWith(
                color: Colors.white,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Status Chip Cell
  Widget _statusCell(String status, double width) {
    Color color = Colors.grey;
    Color bgColor = Colors.grey.withValues(alpha: 0.1);

    if (status == "Completed") {
      color = const Color(0xFF34D399);
      bgColor = const Color(0xFF064E3B);
    } else if (status == "Running") {
      color = const Color(0xFF60A5FA);
      bgColor = const Color(0xFF1E3A8A);
    }

    return _cell(
      text: "",
      width: width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          status,
          style: TextFontStyle.textStyle12UrbanistW600.copyWith(color: color),
        ),
      ),
    );
  }
}
