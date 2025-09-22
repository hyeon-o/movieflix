import 'dart:developer' as developer show log;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_tracker/providers/auth_modifier.dart';
import 'package:mood_tracker/providers/home_mood_list_provider.dart';
import 'package:mood_tracker/utils/message_util.dart';
import 'package:mood_tracker/widgets/mood_widget.dart';

class HomeScreen extends ConsumerWidget {
  static const routePath = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    developer.log('HomeScreen build...');

    ref.listen(homeMoodListProvider, (previous, next) {
      if (next.hasError) {
        MessageUtil.showErrorMessage(
          context: context,
          message: "Sorry Sorry Sorry... Naega Naega...",
          error: next.error!,
        );
      }
    });

    final moods = ref.watch(homeMoodListProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(homeMoodListProvider.notifier).refresh();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Text(
                'MOOD TRACKER',
                style: GoogleFonts.oswald(
                  textStyle: Theme.of(context).textTheme.titleLarge,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (moods.hasValue)
              SliverList.separated(
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: moods.value!.length,
                itemBuilder: (_, index) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: MoodWidget(
                    mood: moods.value![index],
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
        onPressed: () {
          ref.read(authModifier.notifier).deauthenticate();
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
