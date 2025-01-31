import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mentalhealth/configs/auth_response_model.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';
import 'package:mentalhealth/global/services/token_service.dart';

class CommentPostController extends StateNotifier<StateModel> {
  CommentPostController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> commentPost(
    String? postId,
    String? userId,
    String? comment,
  ) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: APIEndpoints.commentposts,
            data: {
              "postId": postId,
              "userId": userId,
              "comment": comment,
            },
            request: "post",
          );

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

final commentPostControllerProvider =
    StateNotifierProvider<CommentPostController, StateModel>(
        (ref) => CommentPostController(ref));
