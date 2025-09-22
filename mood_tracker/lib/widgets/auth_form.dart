import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/providers/auth_modifier.dart';
import 'package:mood_tracker/screens/home_screen.dart';
import 'package:mood_tracker/utils/message_util.dart';

enum AuthType { signIn, signUp }

class AuthForm extends ConsumerStatefulWidget {
  final AuthType authType;

  const AuthForm({super.key, required this.authType});

  @override
  ConsumerState<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends ConsumerState<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Email is required' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Password is required' : null,
          ),
          const SizedBox(height: 8),
          FractionallySizedBox(
            widthFactor: 1,
            child: FilledButton(
              onPressed: _submit,
              child: Text(
                widget.authType == AuthType.signIn ? 'Log In' : 'Sign Up',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref
          .read(authModifier.notifier)
          .authenticate(
            widget.authType == AuthType.signIn
                ? AuthAction.signIn
                : AuthAction.signUp,
            _emailController.text,
            _passwordController.text,
            () {
              context.go(HomeScreen.routePath);
            },
            (error) {
              MessageUtil.showErrorMessage(
                context: context,
                message: "Mian Mian Hae...",
                error: error,
              );
            },
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }
}
