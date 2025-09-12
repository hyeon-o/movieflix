import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/repos/authentication_repository.dart';

class UserProvider extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    return ref.watch(authenticationStateChangesProvider).value;
  }
}

final userProvider = AsyncNotifierProvider<UserProvider, User?>(
  () => UserProvider(),
);
