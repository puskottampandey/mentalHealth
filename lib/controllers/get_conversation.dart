import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mentalhealth/configs/conversation_history.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';

import '../global/repository/api_repository.dart';

final otherId = StateProvider((ref) => '');

class ConversationController extends StateNotifier<StateModel> {
  ConversationController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> getConversations(String? conId) async {
    try {

      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: "${APIEndpoints.sendMessage}/$conId",
            request: "get",
          );
      ref.watch(otherId.notifier).state = res.data["otherParticipantId"];
      if (mounted) {
        state = state.copyWith(
            data: historyLinkFromJson(res.data),
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

final conversationControllerProvider =
    StateNotifierProvider<ConversationController, StateModel>(
        (ref) => ConversationController(ref));
