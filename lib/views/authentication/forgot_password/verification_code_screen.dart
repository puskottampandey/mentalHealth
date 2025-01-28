import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/email_confirm.dart';
import 'package:mentalhealth/global/reuseable/snackbar.dart';
import 'package:mentalhealth/views/authentication/signup/sign_up_screen.dart';
import 'package:pinput/pinput.dart';
import '../../../global/constants/colors_text.dart';
import '../../../global/reuseable/button.dart';
import '../../../global/reuseable/scaffold.dart';

final codeProvider = AutoDisposeProvider((ref) => TextEditingController());

class VerificationCodeScreen extends ConsumerWidget {
  VerificationCodeScreen({super.key});
  final GlobalKey<FormState> _code = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = ref.watch(codeProvider);
    final email = ref.watch(userEmail);
    ref.listen<StateModel>(emailConfirmControllerProvider,
        (previous, next) async {
      if (next.requestStatus == RequestStatus.failure) {
        SnackBars.errorsnackbar(context, "Something went wrong");
      }
      if (next.requestStatus == RequestStatus.success) {
        SnackBars.successSnackbar(context, " Successfull!, please sign in");
        context.go('/signIn');
      }
    });
    return ReuseableScaffold(
      appbar: true,
      text: "Verification Code",
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter the code we sent you",
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
              key: _code,
              child: Column(
                children: [
                  pinput(code),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Resend Code",
                      style: textPoppions.bodyLarge!.copyWith(
                        fontSize: 14.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  ReuseableButton(
                    bgcolor: AppColors.primaryColor,
                    text: "Confirm",
                    textcolor: kvverylightColor,
                    ontap: () {
                      if (_code.currentState!.validate()) {
                        ref
                            .read(emailConfirmControllerProvider.notifier)
                            .emailConfirm(code.text, email);
                      }
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

  Pinput pinput(TextEditingController code) {
    return Pinput(
      preFilledWidget: Text(
        "-",
        style: textPoppions.titleSmall!.copyWith(
          color: AppColors.blackColor,
          fontSize: 24.sp,
        ),
      ),
      controller: code,
      defaultPinTheme: pinTheme(AppColors.pureWhiteColor),
      errorPinTheme: pinTheme(AppColors.redColor),
      length: 6,
    );
  }

  PinTheme pinTheme(Color? colorPrimary) {
    return PinTheme(
        width: 48.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: AppColors.pureWhiteColor,
          border: Border.all(
            width: 1.5,
            color: colorPrimary!,
          ),
          borderRadius: BorderRadius.circular(10.r),
        ),
        textStyle: textPoppions.titleSmall!.copyWith(
          color: AppColors.blackColor,
          fontSize: 24.sp,
        ));
  }
}
