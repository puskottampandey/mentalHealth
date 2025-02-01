import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/configs/user_model.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';
import 'package:mentalhealth/global/reuseable/button.dart';
import 'package:mentalhealth/global/services/token_service.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(userDataControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Builder(builder: (context) {
        switch (details.requestStatus) {
          case RequestStatus.initial:
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ));
          case RequestStatus.progress:
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ));
          case RequestStatus.success:
            return UserDataDetails(data: details.data);
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

class UserDataDetails extends StatelessWidget {
  final UserData data;
  const UserDataDetails({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16.h,
        horizontal: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 32.h, horizontal: 32.w),
                    decoration: BoxDecoration(
                        color: AppColors.pureWhiteColor,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: const Icon(
                      Icons.person,
                    )),
                Text(
                  data.userName.toString(),
                  style: textPoppions.headlineMedium?.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  data.email.toString(),
                  style: textPoppions.headlineMedium?.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 60.h),
          ReuseableButton(
            bgcolor: AppColors.redColor,
            text: "Sign out",
            textcolor: kvverylightColor,
            ontap: () {
              showDialog<void>(
                context: context,
                // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: AppColors.whiteColor,
                    title: Text(
                      'Sign Out',
                      style: textPoppions.headlineMedium?.copyWith(
                        color: AppColors.blackColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            'Sign out ',
                            style: textPoppions.headlineMedium?.copyWith(
                              color: AppColors.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Would you like to  sign out?',
                            style: textPoppions.headlineMedium?.copyWith(
                              color: AppColors.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'Cancel',
                          style: textPoppions.headlineMedium?.copyWith(
                            color: AppColors.iconColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(
                          'Sign out',
                          style: textPoppions.headlineMedium?.copyWith(
                            color: AppColors.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () async {
                          await TokenService().removeToken();
                          // ignore: use_build_context_synchronously
                          context.go("/signIn");
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
