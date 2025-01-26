import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


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
                      hint: "Email",
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
                      bgcolor: AppColors.primaryColor,
                      text: "Sign In",
                      textcolor: kvverylightColor,
                      ontap: () {
                        if (_signIn.currentState!.validate()) {}
                        context.go("/myApp");
                      },
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () {
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
  }
}
