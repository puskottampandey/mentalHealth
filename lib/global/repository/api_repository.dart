import '../../configs/response_model.dart';
import '../services/dio_service.dart';

class ApiRepository {
  Future<ResponseModel> apiRequest(
      {required String endpoint,
      required String request,
      String? pathParameter,
      Object? data,
      Options? options,
      dynamic queryParameter}) async {
    late Response res;
    try {
      switch (request.toLowerCase()) {
        case "get":
          res = await DioService().client.get("$endpoint${pathParameter ?? ""}",
              queryParameters: queryParameter);
          break;
        case "post":
          res = await DioService().client.post(
                "$endpoint${pathParameter ?? ""}",
                queryParameters: queryParameter,
                data: data,
                options: Options(
                  contentType: 'multipart/form-data',
                ),
              );
          break;
        case "put":
          res = await DioService().client.put(
                "$endpoint${pathParameter ?? ""}",
                queryParameters: queryParameter,
                data: data,
              );
          break;
        default:
          res = await DioService().client.post(
              "$endpoint${pathParameter ?? ""}",
              queryParameters: queryParameter,
              data: data);
          break;
      }

      return ResponseModel.fromJson(res.data);
    } on DioException catch (e) {
      if (e.response != null) {
        final Map<String, dynamic> errorData = e.response!.data;
        final errorMessage = errorData['errors'][0]['detail'][0];
        // Handle specific HTTP status codesr
        switch (e.response!.statusCode) {
          case 400:
            throw " $errorMessage";
          case 401:
            throw "$errorMessage";
          // Add more cases for other status codes if needed
          default:
            throw "HTTP Error ${e.response!.statusCode}: ${e.response!.data}";
        }
      } else {
        throw "Network Error: ${e.message}";
      }
    }
  }
}

class ApiResponseRepository {
  Future<ResponseModel> apiRequest(
      {required String endpoint,
      required String request,
      String? pathParameter,
      Map<String, dynamic>? data,
      dynamic queryParameter}) async {
    try {
      Response? res;
      switch (request.toLowerCase()) {
        case "get":
          res = await DioService().client.get("$endpoint${pathParameter ?? ""}",
              queryParameters: queryParameter);
          break;
        case "post":
          res = await DioService().client.post(
              "$endpoint${pathParameter ?? ""}",
              queryParameters: queryParameter,
              data: data);
          break;
        default:
          res = await DioService().client.post(
              "$endpoint${pathParameter ?? ""}",
              queryParameters: queryParameter,
              data: data);
          break;
      }
      return ResponseModel(
        links: null,
        currentPage: null,
        total: null,
        totalPages: null,
        perPage: null,
        data: res.data['data'],
      );
    } on DioException catch (e) {
      if (e.response!.statusCode! >= 500) {
        throw "Internal Server Error";
      } else {
        throw (e.response!.data!);
      }
    }
  }
}
