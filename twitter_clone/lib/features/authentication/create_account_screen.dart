import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/constants/gaps.dart';
import 'package:twitter_clone/constants/sizes.dart';
import 'package:twitter_clone/features/authentication/customization_screen.dart';
import 'package:twitter_clone/features/authentication/sign_up_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _birthDateController = TextEditingController();
  bool _showDatePicker = false;
  // var _model = Account(name: '', email: '', birthDate: '');

  // 임시로 현재 입력값을 저장할 변수들
  final DateTime _initialBirthDate = DateTime.now();
  bool _isValid = false;
  bool _isCustomized = false;

  void _onCancelTap(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SignUpScreen()),
      (route) => false,
    );
  }

  bool _isAllValid() {
    final isValid =
        _nameController.text.isNotEmpty && _emailController.text.isNotEmpty;
    if (!isValid) {
      setState(() {
        _isCustomized = false;
      });
    }
    return isValid;
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(' ').first;
    _birthDateController.value = TextEditingValue(text: textDate);
  }

  void _onNextTap() async {
    _unfocus();
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const CustomizationScreen()),
    );
    if (result == true) {
      setState(() {
        _isCustomized = true;
      });
    }
  }

  void _unfocus() {
    FocusScope.of(context).unfocus();
    setState(() {
      _showDatePicker = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      setState(() {
        _isValid = _isAllValid();
      });
    });
    _emailController.addListener(() {
      setState(() {
        _isValid = _isAllValid();
      });
    });
    _setTextFieldDate(_initialBirthDate);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocus,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: const FaIcon(
            FontAwesomeIcons.twitter,
            color: Color(0xFF1DA1F2),
            size: 30,
          ),
          leading: TextButton(
            onPressed: () => _onCancelTap(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          leadingWidth: 100,
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // [헤드라인 텍스트]
                          Text(
                            'Create your account',
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Gaps.v40,
                          // [이름 입력 필드]
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              hintText: 'Name',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              suffixIcon: _nameController.text.isNotEmpty
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  : null,
                            ),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Gaps.v24,
                          // [이메일 입력 필드]
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              suffixIcon: _emailController.text.isNotEmpty
                                  ? Icon(
                                      Icons.check_circle,
                                      color: Colors.green,
                                    )
                                  : null,
                            ),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Gaps.v24,
                          // [생년월일 입력 필드]
                          TextField(
                            readOnly: true,
                            controller: _birthDateController,
                            decoration: InputDecoration(
                              hintText: 'Date of birth',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                            onTap: () => setState(() {
                              _showDatePicker = true;
                            }),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Gaps.v8,
                          // [생년월일 안내 텍스트]
                          Text(
                            'This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet, or something else.',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                          ),
                          const Spacer(),
                          if (_isCustomized)
                            Column(
                              children: [
                                const Text(
                                  'By signing up, you agree to our Terms, Privacy Policy, and Cookie Use. Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy. Learn more. Otherwise, you can create an account with your phone or email.',
                                ),
                                Gaps.v16,
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).primaryColor,
                                      foregroundColor: Colors.white,
                                    ),
                                    child: const Text('Sign up'),
                                  ),
                                ),
                              ],
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: _isValid ? _onNextTap : null,
                                  child: const Text('Next'),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: _showDatePicker
            ? BottomAppBar(
                height: 200,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  maximumDate: _initialBirthDate,
                  initialDateTime: _initialBirthDate,
                  onDateTimeChanged: _setTextFieldDate,
                ),
              )
            : null,
      ),
    );
  }
}
