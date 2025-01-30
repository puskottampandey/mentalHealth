import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mentalhealth/configs/auth_response_model.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';
import 'package:mentalhealth/global/services/token_service.dart';

class SendMessageConfirmController extends StateNotifier<StateModel> {
  SendMessageConfirmController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> sendMessage(
    String? id,
    String? content,
  ) async {
    try {
      final idUser = ref.watch(userId);
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: "${APIEndpoints.sendMessage}/$id/messages",
            data: {
              "senderId": idUser,
              "content": content,
            },
            request: "post",
          );
      print(res.data);
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

final sendMessageControllerProvider =
    StateNotifierProvider<SendMessageConfirmController, StateModel>(
        (ref) => SendMessageConfirmController(ref));
