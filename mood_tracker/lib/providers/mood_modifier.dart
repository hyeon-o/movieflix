import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/models/mood_model.dart';
import 'package:mood_tracker/repos/auth_repository.dart';
import 'package:mood_tracker/repos/mood_repository.dart';

class MoodModifier extends AsyncNotifier<void> {
  late final MoodRepository _moodPostRepository;

  @override
  Future<void> build() async {
    _moodPostRepository = ref.read(moodRepositoryProvider);
  }

  Future<void> saveMood({
    required String mood,
    required String content,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    state = await AsyncValue.guard(() {
      final user = ref.read(authRepositoryProvider).currentUser;
      if (user == null) {
        throw Exception('User not found');
      }

      return _moodPostRepository.saveMood(
        MoodModel(
          email: user.email!,
          mood: mood,
          content: content,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    });

    state.whenOrNull(
      data: (data) => onSuccess(),
      error: (error, stackTrace) => onError(error.toString()),
    );
  }

  Future<void> deleteMood({
    required String id,
    required Function() onSuccess,
    required Function(String) onError,
  }) async {
    state = await AsyncValue.guard(() {
      return _moodPostRepository.deleteMood(id);
    });

    state.whenOrNull(
      data: (data) => onSuccess(),
      error: (error, stackTrace) => onError(error.toString()),
    );
  }
}

final moodModifier = AsyncNotifierProvider<MoodModifier, void>(
  () => MoodModifier(),
);
