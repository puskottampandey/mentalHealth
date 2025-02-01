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
              "userId": id,
              "mood": mood,
              "notes": notes,
              "moodIntensity": moodIntensity,
              "sleepHours": sleepHours,
              "exerciseMinutes": exercise,
              "weather": weather,
              "stressLevel": stresslevel,
              "socialInteraction": socialInteraction
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
