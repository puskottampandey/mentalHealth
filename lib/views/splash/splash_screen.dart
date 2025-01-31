import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
          ref.read(userDataControllerProvider.notifier).userData();
          // ignore: use_build_context_synchronously
          context.go("/moodPost");
        }
        // ignore: use_build_context_synchronously
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Center(
          child: Image.asset(
        "assets/images/splash.png",
        height: 80.h,
      )),
    );
  }
}
