import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/constants/gaps.dart';
import 'package:twitter_clone/features/authentication/create_account_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onCreateAccountTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const FaIcon(
          FontAwesomeIcons.twitter,
          color: Color(0xFF1DA1F2),
          size: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // [헤드라인 텍스트]
            Expanded(
              child: Center(
                child: Text(
                  "See what's happening in the world right now.",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // [구글 로그인 버튼]
            OutlinedButton.icon(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.google, size: 24),
              label: const Text(
                'Continue with Google',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ),
            Gaps.v16,
            // [애플 로그인 버튼]
            OutlinedButton.icon(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.apple, size: 24),
              label: const Text(
                'Continue with Apple',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ),
            Gaps.v24,
            // [구분선]
            Row(
              children: [
                const Expanded(
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'or',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const Expanded(
                  child: Divider(color: Colors.grey, thickness: 1),
                ),
              ],
            ),
            Gaps.v24,
            // [계정 생성 버튼]
            ElevatedButton(
              onPressed: () => _onCreateAccountTap(context),
              child: const Text(
                'Create account',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
            ),
            Gaps.v24,
            // [법적 고지 텍스트]
            Text(
              'By signing up, you agree to our Terms, Privacy Policy, and Cookie Use.',
            ),
            Gaps.v48,
            // [로그인 안내 텍스트]
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Already have an account?'),
                Gaps.h6,
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Log in',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
