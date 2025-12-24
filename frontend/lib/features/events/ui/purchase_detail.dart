import 'package:flutter/material.dart';

import '../data/models/event_model.dart';

/// Screen that displays the confirmation details after a successful purchase.
class PurchaseDetailScreen extends StatelessWidget {
  const PurchaseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Extract the PurchaseResult passed via arguments
    final result = ModalRoute.of(context)!.settings.arguments as PurchaseResult;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Confirmation'),
        automaticallyImplyLeading: false, // Prevents going back to the dialog
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.green, size: 100),
            const SizedBox(height: 24),
            Text(
              result.message,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(title: const Text('Event'), subtitle: Text(result.eventTitle)),
            ),
            Card(
              child: ListTile(
                title: const Text('Status'),
                subtitle: const Text('Payment Confirmed'),
                trailing: const Icon(Icons.verified_user, color: Colors.blue),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Returns to Home and clears navigation stack
                  Navigator.pushNamedAndRemoveUntil(context, '/events', (route) => false);
                },
                child: const Text('Back to Events'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
