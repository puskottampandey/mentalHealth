import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';

class MoodPostController extends StateNotifier<StateModel> {
  MoodPostController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> postMood({
    String? id,
    int? mood,
    String? notes,
    int? moodIntensity,
    int? sleepHours,
    int? exercise,
    int? weather,
    int? stresslevel,
    bool? socialInteraction,
  }) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: APIEndpoints.mood,
            data: {
              "userId": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
              "mood": 0,
              "notes": "string",
              "moodIntensity": 10,
              "sleepHours": 24,
              "exerciseMinutes": 1440,
              "weather": 0,
              "stressLevel": 10,
              "socialInteraction": true
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

final moodControllerProvider =
    StateNotifierProvider<MoodPostController, StateModel>(
        (ref) => MoodPostController(ref));
