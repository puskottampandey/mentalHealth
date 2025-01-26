import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/global/reuseable/button.dart';
import 'package:mentalhealth/views/doctor_book/confirm_sheet.dart';

import '../../global/constants/colors_text.dart';


class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  List<Map<String, dynamic>> list = [
    {
      "icon": Icons.monitor_heart,
      "points": "150+",
      "field": "Likes",
    },
    {
      "icon": Icons.explore_rounded,
      "points": "10 years",
      "field": "Experience",
    },
    {
      "icon": Icons.rate_review,
      "points": "4",
      "field": "Rate",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10.h),
        color: AppColors.pureWhiteColor,
        height: 60.h,
        child: ReuseableButton(
          ontap: () {
            ConfirmSheet.customBottomSheet(context);
          },
          text: "Get Appointment",
          textcolor: AppColors.pureWhiteColor,
          bgcolor: AppColors.primaryColor,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            color: AppColors.pureWhiteColor,
            Icons.arrow_back_ios_new,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Doctor Details",
          style: textPoppions.headlineMedium?.copyWith(
            color: AppColors.whiteColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.pureWhiteColor,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Image.asset(
                    "assets/images/docotors.png",
                    height: 120.h,
                    width: 120.w,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 120.h,
                  child: Center(
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        itemBuilder: (context, int index) {
                          final iteam = list[index];
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 14.h),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r)),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 91, 177, 247),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    iteam["icon"],
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 6.h,
                                ),
                                Text(
                                  iteam["points"],
                                  style: textPoppions.headlineMedium?.copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  iteam["field"],
                                  style: textPoppions.headlineMedium?.copyWith(
                                    color: AppColors.whiteColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: AppColors.pureWhiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(64.r),
                    topRight: Radius.circular(64.r))),
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  Text(
                    "Dr. Puskottam Pandey",
                    style: textPoppions.headlineMedium?.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Psychiatrist-National Medical College",
                    style: textPoppions.headlineMedium?.copyWith(
                      color: AppColors.iconColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16.sp,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "About Doctor ",
                      style: textPoppions.headlineMedium?.copyWith(
                        color: AppColors.blackColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'Dr. [Name] is a highly qualified and experienced [specialization] dedicated to providing compassionate and personalized care. With [X years] of expertise,they are committed to improving your health and well-being through the latest treatments and a patient-first approach.',
                    style: textPoppions.headlineMedium?.copyWith(
                      color: AppColors.iconColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              )),
            ),
          ))
        ],
      ),
    );
  }
}
