import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/providers/sign_in_provider.dart';
import 'package:thread_clone/providers/sign_up_provider.dart';

enum SignType { signIn, signUp }

class SignForm extends ConsumerStatefulWidget {
  final SignType signType;

  const SignForm({super.key, required this.signType});

  @override
  ConsumerState<SignForm> createState() => _SignFormState();
}

class _SignFormState extends ConsumerState<SignForm> {
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
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Email is required' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) =>
                value?.isEmpty ?? true ? 'Password is required' : null,
          ),
          const SizedBox(height: 8),
          FractionallySizedBox(
            widthFactor: 1,
            child: FilledButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  if (widget.signType == SignType.signIn) {
                    await ref
                      .read(signInProvider.notifier)
                      .signIn(_emailController.text, _passwordController.text, context);
                  } else {
                    await ref
                        .read(signUpProvider.notifier)
                        .signUp(_emailController.text, _passwordController.text, context);
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              },
              child: Text(widget.signType == SignType.signIn ? 'Log In' : 'Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}
