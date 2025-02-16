import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mentalhealth/configs/auth_response_model.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/payment_verify.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/controllers/theraplist.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';
import 'package:mentalhealth/global/services/token_service.dart';

class PaymentTransactionsController extends StateNotifier<StateModel> {
  PaymentTransactionsController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> paymentTrasactions({
    String? id,
    String? therapistId,
    String? productId,
    String? prductName,
    int? amount,
    String? referenceId,
  }) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: APIEndpoints.payment,
            data: {
              "userId": id,
              "therapistId": therapistId,
              "productId": productId,
              "productName": prductName,
              "amount": amount,
              "referenceId": referenceId,
              "subscriptionType": 0
            },
            request: "post",
          );
      await ref
          .read(paymentVerifyControllerProvider.notifier)
          .paymentVerify(referenceId);
      await ref.read(therapistListControllerProvider.notifier).therapistList();
      if (mounted) {
        state = state.copyWith(
            data: res.data["Details"],
            responseModel: res,
            requestStatus: RequestStatus.success);
      }
    } catch (e) {
      state = state.copyWith(
        requestStatus: RequestStatus.failure,
        message: e.toString(),
      );
    } finally {
      ref.read(isloadingProvider.notifier).state = false;
    }
  }
}

final paymentTransactionsControllerProvider =
    StateNotifierProvider<PaymentTransactionsController, StateModel>(
        (ref) => PaymentTransactionsController(ref));
