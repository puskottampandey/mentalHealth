import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/login_controller.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/reuseable/snackbar.dart';
import 'package:mentalhealth/views/authentication/signup/sign_up_screen.dart';

import '../../../global/constants/colors_text.dart';
import '../../../global/reuseable/button.dart';
import '../../../global/reuseable/formfield.dart';
import '../../../global/reuseable/scaffold.dart';

final email = AutoDisposeProvider((ref) => TextEditingController());
final password = AutoDisposeProvider((ref) => TextEditingController());

class SignInScreen extends ConsumerWidget {
  final GlobalKey<FormState> _signIn = GlobalKey<FormState>();
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailcontroller = ref.watch(email);
    final passwordcontroller = ref.watch(password);

    ref.listen<StateModel>(authControllerProvider, (previous, next) async {
      if (next.requestStatus == RequestStatus.failure) {
        SnackBars.errorsnackbar(context, "Something went wrong");
      }
      if (next.requestStatus == RequestStatus.success) {
        SnackBars.successSnackbar(context, "Login successful!");
        ref.read(userDataControllerProvider.notifier).userData();
        context.go("/moodPost");
      }
    });
    return Consumer(builder: (context, ref, child) {
      final isloading = ref.watch(isloadingProvider);
      return ReuseableScaffold(
        appbar: true,
        back: false,
        text: "Let's Sign In",
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
                    "WelCome\nBack!",
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
                  key: _signIn,
                  child: Column(
                    children: [
                      ReusableFormField(
                        obscureText: false,
                        controller: emailcontroller,
                        hint: "Email/Username",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ReusableFormField(
                        obscureText: true,
                        controller: passwordcontroller,
                        hint: "Password",
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Enter a password";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          context.push("/forgotpassword");
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Forgot Password?",
                            style: textPoppions.bodyLarge!.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      ReuseableButton(
                        isloading: isloading,
                        bgcolor: AppColors.primaryColor,
                        text: "Sign In",
                        textcolor: kvverylightColor,
                        ontap: () {
                          if (_signIn.currentState!.validate()) {
                            final authc =
                                ref.read(authControllerProvider.notifier);

                            authc.login(
                              emailcontroller.text.toString(),
                              passwordcontroller.text.toString(),
                            );
                          }
                          // context.go("/myApp");
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          ref.read(genderCheck.notifier).state = false;
                          ref.read(selectedGender.notifier).state = -1;

                          context.push("/signup");
                        },
                        child: RichText(
                          text: TextSpan(
                              text: "Don't have an account yet? ",
                              style: textPoppions.bodyLarge!.copyWith(
                                fontSize: 12.sp,
                                color: kPrimarylightColor,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: "SignUp",
                                  style: textPoppions.bodyLarge!.copyWith(
                                    fontSize: 12.sp,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ]),
                        ),
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
