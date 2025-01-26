import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../global/constants/colors_text.dart';
import '../../global/reuseable/button.dart';
import '../../global/reuseable/scaffold.dart';


class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _pay = false;

  @override
  Widget build(BuildContext context) {
    return ReuseableScaffold(
      appbar: true,
      text: "Payment",
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _pay = true;
                });
              },
              child: Card(
                color: AppColors.pureWhiteColor,
                elevation: 0,
                child: ListTile(
                  leading: SizedBox(
                    child: Image.asset(
                      "assets/images/esewa_logo.png",
                      height: 50.h,
                      width: 50.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  title: Text(
                    "Esewa",
                    style: textPoppions.headlineMedium?.copyWith(
                      color: AppColors.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Container(
                    height: 20.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                        color: _pay ? AppColors.primaryColor : null,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1.5,
                          color: AppColors.iconColor,
                        )),
                  ),
                ),
              ),
            ),
            const Spacer(),
            ReuseableButton(
                bgcolor: _pay ? AppColors.primaryColor : AppColors.iconColor,
                textcolor: AppColors.pureWhiteColor,
                text: "Payment ",
                ontap: _pay
                    ? () {
                        //   try {
                        //     EsewaFlutterSdk.initPayment(
                        //       esewaConfig: EsewaConfig(
                        //         environment: Environment.test,
                        //         clientId:
                        //             "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
                        //         secretId:
                        //             "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ== ",
                        //       ),
                        //       esewaPayment: EsewaPayment(
                        //         productId: "1d71jd81",
                        //         productName: "Product One",
                        //         productPrice: "20",
                        //         callbackUrl: '',
                        //       ),
                        //       onPaymentSuccess: (EsewaPaymentSuccessResult data) {
                        //         debugPrint(":::SUCCESS::: => $data");
                        //       },
                        //       onPaymentFailure: (data) {
                        //         debugPrint(":::FAILURE::: => $data");
                        //       },
                        //       onPaymentCancellation: (data) {
                        //         debugPrint(":::CANCELLATION::: => $data");
                        //       },
                        //     );
                        //   } on Exception catch (e) {
                        //     debugPrint("EXCEPTION : ${e.toString()}");
                        //   }
                      }
                    : () {})
          ],
        ),
      ),
    );
  }
}
