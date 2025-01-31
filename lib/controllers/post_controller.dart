import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';

class PostController extends StateNotifier<StateModel> {
  PostController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> post({
    String? id,
    String? title,
    String? content,
    int? primaryMood,
    int? secondaryMood,
  }) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: APIEndpoints.posts,
            data: {
              "userId": id,
              "title": title,
              "content": content,
              "primaryMood": primaryMood,
              "secondaryMood": secondaryMood,
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

final postControllerProvider =
    StateNotifierProvider<PostController, StateModel>(
        (ref) => PostController(ref));
