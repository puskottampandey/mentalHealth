import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:mentalhealth/configs/conversation_history.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/signup_controller.dart';
import 'package:mentalhealth/global/constants/api_endpoints.dart';
import 'package:mentalhealth/global/services/dio_service.dart' as dio;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import '../global/repository/api_repository.dart';
import '../global/services/dio_service.dart';

final progressProvider = StateProvider<double>((ref) => 0.0);
final reportLoading = StateProvider((ref) => false);

class ReportController extends StateNotifier<StateModel> {
  ReportController(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> getReport(String? id) async {
    try {
      ref.read(reportLoading.notifier).state = true;
      ref.read(progressProvider.notifier).state = 0.0;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final dio = Dio();

      String filePath = "${(await getExternalStorageDirectory())!.path}/file";
      await dio.download(
        "https://mint-publicly-seagull.ngrok-free.app/api/Mood/download-mood-report/$id",
        filePath,
        options: Options(
          responseType: ResponseType.bytes,
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            ref.read(progressProvider.notifier).state = progress;
          }
        },
      );
      await OpenFilex.open(filePath);
      ref.read(reportLoading.notifier).state = false;
    } catch (e) {
      state = state.copyWith(
        requestStatus: RequestStatus.failure,
        message: e.toString(),
      );
    } finally {
      ref.read(reportLoading.notifier).state = false;
    }
  }
}

final reportControllerProvider =
    StateNotifierProvider<ReportController, StateModel>(
        (ref) => ReportController(ref));
