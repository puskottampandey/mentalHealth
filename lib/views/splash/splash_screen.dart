import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      // ignore: use_build_context_synchronously
      context.go("/onboard");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: Center(
        child: Text(
          "Mind Master",
          style: textPoppions.displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
            color: AppColors.pureWhiteColor,
          ),
        ),
      ),
    );
  }
}
