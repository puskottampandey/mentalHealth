import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/foundation.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:go_router/go_router.dart';
import 'package:mentalhealth/controllers/payment_transactions.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/reuseable/snackbar.dart';
import 'package:mentalhealth/global/routes/router.dart';
import 'package:mentalhealth/views/home/home/therapist_data.dart';

class Esewa {
  static payment(String id, String name, String price, WidgetRef ref) {
    final userid = ref.watch(userId);
    final theraid = ref.watch(therapistId);
    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
          secretId: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ== ",
        ),
        esewaPayment: EsewaPayment(
          productId: id,
          productName: name,
          productPrice: price,
          callbackUrl: '',
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          ref
              .read(paymentTransactionsControllerProvider.notifier)
              .paymentTrasactions(
                  id: userid,
                  therapistId: theraid,
                  productId: id,
                  prductName: name,
                  amount: 2000,
                  referenceId: data.refId);

          navigatorKey.currentState!.context.go("/myApp");
        },
        onPaymentFailure: (data) {
          SnackBars.errorsnackbar(
              navigatorKey.currentState!.context, "Something went wrong ");
        },
        onPaymentCancellation: (data) {
          SnackBars.errorsnackbar(
              navigatorKey.currentState!.context, "Something went wrong ");
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }
  }
}
