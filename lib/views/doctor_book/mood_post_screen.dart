import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';
import 'package:mentalhealth/global/reuseable/button.dart';
import 'package:mentalhealth/global/reuseable/custom_dropdown.dart';
import 'package:mentalhealth/global/reuseable/scaffold.dart';
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
    return Consumer(builder: (context, ref, child) {
      final isloading = ref.watch(isloadingProvider);
      return ReuseableScaffold(
        appbar: true,
        text: "Your Mood",
        child: Form(
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
              CustomDropdown<int>(
                hint: "Select Mood Intensity",
                items: moodIntensity,
                value: moodInten,
                onChanged: (value) {
                  moodInten = value;
                },
              ),
              CustomDropdown<int>(
                hint: "Select Sleep hour",
                items: sleephour,
                value: moodInten,
                onChanged: (value) {
                  sleep = value;
                },
              ),
              CustomDropdown<Weather>(
                hint: "Select  Weather",
                items: Weather.values,
                value: weather,
                onChanged: (value) {
                  weather = value;
                },
              ),
              CustomDropdown<int>(
                hint: "Select Stress level",
                items: moodIntensity,
                value: stress,
                onChanged: (value) {
                  stress = value;
                },
              ),
              CustomDropdown<int>(
                hint: "Select Exercise Min",
                items: timeIntervals,
                value: time,
                onChanged: (value) {
                  time = value;
                },
              ),
              CustomDropdown<String>(
                hint: "Select Social Interaction",
                items: social,
                value: socialInte,
                onChanged: (value) {
                  socialInte = value;
                },
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
              ReuseableButton(
                isloading: isloading,
                bgcolor: AppColors.primaryColor,
                textcolor: AppColors.pureWhiteColor,
                text: "Confirm Post",
                ontap: () {
                  if (formKeyPost.currentState!.validate()) {}
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
