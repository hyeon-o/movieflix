import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/repos/auth_repository.dart';
import 'package:mood_tracker/screens/home_screen.dart';
import 'package:mood_tracker/widgets/navigation_layout.dart';
import 'package:mood_tracker/screens/post_screen.dart';
import 'package:mood_tracker/screens/sign_in_screen.dart';
import 'package:mood_tracker/screens/sign_up_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: HomeScreen.routePath,
    redirect: (context, state) {
      final isAuthenticated = ref.read(authRepositoryProvider).isAuthenticated;
      if (!isAuthenticated &&
          !state.uri.path.contains(SignInScreen.routePath) &&
          !state.uri.path.contains(SignUpScreen.routePath)) {
        return SignInScreen.routePath;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: SignInScreen.routePath,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: SignUpScreen.routePath,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: HomeScreen.routePath,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const NavigationLayout(item: NavigationItem.home),
          );
        },
      ),
      GoRoute(
        path: PostScreen.routePath,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const NavigationLayout(item: NavigationItem.post),
          );
        },
      ),
    ],
  );
});
