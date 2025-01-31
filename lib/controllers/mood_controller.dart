import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mentalhealth/configs/conversation_history.dart';
import 'package:mentalhealth/configs/mood_model.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/configs/therapist_details_model.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';

import '../global/repository/api_repository.dart';

class MoodController extends StateNotifier<StateModel> {
  MoodController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> getSleep(String? id) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: "${APIEndpoints.sleepHistory}/$id",
            request: "get",
          );

      if (mounted) {
        state = state.copyWith(
            data: sleepListFromJson(res.data["items"]),
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
    StateNotifierProvider<MoodController, StateModel>(
        (ref) => MoodController(ref));

class MoodTrendsController extends StateNotifier<StateModel> {
  MoodTrendsController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> getmood(String? id) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: "${APIEndpoints.moodTrends}/$id",
            request: "get",
          );

      if (mounted) {
        state = state.copyWith(
            data: moodListFromJson(res.data["items"]),
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

final moodTrendsControllerProvider =
    StateNotifierProvider<MoodTrendsController, StateModel>(
        (ref) => MoodTrendsController(ref));

class ExericseController extends StateNotifier<StateModel> {
  ExericseController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;
  Future<void> getExercise(String? id) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: "${APIEndpoints.exerciseMin}/$id",
            request: "get",
          );

      if (mounted) {
        state = state.copyWith(
            data: exerciseListFromJson(res.data["items"]),
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

final exerciseControllerProvider =
    StateNotifierProvider<ExericseController, StateModel>(
        (ref) => ExericseController(ref));
