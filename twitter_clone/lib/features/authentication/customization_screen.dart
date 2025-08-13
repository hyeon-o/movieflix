import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/constants/gaps.dart';
import 'package:twitter_clone/constants/sizes.dart';

class CustomizationScreen extends StatefulWidget {
  const CustomizationScreen({super.key});

  @override
  State<CustomizationScreen> createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
  bool _isChecked = true;

  void _onToggleChanged(bool newValue) {
    setState(() {
      _isChecked = newValue;
    });
  }

  void _onNextTap() {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const FaIcon(
          FontAwesomeIcons.twitter,
          color: Color(0xFF1DA1F2),
          size: Sizes.size32,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size32,
            vertical: Sizes.size40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v20,
              Text(
                'Customize your experience',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Gaps.v20,
              Text(
                'Track where you see Twitter content across the web',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Gaps.v16,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, or phone number.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Gaps.h10,
                  CupertinoSwitch(
                    value: _isChecked,
                    onChanged: _onToggleChanged,
                  ),
                ],
              ),
              Gaps.v24,
              Text(
                'By signing up, you agree to our Terms, Privacy Policy, and Cookie Use. Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy. Learn more',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _onNextTap,
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
