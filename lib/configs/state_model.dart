import 'package:mentalhealth/configs/response_model.dart';

enum RequestStatus { initial, progress, fetchingMore, success, failure }

class StateModel {
  final RequestStatus requestStatus;
  final dynamic data;
  final String message;
  final ResponseModel? responseModel;

  StateModel(
      {required this.requestStatus,
      this.data,
      required this.message,
      this.responseModel});
  StateModel copyWith(
          {RequestStatus? requestStatus,
          dynamic data,
          String? message,
          ResponseModel? responseModel}) =>
      StateModel(
          requestStatus: requestStatus ?? this.requestStatus,
          data: data ?? this.data,
          message: message ?? this.message,
          responseModel: responseModel ?? this.responseModel);
}
