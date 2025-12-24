import 'package:dio/dio.dart';

/// ApiClient handles the base configuration for HTTP requests.
/// It centralizes the BaseURL and timeout settings to ensure
/// consistency across the application.
class ApiClient {
  late Dio _dio;

  // 1. If using ANDROID EMULATOR: Use 10.0.2.2
  // 2. If using IOS SIMULATOR: Use 127.0.0.1 or localhost
  // 3. If using PHYSICAL DEVICE: Use your computer's local IP (e.g., 192.168.1.50)
  final String _baseUrl = 'http://10.0.2.2:3000/api';

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