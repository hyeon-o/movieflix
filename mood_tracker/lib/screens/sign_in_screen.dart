import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_tracker/screens/sign_up_screen.dart';
import 'package:mood_tracker/widgets/auth_form.dart';

class SignInScreen extends StatelessWidget {
  static const routePath = '/sign-in';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 1),
              Text(
                'Welcome back.',
                style: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.displayMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              const AuthForm(authType: AuthType.signIn),
              const Spacer(flex: 2),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.go(SignUpScreen.routePath),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        text: 'Sign up',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
