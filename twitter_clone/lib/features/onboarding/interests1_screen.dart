import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/constants/gaps.dart';
import 'package:twitter_clone/constants/sizes.dart';
import 'package:twitter_clone/features/onboarding/interests2_screen.dart';

class Interests1Screen extends StatefulWidget {
  const Interests1Screen({super.key});

  @override
  State<Interests1Screen> createState() => _Interests1ScreenState();
}

class _Interests1ScreenState extends State<Interests1Screen> {
  static const interests = [
    "Daily Life",
    "Comedy",
    "Entertainment",
    "Animals",
    "Food",
    "Beauty & Style",
    "Drama",
    "Learning",
    "Talent",
    "Sports",
    "Auto",
    "Family",
    "Fitness & Health",
    "DIY & Life Hacks",
    "Art & Crafts",
    "Dance",
    "Outdoors",
    "Oddly Satisfying",
    "Home & Garden",
  ];

  final List<String> _selectedInterests = [];

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Interests2Screen()),
    );
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
      body: Scrollbar(
        child: SingleChildScrollView(
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
                  "What do you want to see on Twitter?",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Gaps.v20,
                Text(
                  'Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade300,
                  height: Sizes.size40,
                ),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: Sizes.size16,
                  mainAxisSpacing: Sizes.size16,
                  childAspectRatio: 1.6,
                  children: interests
                      .map((interest) => _buildInterestCard(interest))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_selectedInterests.length} selected',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            ElevatedButton(
              onPressed: _selectedInterests.length >= 3 ? _onNextTap : null,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestCard(String interest) {
    final isSelected = _selectedInterests.contains(interest);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedInterests.remove(interest);
          } else {
            _selectedInterests.add(interest);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[600] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.blue[600]! : Colors.grey[400]!,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: isSelected,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: const Icon(Icons.check_circle, color: Colors.white),
                ),
              ],
            ),
            Gaps.v10,
            Row(
              children: [
                Text(
                  interest,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
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
