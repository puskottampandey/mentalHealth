import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/configs/therapist_details_model.dart';
import 'package:mentalhealth/configs/therapist_list_model.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';

class TherapistListDataController extends StateNotifier<StateModel> {
  TherapistListDataController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> therapistList() async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: APIEndpoints.therapist,
            request: "get",
          );

      if (mounted) {
        state = state.copyWith(
            data: therapistListFromJson(res.data["items"]),
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

final therapistListControllerProvider =
    StateNotifierProvider<TherapistDetailsController, StateModel>(
        (ref) => TherapistDetailsController(ref));

class TherapistDetailsController extends StateNotifier<StateModel> {
  TherapistDetailsController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> therapistDetails(String? id) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: "${APIEndpoints.therapist}/$id",
            request: "get",
          );
      print(res.data);
      if (mounted) {
        state = state.copyWith(
            data: therapistDetailsfromJson(res.data),
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

final therapistDetailsControllerProvider =
    StateNotifierProvider<TherapistDetailsController, StateModel>(
        (ref) => TherapistDetailsController(ref));
