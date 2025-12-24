import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meet2go_app/features/events/data/repositories/event_repository.dart';

import '../../../auth/logic/auth_provider.dart';
import '../models/event_model.dart';

// 1. Repository Provider
final eventRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return EventRepository(apiClient);
});

// 2. Event List Provider
final eventsListProvider = FutureProvider<List<EventModel>>((ref) async {
  return ref.watch(eventRepositoryProvider).fetchEvents();
});

// 3. Purchase Controller
final purchaseControllerProvider = StateNotifierProvider<PurchaseController, AsyncValue<PurchaseResult?>>((ref) {
  return PurchaseController(ref);
});

/// AsyncValue to represent the 3 states: Idle (data null), Loading, and Error/Success.
class PurchaseController extends StateNotifier<AsyncValue<PurchaseResult?>> {
  final Ref ref;

  PurchaseController(this.ref) : super(const AsyncValue.data(null));

  /// Executes the purchase logic for a ticket.
  Future<void> executePurchase(String eventId) async {
    // 1. Set loading state
    state = const AsyncValue.loading();

    try {
      final token = ref.read(authControllerProvider).token;

      // 2. Perform the API call
      final result = await ref.read(eventRepositoryProvider).buyTicket(eventId, token!);

      // 3. Update the state here to trigger the UI listener
      state = AsyncValue.data(result);

      // 4. Refresh the events list
      ref.invalidate(eventsListProvider);

    } catch (e, stack) {
      // 5. Update state with error if something fails
      state = AsyncValue.error(e, stack);
    }
  }

  /// Clears the purchase state to allow future purchases without interference.
  void reset() {
    state = const AsyncValue.data(null);
  }
}