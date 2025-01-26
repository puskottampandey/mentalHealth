import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../global/constants/colors_text.dart';
import '../../global/reuseable/button.dart';


class ConfirmSheet {
  static customBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: AppColors.pureWhiteColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Thank you",
                  style: textPoppions.headlineMedium?.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Your Appointment Created",
                  style: textPoppions.headlineMedium?.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "You booked a appointment with Dr.Puskottam Pandey",
                  style: textPoppions.headlineMedium?.copyWith(
                    color: AppColors.iconColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ReuseableButton(
                  bgcolor: AppColors.primaryColor,
                  textcolor: AppColors.pureWhiteColor,
                  text: "Payment ",
                  ontap: () {
                    context.push("/payment");
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
