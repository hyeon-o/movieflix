import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thread_clone/screens/sign_up_screen.dart';
import 'package:thread_clone/widgets/sign_form.dart';

class SignInScreen extends StatelessWidget {
  static const String routePath = '/sign-in';

  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: Center(child: Image.asset(width: 100, 'assets/images/logo.png')),
              ),
              const SizedBox(height: 24),
              SignForm(signType: SignType.signIn),
              Spacer(),
              FractionallySizedBox(
                widthFactor: 1,
                child: OutlinedButton(
                  onPressed: () {
                    context.go(SignUpScreen.routePath);
                  },
                  child: const Text('Create new account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}