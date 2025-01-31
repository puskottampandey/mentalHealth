import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/post_controller.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/constants/colors_text.dart';
import 'package:mentalhealth/global/reuseable/button.dart';
import 'package:mentalhealth/global/reuseable/formfield.dart';
import 'package:mentalhealth/global/reuseable/snackbar.dart';
import 'package:mentalhealth/views/home/personal/common_enum.dart';

import '../../../controllers/signup_controller.dart';

class CreatePost extends ConsumerStatefulWidget {
  const CreatePost({super.key});

  @override
  ConsumerState<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends ConsumerState<CreatePost> {
  MoodTag? firstMood;
  MoodTag? secondMood;
  final title = TextEditingController();
  final desc = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<MoodTag> positiveMoods = [
    MoodTag.happy,
    MoodTag.motivated,
    MoodTag.relaxed
  ];

  List<MoodTag> negativeMoods = [
    MoodTag.sad,
    MoodTag.anxious,
    MoodTag.angry,
    MoodTag.lonely
  ];
  List<MoodTag> extraMoods1 = [
    MoodTag.thoughtful,
    MoodTag.curious,
  ];
  List<MoodTag> extraMoods2 = [
    MoodTag.content,
    MoodTag.unspecified,
  ];
  List<MoodTag> availableSecondDropdownMoods = [];

  String? selectedValue;

  void secondDropDown() {
    if (firstMood != null) {
      if (positiveMoods.contains(firstMood)) {
        setState(() {
          availableSecondDropdownMoods = [
            ...negativeMoods,
            ...extraMoods1,
          ];
        });
      } else {
        setState(() {
          availableSecondDropdownMoods = [
            ...positiveMoods,
            ...extraMoods2,
          ];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final id = ref.watch(userId);

    ref.listen<StateModel>(postControllerProvider, (previous, next) async {
      if (next.requestStatus == RequestStatus.failure) {
        SnackBars.errorsnackbar(context, "Something went wrong");
      }
      if (next.requestStatus == RequestStatus.success) {
        SnackBars.successSnackbar(context, "Post successful!");
        context.pop();
      }
    });
    return Consumer(builder: (context, ref, child) {
      final isloading = ref.watch(isloadingProvider);
      return Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Create Your Post ",
              style: textPoppions.titleMedium?.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold),
            ),
            ReusableFormField(
              obscureText: false,
              controller: title,
              hint: "title",
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Enter a title";
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            DropdownButtonFormField2<MoodTag>(
              isExpanded: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              hint: const Text(
                'Select Your Primary Mood',
                style: TextStyle(fontSize: 14),
              ),
              items: MoodTag.values.map((MoodTag mood) {
                return DropdownMenuItem<MoodTag>(
                  value: mood,
                  child: Text(mood.toString().split('.').last),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select mood.';
                }
                return null;
              },
              onChanged: (value) {
                firstMood = value;
                secondMood = null;
                secondDropDown();
              },
              onSaved: (value) {},
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 8),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                elevation: 6,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            SizedBox(height: 20.h),
            DropdownButtonFormField2<MoodTag>(
              isExpanded: true,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              hint: const Text(
                'Select Your Secondary Mood',
                style: TextStyle(fontSize: 14),
              ),
              items: availableSecondDropdownMoods.map((MoodTag mood) {
                return DropdownMenuItem<MoodTag>(
                  value: mood,
                  child: Text(mood.toString().split('.').last),
                );
              }).toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select mood.';
                }
                return null;
              },
              onChanged: (value) {
                secondMood = value;
              },
              onSaved: (value) {},
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.only(right: 8),
              ),
              iconStyleData: const IconStyleData(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 24,
              ),
              dropdownStyleData: DropdownStyleData(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                elevation: 6,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            SizedBox(height: 20.h),
            TextField(
              controller: desc,
              maxLines: 5,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                hintText: "Content",
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
              height: 10.h,
            ),
            ReuseableButton(
              isloading: isloading,
              bgcolor: AppColors.primaryColor,
              textcolor: AppColors.pureWhiteColor,
              text: "Confirm Post",
              ontap: () {
                if (formKey.currentState!.validate()) {
                  ref.read(postControllerProvider.notifier).post(
                      id: id,
                      title: title.text.trim(),
                      content: desc.text.trim(),
                      primaryMood: firstMood!.value,
                      secondaryMood: secondMood!.value);
                }
              },
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ),
      );
    });
  }
}
