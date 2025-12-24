import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../models/event_model.dart';

class EventRepository {
  final ApiClient apiClient;

  EventRepository(this.apiClient);

  /// Fetches the list of all events.
  Future<List<EventModel>> fetchEvents() async {
    final response = await apiClient.dio.get('/events');
    final List data = response.data['data'];
    return data.map((json) => EventModel.fromJson(json)).toList();
  }

  /// Sends a purchase request to the backend.
  /// Requires a valid JWT token.
  Future<PurchaseResult> buyTicket(String eventId, String token) async {
    try {
      final response = await apiClient.dio.post(
        '/events/purchase',
        data: {'eventId': eventId, 'quantity': 1},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return PurchaseResult.fromJson(response.data['data']);
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? 'An unexpected error occurred';
      throw Exception(errorMessage);
    }
  }
}