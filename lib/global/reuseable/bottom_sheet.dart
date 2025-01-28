import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';
import 'package:mentalhealth/global/reuseable/button.dart';

class CustomBottomSheet {
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
                SizedBox(
                  height: 20.h,
                ),
                ReuseableButton(
                  bgcolor: AppColors.primaryColor,
                  textcolor: AppColors.pureWhiteColor,
                  text: "Confirm ",
                  ontap: () {},
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
