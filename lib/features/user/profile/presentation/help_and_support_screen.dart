// ignore_for_file: deprecated_member_use

import 'package:aarongonzales01/common_widgets/custom_back_button.dart';
import 'package:aarongonzales01/features/user/profile/model/help_and_support_model.dart';
import 'package:aarongonzales01/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpAndSupportScreen extends StatefulWidget {
  const HelpAndSupportScreen({super.key});

  @override
  State<HelpAndSupportScreen> createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  @override
  void initState() {
    super.initState();
    helpAndSupportRxObj.fetchHelpAndSupport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061115),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ────────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomBackButton(),
                  Text(
                    "Help & Support",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 44.w),
                ],
              ),
            ),

            // ── Body ─────────────────────────────────────────────────────────
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: helpAndSupportRxObj.isLoading,
                builder: (context, loading, _) {
                  if (loading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF266FEF),
                      ),
                    );
                  }
                  return StreamBuilder<HelpAndSupportModel>(
                    stream: helpAndSupportRxObj.helpAndSupportData,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return _ErrorView(
                          onRetry: () =>
                              helpAndSupportRxObj.fetchHelpAndSupport(),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF266FEF),
                          ),
                        );
                      }
                      final data = snapshot.data!.data;
                      return _ContentView(
                        title: data?.title ?? "Help & Support",
                        content: data?.content ?? "",
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: const Color(0xFF091115),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.05),
                width: 1.w,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Content
                if (content.trim().isEmpty)
                  _NoDataView()
                else
                  Html(
                    data: content,
                    style: {
                      "*": Style(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: FontSize(14.sp),
                        fontFamily: GoogleFonts.inter().fontFamily,
                        lineHeight: const LineHeight(1.7),
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                      "body": Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                      "p": Style(margin: Margins.only(bottom: 8)),
                      "h1": Style(
                        color: Colors.white,
                        fontSize: FontSize(18.sp),
                        fontWeight: FontWeight.w700,
                        margin: Margins.only(bottom: 8, top: 8),
                      ),
                      "h2": Style(
                        color: Colors.white,
                        fontSize: FontSize(16.sp),
                        fontWeight: FontWeight.w600,
                        margin: Margins.only(bottom: 6, top: 8),
                      ),
                      "h3": Style(
                        color: Colors.white,
                        fontSize: FontSize(15.sp),
                        fontWeight: FontWeight.w600,
                        margin: Margins.only(bottom: 4, top: 6),
                      ),
                      "li": Style(margin: Margins.only(bottom: 4)),
                      "strong": Style(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      "a": Style(
                        color: const Color(0xFF266FEF),
                        textDecoration: TextDecoration.underline,
                      ),
                    },
                  ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Contact card
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF266FEF).withOpacity(0.12),
                  const Color(0xFF091115),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFF266FEF).withOpacity(0.2),
                width: 1.w,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.mail_outline_rounded,
                  color: const Color(0xFF266FEF),
                  size: 22.sp,
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Still need help?",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Contact us at support@racerealm.com",
                        style: GoogleFonts.inter(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            color: Colors.white.withOpacity(0.3),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            "Something went wrong",
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.6),
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
          TextButton(
            onPressed: onRetry,
            child: Text(
              "Retry",
              style: GoogleFonts.inter(
                color: const Color(0xFF266FEF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inbox_outlined,

              color: Colors.white.withOpacity(0.25),
              size: 48.sp,
            ),
            SizedBox(height: 12.h),
            Text(
              "No data available",
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.45),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
