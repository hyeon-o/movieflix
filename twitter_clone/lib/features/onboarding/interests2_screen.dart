import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/constants/gaps.dart';
import 'package:twitter_clone/constants/sizes.dart';

class Interests2Screen extends StatefulWidget {
  const Interests2Screen({super.key});

  @override
  State<Interests2Screen> createState() => _Interests2ScreenState();
}

class _Interests2ScreenState extends State<Interests2Screen> {
  static const _musicInterests = [
    'Rap',
    'R&B & soul',
    'Grammy Awards',
    'Pop',
    'K-pop',
    'Music industry',
    'EDM',
    'Music news',
    'Hip hop',
    'Reggae',
    'Country',
    'Jazz',
    'Classical',
    'Blues',
    'Rock',
    'Folk',
    'Soul',
    'Funk',
    'Disco',
    'R&B',
    'Soul',
    'Funk',
  ];

  static const _entertainmentInterests = [
    'Anime',
    'Movies & TV',
    'Harry Potter',
    'Marvel Universe',
    'Movie news',
    'Naruto',
    'Movies',
    'Grammy Awards',
    'Entertainment news',
    'Naruto',
    'Movies',
    'Grammy Awards',
    'Entertainment news',
  ];

  final List<String> _selectedInterests = [];

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
                  'Interests are used to personalize your experience and will be visible on your profile.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade300,
                  height: Sizes.size40,
                ),
                Gaps.v10,
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Music',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.v20,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: [
                              for (var interest in _musicInterests)
                                _buildInterestButton(interest),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Gaps.v10,
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade300,
                  height: Sizes.size40,
                ),
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Entertainment',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Sizes.size20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.v20,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            runSpacing: 10,
                            spacing: 10,
                            children: [
                              for (var interest in _entertainmentInterests)
                                _buildInterestButton(interest),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: _selectedInterests.length >= 3 ? () {} : null,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInterestButton(String interest) {
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[600] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.blue[600]! : Colors.grey[400]!,
          ),
        ),
        child: Text(
          interest,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
