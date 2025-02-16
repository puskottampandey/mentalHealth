import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';

class PHQ9PostController extends StateNotifier<StateModel> {
  PHQ9PostController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> postPhq9({
    String? id,
    List<Map<String, dynamic>>? map,
  }) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: APIEndpoints.phq9,
            data: {
              "userId": id,
              "dateCompleted": DateTime.now().toUtc().toIso8601String(),
              "phq9Request": map,
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

final phq9ControllerProvider =
    StateNotifierProvider<PHQ9PostController, StateModel>(
        (ref) => PHQ9PostController(ref));
