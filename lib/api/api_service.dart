import 'package:dio/dio.dart';

import 'app_config.dart';

class ApiService {
  static const String jsonType = 'application/json';
  static const int internalServerErrorCode = 500;

  static Future<Response<T>?> getApi<T>(
    String path,
  ) async {
    // dio init
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.getAppBaseUrl(),
      ),
    );
    final Response<T> response = await dio.get(
      path,
      options: Options(
        validateStatus: (int? status) {
          if (status != null) return status < internalServerErrorCode;
          return false;
        },
      ),
    );
    return response;
  }
}
