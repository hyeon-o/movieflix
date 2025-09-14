import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/repos/authentication_repository.dart';

class SignInViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  Future<void> build() async {
    _authenticationRepository = ref.read(authenticationRepositoryProvider);
  }

  Future<void> signIn(String email, String password, Function() onSuccess, Function(String) onError) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _authenticationRepository.signIn(email, password),
    );
    if (state.hasError) {
      onError(state.error.toString());
    } else {
      onSuccess();
    }
  }
}

final signInProvider = AsyncNotifierProvider<SignInViewModel, void>(
  () => SignInViewModel(),
);
