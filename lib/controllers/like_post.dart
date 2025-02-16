import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mentalhealth/configs/auth_response_model.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';
import 'package:mentalhealth/global/services/token_service.dart';

class LikePostController extends StateNotifier<StateModel> {
  LikePostController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<Map<String, dynamic>?> likePost(
    String? postId,
    String? userId,
  ) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: APIEndpoints.likeposts,
            data: {
              "postId": postId,
              "userId": userId,
            },
            request: "post",
          );

      if (mounted) {
        state = state.copyWith(
            data: res.data["Details"],
            responseModel: res,
            requestStatus: RequestStatus.success);
      }
      return res.data;
    } catch (e) {
      state = state.copyWith(
        requestStatus: RequestStatus.failure,
        message: e.toString(),
      );
    } finally {
      ref.read(isloadingProvider.notifier).state = false;
    }
    return null;
  }
}

final likePostControllerProvider =
    StateNotifierProvider<LikePostController, StateModel>(
        (ref) => LikePostController(ref));
