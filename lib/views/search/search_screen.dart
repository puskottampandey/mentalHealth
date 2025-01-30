import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../global/constants/colors_text.dart';
import '../../global/reuseable/formfield.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        titleSpacing: 0,
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
              color: AppColors.pureWhiteColor,
              borderRadius: BorderRadius.circular(8.r)),
          child: TextField(
            controller: TextEditingController(),
            decoration: InputDecoration(
              hintText: 'Search......',
              hintStyle: textPoppions.headlineMedium?.copyWith(
                color: AppColors.iconColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
