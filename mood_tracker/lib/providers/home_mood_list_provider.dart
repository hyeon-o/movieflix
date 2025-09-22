import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/models/mood_model.dart';
import 'package:mood_tracker/repos/auth_repository.dart';
import 'package:mood_tracker/repos/mood_repository.dart';

class HomeMoodListViewModel extends AsyncNotifier<List<MoodModel>> {
  static const int _limit = 10;

  final List<MoodModel> _moods = [];

  @override
  Future<List<MoodModel>> build() async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      throw Exception('User not found');
    }

    int? lastCreatedAt = _moods.isNotEmpty ? _moods.last.createdAt : null;
    final newMoods = await ref
        .read(moodRepositoryProvider)
        .getMoods(
          email: user.email!,
          limit: _limit,
          lastCreatedAt: lastCreatedAt,
        );
    _moods.addAll(newMoods);

    return _moods;
  }

  Future<void> refresh() async {
    _moods.clear();
    ref.invalidateSelf();
  }
}

final homeMoodListProvider =
    AsyncNotifierProvider<HomeMoodListViewModel, List<MoodModel>>(
      () => HomeMoodListViewModel(),
    );
