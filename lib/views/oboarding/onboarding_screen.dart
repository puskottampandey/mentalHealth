import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/views/oboarding/model.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../global/constants/colors_text.dart';

final currentPage = StateProvider((ref) => 0);

// ignore: must_be_immutable
class OnboardingScreen extends ConsumerWidget {
  OnboardingScreen({super.key});
  PageController controller = PageController(initialPage: 0);

  final List<Onboarding> _boardinglist = [
    Onboarding(
      image: "assets/images/imagePicture1.png",
      title: "Secure and Reliable",
      des:
          "Your well-being matters. MindMasters ensures secure interactions and protects your personal information, giving you peace of mind as you navigate your mental health journey.",
    ),
    Onboarding(
        image: "assets/images/imagePicture2.png",
        title: "Title: Confidential and Trustworthy",
        des:
            "Your privacy is our priority. MindMasters provides a safe space for your mental health needs, safeguarding your data and ensuring a trustworthy experience"),
    Onboarding(
        image: "assets/images/imagePicture1.png",
        title: "Support You Can Rely On",
        des:
            "Feel secure in your journey. MindMasters prioritizes your safety and confidentiality, offering reliable support for your mental well-being at every step.")
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final page = ref.watch(currentPage);
    return Scaffold(
      backgroundColor: AppColors.pureWhiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
          child: Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        // TokenService().savecomplete("completed", true);
                      },
                      icon: Icon(
                        Icons.fast_forward,
                        size: 24.sp,
                        color: AppColors.primaryColor,
                      )),
                ),
                Expanded(
                  child: PageView.builder(
                      controller: controller,
                      onPageChanged: (value) {
                        ref.read(currentPage.notifier).state = value;
                      },
                      itemCount: _boardinglist.length,
                      itemBuilder: (BuildContext context, int index) {
                        final proper = _boardinglist[index];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              proper.image.toString(),
                              height: 200.h,
                            ),
                            FadeInLeft(
                              from: 100,
                              duration: const Duration(seconds: 1),
                              child: ListTile(
                                title: Text(
                                  proper.title.toString(),
                                  style: textPoppions.headlineMedium?.copyWith(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            FadeInRight(
                              from: 150,
                              duration: const Duration(seconds: 1),
                              child: ListTile(
                                title: Text(
                                  proper.des.toString(),
                                  style: textPoppions.headlineSmall?.copyWith(
                                    color: AppColors.iconColor,
                                    fontSize: 14.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    page > 0
                        ? IconButton.outlined(
                            color: AppColors.primaryColor,
                            onPressed: () {
                              controller.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            icon: const Icon(
                              color: AppColors.blackColor,
                              Icons.arrow_back,
                            ))
                        : IconButton.outlined(
                            color: AppColors.iconColor,
                            onPressed: () {
                              controller.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            icon: const Icon(
                              color: AppColors.iconColor,
                              Icons.arrow_back,
                            )),
                    FadeInRight(
                      duration: const Duration(seconds: 1),
                      child: SmoothPageIndicator(
                          controller: controller,
                          count: _boardinglist.length,
                          effect: const ScrollingDotsEffect(
                            activeDotColor: AppColors.primaryColor,
                          )),
                    ),
                    IconButton.filled(
                        color: AppColors.blackColor,
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                        ),
                        onPressed: () {
                          if (page == 2) {
                            // TokenService().savecomplete("completed", true);
                            context.go('/multipleChoice');
                          } else {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.ease);
                          }
                        },
                        icon: Icon(
                          color: AppColors.whiteColor,
                          Icons.arrow_forward,
                          size: 16.sp,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
