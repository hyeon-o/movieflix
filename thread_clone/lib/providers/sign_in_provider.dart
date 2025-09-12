import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/screens/home_screen.dart';
import 'package:thread_clone/utils/show_message_utils.dart';
import 'package:thread_clone/repos/authentication_repository.dart';

class SignInViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  Future<void> build() async {
    _authenticationRepository = ref.read(authenticationRepositoryProvider);
  }

  Future<void> signIn(String email, String password, BuildContext context) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _authenticationRepository.signIn(email, password),
    );
    if (state.hasError) {
      ShowMessageUtils.showErrorMessage(context, state.error!);
    } else {
      context.go(HomeScreen.routePath);
    }
  }
}

final signInProvider = AsyncNotifierProvider<SignInViewModel, void>(
  () => SignInViewModel(),
);
