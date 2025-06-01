import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(String baseUrl)
      : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 5),
    headers: {'Content-Type': 'application/json'},
  )) {
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams, Options? options}) async {
    return await _dio.get(path, queryParameters: queryParams, options: options);
  }

  Future<Response> post(String path, {dynamic data, Options? options}) async {
    return await _dio.post(path, data: data, options: options);
  }

  Future<Response> put(String path, {dynamic data, Options? options}) async {
    return await _dio.put(path, data: data, options: options);
  }

  Future<Response> delete(String path, {Options? options}) async {
    return await _dio.delete(path, options: options);
  }

  Dio get raw => _dio; // for raw access
}
