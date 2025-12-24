import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/auth/logic/auth_provider.dart';
import 'features/auth/ui/login_screen.dart';
import 'features/events/ui/event_list_screen.dart';
import 'features/events/ui/purchase_detail.dart';


/// Main entry point of the application.
/// Wrapped in ProviderScope to enable Riverpod state management.
void main() {
  runApp(
    const ProviderScope(
      child: Meet2GoApp(),
    ),
  );
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Meet2GoApp extends ConsumerWidget {
  const Meet2GoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the auth state to determine the initial route or react to logout
    final authState = ref.watch(authControllerProvider);

    return MaterialApp(
      title: 'Meet2Go',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      // Simple routing logic based on authentication state
      home: authState.isAuthenticated
          ? const EventListScreen()
          : const LoginScreen(),

      // Named routes for deeper navigation if needed
      routes: {
        '/login': (context) => const LoginScreen(),
        '/events': (context) => const EventListScreen(),
        '/purchase-success': (context) => const PurchaseDetailScreen(),
      },
    );
  }
}