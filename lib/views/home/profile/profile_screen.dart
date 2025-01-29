import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/configs/user_model.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(userDataControllerProvider);
    return Builder(builder: (context) {
      switch (details.requestStatus) {
        case RequestStatus.initial:
          return const Center(child: CircularProgressIndicator());
        case RequestStatus.progress:
          return const Center(child: CircularProgressIndicator());
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
    });
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data.userName.toString(),
          ),
          Text(
            data.email.toString(),
          ),
        ],
      ),
    );
  }
}
