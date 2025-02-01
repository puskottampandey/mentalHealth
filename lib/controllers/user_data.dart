import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/configs/user_model.dart';
import 'package:mentalhealth/controllers/mood_controller.dart';
import 'package:mentalhealth/controllers/news_controller.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/controllers/theraplist.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';

final userId = StateProvider((ref) => "");

class UserDataController extends StateNotifier<StateModel> {
  UserDataController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> userData() async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: APIEndpoints.userData,
            request: "get",
          );

      ref.read(userId.notifier).state = res.data["id"];

      final id = ref.watch(userId);
      await ref.read(therapistListControllerProvider.notifier).therapistList();
      await ref.read(sleepControllerProvider.notifier).getSleep(id);
      await ref.read(moodTrendsControllerProvider.notifier).getmood(id);
      await ref.read(exerciseControllerProvider.notifier).getExercise(id);
      await ref.read(newsListControllerProvider.notifier).newsList();

      if (mounted) {
        state = state.copyWith(
            data: userDetailsfromJson(res.data),
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

final userDataControllerProvider =
    StateNotifierProvider<UserDataController, StateModel>(
        (ref) => UserDataController(ref));
