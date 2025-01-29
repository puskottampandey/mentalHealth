import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';

// ignore: must_be_immutable
class ReuseableButton extends StatelessWidget {
  final VoidCallback? ontap;
  final Color? bgcolor;
  final String? text;
  final Color? textcolor;
  final Size? minimumsize;
  final Widget? child;
  final bool isloading;
  ReuseableButton({
    super.key,
    this.ontap,
    this.bgcolor,
    this.isloading = false,
    Size? minimumSize,
    this.child,
    this.text,
    this.textcolor,
  }) : minimumsize = minimumSize ?? Size(double.infinity, 40.h);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          minimumSize: minimumsize,
          backgroundColor: bgcolor,
        ),
        onPressed: ontap,
        child: isloading
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.whiteColor,
                ),
              )
            : Text(
                text!,
                style: textPoppions.bodyLarge!.copyWith(
                  fontSize: 14.sp,
                  color: textcolor,
                  fontWeight: FontWeight.w600,
                ),
              ));
  }
}
