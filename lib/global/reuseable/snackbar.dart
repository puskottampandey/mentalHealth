import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';

class SnackBars {
  static void errorsnackbar(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.redColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
          12.r,
        )),
        duration: const Duration(
          seconds: 1,
        ),
        content: Center(
          child: Text(
            message!,
            textAlign: TextAlign.center,
            style: textPoppions.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }

  static void successSnackbar(BuildContext context, String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        duration: const Duration(
          seconds: 1,
        ),
        content: Center(
          child: Text(
            message!,
            textAlign: TextAlign.center,
            style: textPoppions.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
