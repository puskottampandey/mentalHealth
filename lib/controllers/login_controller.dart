import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mentalhealth/configs/auth_response_model.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/user_data.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/repository/api_repository.dart';
import 'package:mentalhealth/global/services/token_service.dart';

final isloadingProvider = StateProvider<bool>((ref) => false);

class AuthController extends StateNotifier<StateModel> {
  AuthController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> login(String? email, String? password) async {
    try {
      ref.read(isloadingProvider.notifier).state = true;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final res = await GetIt.I.get<ApiRepository>().apiRequest(
            endpoint: APIEndpoints.signIn,
            data: {
              "usernameOrEmail": email,
              'password': password,
            },
            request: "post",
          );
      TokenService().saveToken(res.data['token'], true);
      // TokenService().saveExpiry(authResponse.expiry, true);
   await ref.read(userDataControllerProvider.notifier).userData();
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

final authControllerProvider =
    StateNotifierProvider<AuthController, StateModel>(
        (ref) => AuthController(ref));
