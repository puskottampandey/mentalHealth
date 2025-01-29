import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mentalhealth/configs/auth_response_model.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';
import 'package:mentalhealth/global/services/token_service.dart';

final isloadingProvider = StateProvider<bool>((ref) => false);

class SignUpController extends StateNotifier<StateModel> {
  SignUpController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> signUp(
    String? fullname,
    String? birth,
    String? username,
    String? email,
    int? gender,
    String? password,
  ) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      DateTime date = DateFormat("yyyy-MM-dd").parse(birth!);
      String formattedDate =
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date.toUtc());
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: APIEndpoints.signUp,
            data: {
              "firstName": fullname?.split(" ").first,
              "lastName": fullname?.split(" ").last,
              "userName": username,
              "email": email,
              "password": password,
              "middleName": " ",
              "dob": formattedDate,
              "gender": gender
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

final signUpControllerProvider =
    StateNotifierProvider<SignUpController, StateModel>(
        (ref) => SignUpController(ref));
