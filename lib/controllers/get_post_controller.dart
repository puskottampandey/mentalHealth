import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mentalhealth/configs/post_model.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/configs/therapist_details_model.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';

import '../global/repository/api_repository.dart';

class PostListController extends StateNotifier<StateModel> {
  PostListController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> getPostList() async {
    try {
      print("Value");
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: APIEndpoints.getposts,
            request: "get",
          );
      print(res.data);
      if (mounted) {
        state = state.copyWith(
            data:  postListFromJson(res.data["items"]),
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

final postListControllerProvider =
    StateNotifierProvider<PostListController, StateModel>(
        (ref) => PostListController(ref));
