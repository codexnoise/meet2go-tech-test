import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../main.dart';
import '../../auth/logic/auth_provider.dart';
import '../data/models/event_model.dart';
import '../data/repositories/event_providers.dart';

class EventListScreen extends ConsumerWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<PurchaseResult?>>(purchaseControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (result) {
          if (result != null) {
            navigatorKey.currentState?.pushNamed('/purchase-success', arguments: result);
            ref.read(purchaseControllerProvider.notifier).reset();
          }
        },
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $error'), backgroundColor: Colors.red));
        },
      );
    });

    // Get the event list
    final eventsAsync = ref.watch(eventsListProvider);
    final user = ref.watch(authControllerProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meet2Go Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: Column(
        children: [
          if (user != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome, ${user.name}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          Expanded(
            child: eventsAsync.when(
              data: (events) => RefreshIndicator(
                onRefresh: () => ref.refresh(eventsListProvider.future),
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return _EventCard(event: event);
                  },
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error to fetch events: $err')),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends ConsumerWidget {
  final EventModel event;

  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchaseState = ref.watch(purchaseControllerProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(event.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${event.description}\nStock: ${event.stock}'),
        trailing: Text(
          '\$${event.price}',
          style: const TextStyle(color: Colors.green, fontSize: 16),
        ),
        isThreeLine: true,
        onTap: () => _showPurchaseDialog(context, ref, event, purchaseState.isLoading),
      ),
    );
  }

  void _showPurchaseDialog(BuildContext context, WidgetRef ref, EventModel event, bool isLoading) {
    showDialog(
      context: context,
      barrierDismissible: !isLoading,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Purchase'),
        content: Text('¿You wish to purchase 1 ticket for "${event.title}" by \$${event.price}?'),
        actions: [
          TextButton(
            onPressed: isLoading ? null : () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: isLoading
                ? null
                : () async {
                    Navigator.pop(context);

                    await ref.read(purchaseControllerProvider.notifier).executePurchase(event.id);
                  },
            child: isLoading
                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator())
                : const Text('Buy Now'),
          ),
        ],
      ),
    );
  }
}
