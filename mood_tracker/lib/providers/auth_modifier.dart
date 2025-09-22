import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/repos/auth_repository.dart';

enum AuthAction { signIn, signUp }

class AuthModifier extends AsyncNotifier<void> {
  late final AuthRepository _authRepository;

  @override
  Future<void> build() async {
    _authRepository = ref.read(authRepositoryProvider);
  }

  Future<void> authenticate(
    AuthAction action,
    String email,
    String password,
    Function() onSuccess,
    Function(String) onError,
  ) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => switch (action) {
        AuthAction.signIn => _authRepository.signIn(email, password),
        AuthAction.signUp => _authRepository.signUp(email, password),
      },
    );
    if (state.hasError) {
      onError(state.error.toString());
    } else {
      onSuccess();
    }
  }

  Future<void> deauthenticate() async {
    await _authRepository.signOut();
  }
}

final authModifier = AsyncNotifierProvider<AuthModifier, void>(
  () => AuthModifier(),
);
