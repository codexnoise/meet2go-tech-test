import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../models/user_model.dart';

/// Repository in charge of communicating with the Auth API endpoints.
class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  /// Authenticates the user and returns the token and user data.
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await apiClient.dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return {
          'token': data['token'],
          'user': UserModel.fromJson(data['user']),
        };
      } else {
        throw Exception('Failed to authenticate');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'Connection error';
      throw Exception(errorMessage);
    }
  }
}