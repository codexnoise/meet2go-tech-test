import 'package:dio/dio.dart';

/// ApiClient handles the base configuration for HTTP requests.
/// It centralizes the BaseURL and timeout settings to ensure
/// consistency across the application.
class ApiClient {
  late Dio _dio;

  // Change this to your machine's IP address for physical device testing
  // or 10.0.2.2 for Android Emulator.
  final String _baseUrl = 'http://localhost:3000/api';

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Adding interceptors for logging or global error handling in the future
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }

  /// Getter for the Dio instance to be used by repositories.
  Dio get dio => _dio;
}