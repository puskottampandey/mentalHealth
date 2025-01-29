import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentalhealth/configs/therapist_details_model.dart';
import 'package:mentalhealth/configs/therapist_list_model.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';

import '../../../controllers/theraplist.dart';

class TherapistData extends ConsumerWidget {
  final List<TherapistDetailsList> data;
  const TherapistData({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 170.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          final item = data[index];
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  ref
                      .read(therapistListControllerProvider.notifier)
                      .therapistList(item.id, true);
                  // context.push('/doctorDetails');
                },
                child: Container(
                  width: 160.w,
                  margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhiteColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Image.asset(
                            "assets/images/docotors.png",
                            height: 80.h,
                            width: 100.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 8.w),
                          child: Column(
                            children: [
                              Text(
                                "${item.firstName}${item.lastName}",
                                style: textPoppions.headlineMedium?.copyWith(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                item.specialization.toString(),
                                maxLines: 2,
                                style: textPoppions.headlineMedium?.copyWith(
                                    color: AppColors.iconColor,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
