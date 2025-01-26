import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../constants/colors_text.dart';

class ReuseableScaffold extends StatelessWidget {
  final String? text;
  final bool appbar;
  final Widget? child;
  final bool center;
  final bool? back;
  final bool? changeColor;
  final Color? color;
  final Color? leadingcolor;
  final bool? bottomnavigation;
  final Widget? bottomnavigationWidget;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const ReuseableScaffold({
    this.text,
    this.appbar = false,
    this.back = true,
    this.changeColor = false,
    this.color,
    this.child,
    this.bottomnavigation = false,
    this.bottomnavigationWidget,
    this.floatingActionButton,
    super.key,
    this.actions,
    this.center = true,
    this.leadingcolor = AppColors.blackColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          bottomnavigation! ? FloatingActionButtonLocation.centerDocked : null,
      floatingActionButton: bottomnavigation! ? floatingActionButton : null,
      backgroundColor: changeColor! ? color : AppColors.whiteColor,
      bottomNavigationBar: bottomnavigation! ? bottomnavigationWidget : null,
      appBar: appbar
          ? AppBar(
              automaticallyImplyLeading: false,
              leading: back!
                  ? IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: Icon(
                        color: leadingcolor,
                        Icons.arrow_back_ios_new,
                      ),
                    )
                  : null,
              iconTheme: IconThemeData(
                  color: changeColor! ? kvverylightColor : kPrimaryDarkColor),
              centerTitle: center ? true : false,
              backgroundColor: changeColor! ? color : kvverylightColor,
              actions: actions,
              title: Text(
                text!,
                style: textPoppions.bodyLarge!.copyWith(
                  fontSize: 16.sp,
                  color: changeColor! ? kvverylightColor : klightDarkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
      body: child,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mindmaster/global/constants/colors_text.dart';

// class ReuseableScaffold extends StatelessWidget {
//   final String? text;
//   final bool appbar;
//   final Widget? child;

//   final bool? changeColor;
//   final Color? color;
//   final bool? bottomnavigation;
//   final Widget? bottomnavigationWidget;
//   final Widget? floatingActionButton;

//   const ReuseableScaffold({
//     this.text,
//     this.appbar = false,
//     this.changeColor = false,
//     this.color,
//     this.child,
//     this.bottomnavigation = false,
//     this.bottomnavigationWidget,
//     this.floatingActionButton,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // floatingActionButtonLocation:
//       //     bottomnavigation! ? FloatingActionButtonLocation.centerDocked : null,
//       // floatingActionButton: bottomnavigation! ? floatingActionButton : null,
//       // backgroundColor: changeColor! ? color : AppColors.whiteColor,
//       // bottomNavigationBar: bottomnavigation! ? bottomnavigationWidget : null,
//       appBar: appbar
//           ? AppBar(
//               iconTheme: IconThemeData(
//                   color: changeColor! ? kvverylightColor : kPrimaryDarkColor),
//               backgroundColor: changeColor! ? color : AppColors.whiteColor,
//               title: Text(
//                 text!,
//                 style: textPoppions.bodyLarge!.copyWith(
//                   fontSize: 16.sp,
//                   color: changeColor! ? kvverylightColor : klightDarkColor,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             )
//           : null,
//       body: child,
//     );
//   }
// }
