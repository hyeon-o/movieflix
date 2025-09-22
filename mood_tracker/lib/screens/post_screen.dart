import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_tracker/providers/mood_modifier.dart';
import 'package:mood_tracker/screens/home_screen.dart';
import 'package:mood_tracker/utils/message_util.dart';

class PostScreen extends ConsumerStatefulWidget {
  static const routePath = '/post';

  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  static const List<String> moods = ['😊', '🥰', '😐', '😫', '😢', '😡'];

  final TextEditingController _textController = TextEditingController();
  String _selectedMood = moods.first;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MOOD TRACKER',
          style: GoogleFonts.oswald(
            textStyle: Theme.of(context).textTheme.titleLarge,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(onPressed: _onSendPressed, icon: const Icon(Icons.send)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: moods
                  .map(
                    (mood) => ChoiceChip(
                      label: Text(mood),
                      selected: _selectedMood == mood,
                      onSelected: (value) => _onMoodSelected(mood),
                      side: BorderSide.none,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _textController,
              maxLines: 3,
              maxLength: 100,
              decoration: InputDecoration(
                hintText: 'How do you feel?',
                counterText: '${_textController.text.length}/100',
                counterStyle: const TextStyle(fontSize: 12),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }

  void _onMoodSelected(String mood) {
    setState(() {
      _selectedMood = mood;
    });
  }

  void _onSendPressed() {
    if (_textController.text.isEmpty) {
      MessageUtil.showInfoMessage(
        context: context,
        message: 'Please enter your mood',
      );
      return;
    }

    ref
        .read(moodModifier.notifier)
        .saveMood(
          mood: _selectedMood,
          content: _textController.text,
          onSuccess: () {
            context.go(HomeScreen.routePath);
          },
          onError: (error) {
            MessageUtil.showErrorMessage(
              context: context,
              message: "Sorry Sorry Sorry... Naega Naega...",
              error: error,
            );
          },
        );
  }
}
