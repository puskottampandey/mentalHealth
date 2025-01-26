import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';

import '../../../global/constants/colors_text.dart';
import '../../../global/reuseable/button.dart';
import '../../../global/reuseable/formfield.dart';
import '../../../global/reuseable/scaffold.dart';

final emailForget = AutoDisposeProvider((ref) => TextEditingController());

class ForgotPassword extends ConsumerWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forgetEmail = ref.watch(emailForget);
    final GlobalKey<FormState> _forgot = GlobalKey<FormState>();
    return ReuseableScaffold(
      appbar: true,
      text: "Forget Password",
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          children: [
            Text(
              "We need your registration email to send your password reset code! ",
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
              key: _forgot,
              child: Column(
                children: [
                  ReusableFormField(
                    controller: forgetEmail,
                    hint: "Email",
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ReuseableButton(
                    bgcolor: AppColors.primaryColor,
                    text: "Send code",
                    textcolor: kvverylightColor,
                    ontap: () {
                      if (_forgot.currentState!.validate()) {}
                      context.push("/verificationCode");
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
