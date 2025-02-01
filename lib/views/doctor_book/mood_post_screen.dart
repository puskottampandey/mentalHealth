import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/post_mood.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';
import 'package:mentalhealth/global/reuseable/button.dart';
import 'package:mentalhealth/global/reuseable/custom_dropdown.dart';
import 'package:mentalhealth/global/reuseable/scaffold.dart';
import 'package:mentalhealth/global/reuseable/snackbar.dart';
import 'package:mentalhealth/views/home/personal/common_enum.dart';

import '../../controllers/signup_controller.dart';

class MoodPost extends ConsumerStatefulWidget {
  const MoodPost({super.key});

  @override
  ConsumerState<MoodPost> createState() => _MoodPostState();
}

class _MoodPostState extends ConsumerState<MoodPost> {
  final formKeyPost = GlobalKey<FormState>();
  final notes = TextEditingController();
  MoodState? mood;
  int? moodInten;
  int? sleep;
  int? time;
  Weather? weather;
  int? stress;
  String? socialInte;
  List<int> moodIntensity = List.generate(10, (index) => index + 1);
  List<int> sleephour = List.generate(24, (index) => index + 1);
  List<int> timeIntervals = List.generate(20, (index) => (index + 1) * 15);
  List<String> social = ["true", "false"];

  @override
  Widget build(BuildContext context) {
    final id = ref.watch(userId);
    ref.listen<StateModel>(moodControllerProvider, (previous, next) async {
      if (next.requestStatus == RequestStatus.failure) {
        SnackBars.errorsnackbar(context, "Something went wrong");
      }
      if (next.requestStatus == RequestStatus.success) {
        SnackBars.successSnackbar(context, "Mood post successful!");

        context.go("/multipleChoice");
      }
    });
    return Consumer(builder: (context, ref, child) {
      final isloading = ref.watch(isloadingProvider);
      return ReuseableScaffold(
        appbar: true,
        text: "Your Mood",
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enter your mood",
                  style: textPoppions.headlineMedium?.copyWith(
                    color: AppColors.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Form(
                  key: formKeyPost,
                  child: Column(
                    children: [
                      CustomDropdown<MoodState>(
                        hint: "Select Mood",
                        items: MoodState.values,
                        value: mood,
                        onChanged: (value) {
                          mood = value;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomDropdown<int>(
                        hint: "Select Mood Intensity",
                        items: moodIntensity,
                        value: moodInten,
                        onChanged: (value) {
                          moodInten = value;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomDropdown<int>(
                        hint: "Select Sleep hour",
                        items: sleephour,
                        value: moodInten,
                        onChanged: (value) {
                          sleep = value;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomDropdown<Weather>(
                        hint: "Select  Weather",
                        items: Weather.values,
                        value: weather,
                        onChanged: (value) {
                          weather = value;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomDropdown<int>(
                        hint: "Select Stress level",
                        items: moodIntensity,
                        value: stress,
                        onChanged: (value) {
                          stress = value;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomDropdown<int>(
                        hint: "Select Exercise Min",
                        items: timeIntervals,
                        value: time,
                        onChanged: (value) {
                          time = value;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomDropdown<String>(
                        hint: "Select Social Interaction",
                        items: social,
                        value: socialInte,
                        onChanged: (value) {
                          socialInte = value;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextField(
                        controller: notes,
                        maxLines: 3,
                        cursorColor: AppColors.primaryColor,
                        decoration: InputDecoration(
                          hintText: "Notes",
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            width: 1.5,
                            color: AppColors.primaryColor,
                          )),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.greyColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      ReuseableButton(
                        isloading: isloading,
                        bgcolor: AppColors.primaryColor,
                        textcolor: AppColors.pureWhiteColor,
                        text: "Confirm Post",
                        ontap: () {
                          if (formKeyPost.currentState!.validate()) {
                            bool booleanValue =
                                socialInte!.toLowerCase() == "true";
                            ref.watch(moodControllerProvider.notifier).postMood(
                                  id: id,
                                  mood: mood!.value,
                                  notes: notes.text.trim(),
                                  moodIntensity: moodInten,
                                  sleepHours: sleep,
                                  exercise: time,
                                  weather: weather!.value,
                                  stresslevel: stress,
                                  socialInteraction: booleanValue,
                                );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
