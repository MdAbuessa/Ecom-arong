// import 'dart:io';

// import 'package:aarongonzales01/assets_helper/app_colors.dart';
// import 'package:aarongonzales01/common_widgets/custom_image_picker_widget.dart';
// import 'package:aarongonzales01/features/organizer/events/widgets/create_event_helper_widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';

// class BannerSectionPart extends StatelessWidget {
//   final XFile? profileImage;
//   final XFile? coverImage;
//   final Function(XFile) onProfilePicked;
//   final Function(XFile) onCoverPicked;
//   const BannerSectionPart({
//     super.key,
//     required this.profileImage,
//     required this.coverImage,
//     required this.onProfilePicked,
//     required this.onCoverPicked,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           buildStepper(2),
//           buildLabel("Profile Upload"),
//           Center(
//             child: Column(
//               children: [
//                 GestureDetector(
//                   onTap: () => showCustomImagePicker(
//                     context: context,
//                     onImagePicked: onProfilePicked,
//                   ),
//                   child: SizedBox(
//                     width: 120.w,
//                     height: 120.w,
//                     child: profileImage != null
//                         ? Container(
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               border: Border.all(
//                                 color: AppColor.c2196F3,
//                                 width: 2.w,
//                               ),
//                               image: DecorationImage(
//                                 image: FileImage(File(profileImage!.path)),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           )
//                         : CustomPaint(
//                             painter: DashCirclePainter(),
//                             child: Center(
//                               child: Icon(
//                                 Icons.cloud_upload_outlined,
//                                 color: AppColor.c2196F3,
//                                 size: 40.sp,
//                               ),
//                             ),
//                           ),
//                   ),
//                 ),
//                 SizedBox(height: 12.h),
//                 Text(
//                   profileImage != null
//                       ? "Tap to change profile"
//                       : "Tap to upload profile",
//                   style: TextStyle(color: Colors.grey, fontSize: 14.sp),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 30.h),
//           buildLabel("Cover Upload"),
//           GestureDetector(
//             onTap: () => showCustomImagePicker(
//               context: context,
//               onImagePicked: onCoverPicked,
//             ),
//             child: Container(
//               width: double.infinity,
//               height: 180.h,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12.r),
//               ),
//               child: coverImage != null
//                   ? Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12.r),
//                         border: Border.all(color: AppColor.c2196F3, width: 2.w),
//                         image: DecorationImage(
//                           image: FileImage(File(coverImage!.path)),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     )
//                   : CustomPaint(
//                       painter: DashRectPainter(),
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.image_outlined,
//                               color: Colors.grey,
//                               size: 40.sp,
//                             ),
//                             SizedBox(height: 12.h),
//                             Text(
//                               "Upload Cover Image",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 4.h),
//                             Text(
//                               "Recommended size: 1200x630px",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 12.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//             ),
//           ),

//           SizedBox(height: 100.h),
//         ],
//       ),
//     );
//   }
// }
