import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/send_email_confirmation.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/global/reuseable/snackbar.dart';

import '../../../global/constants/colors_text.dart';
import '../../../global/reuseable/button.dart';
import '../../../global/reuseable/formfield.dart';
import '../../../global/reuseable/scaffold.dart';

final nametext = AutoDisposeProvider((ref) => TextEditingController());
final emailtext = AutoDisposeProvider((ref) => TextEditingController());
final passwordtext = AutoDisposeProvider((ref) => TextEditingController());
final datebirthtext = AutoDisposeProvider((ref) => TextEditingController());
final gendertext = AutoDisposeProvider((ref) => TextEditingController());
final username = AutoDisposeProvider((ref) => TextEditingController());
final genderCheck = StateProvider((ref) => false);
final selectedGender = StateProvider((ref) => -1);
final userEmail = StateProvider((ref) => '');

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({super.key});
  final GlobalKey<FormState> _signUp = GlobalKey<FormState>();
  final List<Map<String, dynamic>> genderOptions = [
    {'label': 'Male', 'value': 0},
    {'label': 'Female', 'value': 1},
    {'label': 'Other', 'value': 2},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = ref.watch(nametext);
    final emailController = ref.watch(emailtext);
    final passwordController = ref.watch(passwordtext);
    final birthdateController = ref.watch(datebirthtext);
    final genderController = ref.watch(gendertext);
    final userName = ref.watch(username);
    final genderValue = ref.watch(selectedGender);
    final check = ref.watch(genderCheck);

    ref.listen<StateModel>(signUpControllerProvider, (previous, next) async {
      if (next.requestStatus == RequestStatus.failure) {
        SnackBars.errorsnackbar(context, "Something went wrong");
      }
      if (next.requestStatus == RequestStatus.success) {
        SnackBars.successSnackbar(context, "Register successful!");

        ref
            .read(sendEmailControllerProvider.notifier)
            .sendEmail(emailController.text);
        ref.read(userEmail.notifier).state = emailController.text;
        context.go("/verificationCode");
      }
    });
    return ReuseableScaffold(
      appbar: true,
      text: "Let's Sign Up",
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Create\nAccount!",
                    style: textPoppions.bodyLarge!.copyWith(
                      fontSize: 24.sp,
                      color: kPrimaryDarkColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Form(
                  key: _signUp,
                  child: Column(
                    children: [
                      ReusableFormField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        hint: "Full Name",
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a name";
                          }
                          if (value.length < 4) {
                            return "Enter a name";
                          }
                          return null;
                        },
                      ),
                      ReusableFormField(
                        controller: birthdateController,
                        textInputAction: TextInputAction.next,
                        hint: "Date of Birth  (2025-07-25)",
                        keyboardType: TextInputType.text,
                        inputFormatter: [
                          FilteringTextInputFormatter.allow(RegExp(
                              r'[0-9\s\-]')), // Allow numbers, spaces, and dashes
                          LengthLimitingTextInputFormatter(10),
                        ],
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a User Name";
                          }
                          if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
                            return "Invalid format. Use YYYY-MM-DD.";
                          }
                          return null;
                        },
                      ),
                      ReusableFormField(
                        controller: userName,
                        textInputAction: TextInputAction.next,
                        hint: "User Name",
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a User Name";
                          }
                          if (value.length < 4) {
                            return "Enter a User Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ReusableFormField(
                        textInputAction: TextInputAction.next,
                        controller: emailController,
                        hint: "Email",
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a email";
                          }
                          final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ReusableFormField(
                        controller: passwordController,
                        textInputAction: TextInputAction.go,
                        hint: "Password",
                        obscureText: true,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a password";
                          }
                          if (value.length < 8) {
                            return "Password must be at least 8 characters long.";
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return "Password must contain at least one uppercase letter.";
                          }
                          if (!RegExp(r'\d').hasMatch(value)) {
                            return "Password must contain at least one number.";
                          }
                          if (!RegExp(r'[@$!%*?&]').hasMatch(value)) {
                            return "Password must contain at least one special character (@\$!%*?&).";
                          }
                          return null;
                        },
                      ),
                      ReusableFormField(
                        controller: genderController,
                        textInputAction: TextInputAction.go,
                        hint: "Gender",
                        readonly: true,
                        onTap: () {
                          ref.read(genderCheck.notifier).state = true;
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a Gender";
                          }
                          return null;
                        },
                      ),
                      check
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: genderOptions.map((gender) {
                                return Row(
                                  children: [
                                    Radio<int>(
                                      activeColor: AppColors.primaryColor,
                                      value: gender['value'],
                                      groupValue: genderValue,
                                      onChanged: (value) {
                                        ref
                                            .read(selectedGender.notifier)
                                            .state = value!;
                                        genderController.text = gender['label'];
                                      },
                                    ),
                                    Text(
                                      gender['label'],
                                      style: textPoppions.bodyLarge!.copyWith(
                                        fontSize: 12.sp,
                                        color: kPrimarylightColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            )
                          : Container(),
                      SizedBox(
                        height: 30.h,
                      ),
                      ReuseableButton(
                        minimumSize: Size(double.infinity, 40.h),
                        text: "Sign Up",
                        bgcolor: AppColors.primaryColor,
                        textcolor: kwhitelightColor,
                        ontap: () {
                          if (_signUp.currentState!.validate()) {
                            ref.read(signUpControllerProvider.notifier).signUp(
                                  nameController.text,
                                  birthdateController.text,
                                  userName.text,
                                  emailController.text,
                                  genderValue,
                                  passwordController.text,
                                );
                          }
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push('/signIn');
                        },
                        child: RichText(
                          text: TextSpan(
                              text: "Already have an account? ",
                              style: textPoppions.bodyLarge!.copyWith(
                                fontSize: 12.sp,
                                color: kPrimarylightColor,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: "SignIn",
                                  style: textPoppions.bodyLarge!.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
