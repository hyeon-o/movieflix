import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_tracker/models/mood_model.dart';
import 'package:mood_tracker/providers/home_mood_list_provider.dart';
import 'package:mood_tracker/providers/mood_modifier.dart';
import 'package:mood_tracker/utils/message_util.dart';
import 'package:mood_tracker/utils/text_util.dart';

class MoodWidget extends ConsumerWidget {
  final MoodModel mood;

  const MoodWidget({super.key, required this.mood});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete'),
            content: const Text('Are you sure you want to delete this mood?'),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  ref
                      .read(moodModifier.notifier)
                      .deleteMood(
                        id: mood.id!,
                        onSuccess: () {
                          context.pop();
                          ref.read(homeMoodListProvider.notifier).refresh();
                        },
                        onError: (error) {
                          MessageUtil.showErrorMessage(
                            context: context,
                            message: "Sorry Sorry Sorry... Naega Naega...",
                            error: error,
                          );
                        },
                      );
                },
                child: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            ],
          ),
        );
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(mood.mood, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Text(
                    mood.content,
                    style: TextStyle(color: Theme.of(context).hintColor),
                    softWrap: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              TextUtil.formatCreatedAtTime(mood.createdAt),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
