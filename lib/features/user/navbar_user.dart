// import 'package:aarongonzales01/assets_helper/app_colors.dart';
// import 'package:aarongonzales01/features/user/home/presentation/user_home_screen.dart';
// import 'package:aarongonzales01/features/user/routes/presentation/routes_screen.dart';
// import 'package:aarongonzales01/features/user/setting/routes/presentation/setting_screen.dart';
// import 'package:aarongonzales01/features/user/social/routes/presentation/social_screen.dart';
// import 'package:aarongonzales01/helpers/helper_methods.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class NavbarUser extends StatefulWidget {
//   final int? pageNum;
//   const NavbarUser({super.key, this.pageNum});

//   @override
//   State<NavbarUser> createState() => _NavbarUserState();
// }

// class _NavbarUserState extends State<NavbarUser> {
//   int _selectedIndex = 0;
//   @override
//   void initState() {
//     super.initState();
//     if (widget.pageNum != null) {
//       _selectedIndex = widget.pageNum!;
//     }
//   }

//   final List<Widget> _screens = [
//     UserHomeScreen(),
//     RoutesScreen(),
//     SocialScreen(),
//     SettingScreen(),
//   ];

//   final List<Map<String, String>> _navItems = [
//     {'label': 'Home', 'icon': 'assets/icons/home.svg'},
//     {'label': 'Services', 'icon': 'assets/icons/service.svg'},
//     {'label': 'Chat', 'icon': 'assets/icons/chat.svg'},
//     {'label': 'Profile', 'icon': 'assets/icons/profile.svg'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (bool didPop) async {
//         if (didPop) return;
//         showMaterialDialog(context);
//       },
//       child: Scaffold(
//         backgroundColor: AppColor.bgColor,
//         body: SafeArea(
//           child: Stack(
//             children: [
//               IndexedStack(index: _selectedIndex, children: _screens),
//               Positioned(
//                 left: 20.w,
//                 right: 20.w,
//                 bottom: 20.h,
//                 child: Container(
//                   height: 70.h,
//                   padding: EdgeInsets.symmetric(horizontal: 10.w),
//                   decoration: BoxDecoration(
//                     color: const Color(0xffB1E3F1),
//                     borderRadius: BorderRadius.circular(100.r),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(_navItems.length, (index) {
//                       bool isSelected = _selectedIndex == index;
//                       return Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               setState(() {
//                                 _selectedIndex = index;
//                               });
//                             },
//                             child: AnimatedSize(
//                               duration: const Duration(milliseconds: 300),
//                               curve: Curves.easeInOut,
//                               child: AnimatedContainer(
//                                 duration: const Duration(milliseconds: 300),
//                                 curve: Curves.easeInOut,
//                                 height: 48.h,
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: isSelected ? 16.w : 0,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: isSelected
//                                       ? const Color(0xff000066)
//                                       : Colors.white,
//                                   borderRadius: BorderRadius.circular(30.r),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     SizedBox(
//                                       width: 48
//                                           .h, // Fixed width to ensure circle when unselected
//                                       height: 48.h,
//                                       child: Center(
//                                         child: SvgPicture.asset(
//                                           _navItems[index]['icon']!,
//                                           colorFilter: ColorFilter.mode(
//                                             isSelected
//                                                 ? Colors.white
//                                                 : const Color(0xff000066),
//                                             BlendMode.srcIn,
//                                           ),
//                                           width: 24.w,
//                                           height: 24.h,
//                                         ),
//                                       ),
//                                     ),
//                                     if (isSelected) ...[
//                                       SizedBox(width: 4.w),
//                                       Text(
//                                         _navItems[index]['label']!,
//                                         maxLines: 1,
//                                         overflow: TextOverflow.visible,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 14.sp,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 8.w,
//                                       ), // Extra padding for text end
//                                     ],
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           if (index < _navItems.length - 1)
//                             SizedBox(width: 12.w), // Fixed 12px gap
//                         ],
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
