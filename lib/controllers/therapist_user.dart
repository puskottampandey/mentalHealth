import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mentalhealth/configs/chat_list_model.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';
import 'package:mentalhealth/views/home/chat/chat_screen.dart';

final conversationId = StateProvider((ref) => "");

class TherapistUser extends StateNotifier<StateModel> {
  TherapistUser(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> therapistUser(String id) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: APIEndpoints.mytherapist,
            data: {
              "userId": id,
            },
            request: "get",
          );

      if (mounted) {
        state = state.copyWith(
            data: chatListFromJson(res.data["items"]),
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

final therapistUserControllerProvider =
    StateNotifierProvider<TherapistUser, StateModel>(
        (ref) => TherapistUser(ref));
