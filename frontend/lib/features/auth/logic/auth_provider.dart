import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/api/api_client.dart';
import '../data/models/user_model.dart';
import '../data/repositories/auth_repository.dart';

/// Provides the ApiClient instance.
final apiClientProvider = Provider((ref) => ApiClient());

/// Provides the AuthRepository, injecting the ApiClient.
final authRepositoryProvider = Provider((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AuthRepository(apiClient);
});

/// StateNotifier to manage Authentication State.
/// Uses a custom AuthState class for better predictability.
final authControllerProvider = StateNotifierProvider<AuthController, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthController(repository);
});

/// Represents the different states of Authentication.
class AuthState {
  final bool isLoading;
  final String? token;
  final UserModel? user;
  final String? error;

  AuthState({this.isLoading = false, this.token, this.user, this.error});

  bool get isAuthenticated => token != null;

  AuthState copyWith({bool? isLoading, String? token, UserModel? user, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
      user: user ?? this.user,
      error: error,
    );
  }
}

/// Controller that handles login logic and updates the state.
class AuthController extends StateNotifier<AuthState> {
  final AuthRepository repository;

  AuthController(this.repository) : super(AuthState());

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await repository.login(email, password);
      state = state.copyWith(
          isLoading: false,
          token: result['token'],
          user: result['user']
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  /// Clears the current session and resets the state.
  void logout() {
    state = AuthState(); // Resets to initial empty state
  }
}