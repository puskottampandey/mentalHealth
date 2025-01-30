import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/configs/therapist_details_model.dart';
import 'package:mentalhealth/controllers/theraplist_details.dart';
import 'package:mentalhealth/global/reuseable/button.dart';
import 'package:mentalhealth/views/doctor_book/confirm_sheet.dart';
import 'package:mentalhealth/views/home/home/therapist_data.dart';

import '../../global/constants/colors_text.dart';

final therapistId = StateProvider((ref) => '');

class DoctorDetails extends ConsumerWidget {
  DoctorDetails({super.key});

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
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(therapistDetailsControllerProvider);
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
      body: Builder(builder: (context) {
        switch (details.requestStatus) {
          case RequestStatus.initial:
            return Center(child: Container());
          case RequestStatus.progress:
            return Center(child: Container());
          case RequestStatus.success:
            return DoctorDetailsData(data: details.data);
          case RequestStatus.failure:
            return Center(
              child: Text(
                "Something went wrong",
                style: textPoppions.titleMedium?.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold),
              ),
            );
          case RequestStatus.fetchingMore:
            return Container();
        }
      }),
    );
  }
}

class DoctorDetailsData extends StatelessWidget {
  final TherapistDetails data;
  const DoctorDetailsData({
    super.key,
    required,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    specialDetails("150+", "Likes", Icons.monitor_heart),
                    specialDetails(data.yearsOfExperience.toString(),
                        "Experience", Icons.explore_rounded),
                    specialDetails("4", "Rate", Icons.rate_review),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
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
                    "${data.firstName} ${data.lastName}",
                    style: textPoppions.headlineMedium?.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    data.certification.toString(),
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
                    '${data.specialization}',
                    style: textPoppions.headlineMedium?.copyWith(
                      color: AppColors.iconColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    '${data.bio}',
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
          )
        ],
      ),
    );
  }

  Container specialDetails(String first, String second, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 91, 177, 247),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.whiteColor,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            first,
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
            second,
            style: textPoppions.headlineMedium?.copyWith(
              color: AppColors.whiteColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
