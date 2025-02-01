import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/mood_controller.dart';
import 'package:mentalhealth/controllers/post_mood.dart';
import 'package:mentalhealth/controllers/theraplist.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';
import 'package:mentalhealth/global/services/token_service.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      final iscomplete = await TokenService().getOncomplete();

      if (iscomplete == null || iscomplete.isEmpty) {
        // ignore: use_build_context_synchronously
        context.go("/onboard");
      } else {
        final iscomplete = await TokenService().getToken();
        if (iscomplete == null || iscomplete.isEmpty) {
          // ignore: use_build_context_synchronously
          context.go("/signIn");
        } else {
          await ref.read(userDataControllerProvider.notifier).userData();

          // ignore: use_build_context_synchronously
          context.go("/myApp");
        }
        // ignore: use_build_context_synchronously
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final details = ref.watch(userDataControllerProvider);
    return Container(
        color: AppColors.primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Mind Matters",
                style: textPoppions.headlineSmall?.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 20.sp,
                ),
              ),
              Builder(builder: (context) {
                switch (details.requestStatus) {
                  case RequestStatus.initial:
                    return const Center(
                        child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ));
                  case RequestStatus.progress:
                    return const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryColor));
                  case RequestStatus.success:
                    return const CircularProgressIndicator(
                        color: AppColors.primaryColor);
                  case RequestStatus.failure:
                    return Center(child: Container());
                  case RequestStatus.fetchingMore:
                    return Container();
                }
              }),
            ],
          ),
        ));
  }
}
