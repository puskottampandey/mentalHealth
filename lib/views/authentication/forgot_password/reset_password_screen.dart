import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';


import '../../../global/constants/colors_text.dart';
import '../../../global/reuseable/button.dart';
import '../../../global/reuseable/formfield.dart';
import '../../../global/reuseable/scaffold.dart';

final resetProvider = AutoDisposeProvider((ref) => TextEditingController());

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reset = ref.watch(resetProvider);
    final GlobalKey<FormState> _reset = GlobalKey<FormState>();
    return ReuseableScaffold(
      appbar: true,
      text: "Reset Password",
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter a new Password",
              style: textPoppions.bodyLarge!.copyWith(
                fontSize: 14.sp,
                color: klightDarkColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 100.h,
            ),
            Form(
              key: _reset,
              child: Column(
                children: [
                  ReusableFormField(
                    controller: reset,
                    hint: "New Password",
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ReusableFormField(
                    controller: reset,
                    hint: "Confirm Password",
                    obscureText: true,
                    textInputAction: TextInputAction.next,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a valid password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  ReuseableButton(
                    bgcolor: AppColors.primaryColor,
                    text: "Confirm",
                    textcolor: kvverylightColor,
                    ontap: () {
                      if (_reset.currentState!.validate()) {}
                      // context.push("/myApp");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
