import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/settings/models/settings.dart';
import 'package:twitter_clone/features/settings/repos/settings_repository.dart';

class SettingsViewModel extends AsyncNotifier<Settings> {
  late final SettingsRepository _repository;

  Future<void> setDarkMode(bool isDarkMode) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.setDarkMode(isDarkMode);
      return Settings(darkMode: isDarkMode);
    });
  }

  @override
  Future<Settings> build() async {
    _repository = ref.read(settingsRepositoryProvider);
    final isDarkMode = await _repository.getDarkMode();
    return Settings(
      darkMode: isDarkMode,
    );
  }
}

final settingsViewModelProvider =
    AsyncNotifierProvider<SettingsViewModel, Settings>(() => SettingsViewModel());