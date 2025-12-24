import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meet2go_app/features/events/data/repositories/event_repository.dart';

import '../../../auth/logic/auth_provider.dart';
import '../models/event_model.dart';

// 1. Proveedor del Repositorio
final eventRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return EventRepository(apiClient);
});

// 2. Proveedor de la lista de eventos (Future)
final eventsListProvider = FutureProvider<List<EventModel>>((ref) async {
  return ref.watch(eventRepositoryProvider).fetchEvents();
});

// 3. El Controlador de Compra (La pieza que faltaba)
final purchaseControllerProvider = StateNotifierProvider<PurchaseController, AsyncValue<PurchaseResult?>>((ref) {
  return PurchaseController(ref);
});

/// Controller que maneja el proceso de compra.
/// Usa AsyncValue para representar los 3 estados: Idle (data null), Loading, y Error/Success.
class PurchaseController extends StateNotifier<AsyncValue<PurchaseResult?>> {
  final Ref ref;

  PurchaseController(this.ref) : super(const AsyncValue.data(null));

  /// Ejecuta la lógica de compra de un ticket.
  Future<void> executePurchase(String eventId) async {
    // Ponemos el estado en "Cargando"
    state = const AsyncValue.loading();

    try {
      // Obtenemos el token directamente del AuthController usando Riverpod
      final token = ref.read(authControllerProvider).token;

      if (token == null) {
        throw Exception('No session found. Please login again.');
      }

      // Llamamos al repositorio
      final result = await ref.read(eventRepositoryProvider).buyTicket(eventId, token);

      // Si todo sale bien, guardamos el resultado
      state = AsyncValue.data(result);

      // ¡IMPORTANTE!: Refrescamos la lista de eventos para que el stock se actualice en el Home
      ref.invalidate(eventsListProvider);

    } catch (e, stack) {
      // Si hay error (ej. falta de stock), lo capturamos
      state = AsyncValue.error(e, stack);
    }
  }

  /// Limpia el estado de la compra para permitir compras futuras sin interferencias.
  void reset() {
    state = const AsyncValue.data(null);
  }
}