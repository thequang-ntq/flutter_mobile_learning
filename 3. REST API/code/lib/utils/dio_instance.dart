import 'package:code/utils/constants.dart';
import 'package:code/utils/dio_interceptor.dart';
import 'package:dio/dio.dart';

class DioClient {
  DioClient._();

  static final DioClient instance = DioClient._();

  final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: Constants.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            sendTimeout: const Duration(seconds: 10),
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
            responseType: ResponseType.json,
          ),
        )
        ..interceptors.add(DioInterceptor())
        ..interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true),
        );
}
