import 'package:flutter/material.dart';
import 'package:twitter_clone/features/settings/models/settings.dart';
import 'package:twitter_clone/features/settings/repos/settings_repository.dart';

class SettingsState extends ChangeNotifier {

  final SettingsRepository _repository;

  late final _model = Settings(darkMode: _repository.getDarkMode());

  SettingsState(this._repository);

  bool get dartMode => _model.darkMode;

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    _model.darkMode = value;
    notifyListeners();
  }
}