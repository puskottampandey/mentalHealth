import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mentalhealth/configs/state_model.dart';
import 'package:mentalhealth/controllers/get_reports.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import '../global/services/dio_service.dart';

final progressProviderPHQ = StateProvider<double>((ref) => 0.0);
final reportLoadingPHQ = StateProvider((ref) => false);

class ReportControllerPHQ extends StateNotifier<StateModel> {
  ReportControllerPHQ(this.ref)
      : super(StateModel(
            requestStatus: RequestStatus.initial, message: "Initial"));

  final Ref ref;

  Future<void> getReportPhq(String? id) async {
    try {
      ref.read(reportLoading.notifier).state = true;
      ref.read(progressProvider.notifier).state = 0.0;
      state = state.copyWith(requestStatus: RequestStatus.progress);
      final dio = Dio();

      // String filePath = "${(await getExternalStorageDirectory())!.path}/file";
      final filePath =
          "${(await getExternalStorageDirectory())!}/PHQ9_Report_$id.xlsx";
      await dio.download(
        "https://mint-publicly-seagull.ngrok-free.app/api/Phq9Questionnaires/download-phq9-report/$id",
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

final reportPHQControllerProvider =
    StateNotifierProvider<ReportControllerPHQ, StateModel>(
        (ref) => ReportControllerPHQ(ref));
