import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/repos/authentication_repository.dart';
import 'package:thread_clone/screens/home_screen.dart';
import 'package:thread_clone/screens/sign_in_screen.dart';
import 'package:thread_clone/screens/sign_up_screen.dart';
import 'package:thread_clone/screens/post_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  ref.watch(authenticationStateChangesProvider);
  return GoRouter(
    initialLocation: HomeScreen.routePath,
    redirect: (context, state) {
      final isAuthenticated = ref.read(authenticationRepositoryProvider).isAuthenticated;
      if (!isAuthenticated && !state.uri.path.contains(SignInScreen.routePath) && !state.uri.path.contains(SignUpScreen.routePath)) {
        return SignInScreen.routePath;
      }
      return null;
    },
    routes: [
      GoRoute(path: HomeScreen.routePath, builder: (context, state) => const HomeScreen()),
      GoRoute(path: SignInScreen.routePath, builder: (context, state) => const SignInScreen()),
      GoRoute(path: SignUpScreen.routePath, builder: (context, state) => const SignUpScreen()),
      GoRoute(path: PostScreen.routePath, builder: (context, state) => const PostScreen()),
    ],
  );
});