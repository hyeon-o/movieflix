import 'dart:async';
import 'dart:developer' as developer show log;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/models/thread_model.dart';
import 'package:thread_clone/repos/thread_repository.dart';

class HomeThreadsProvider extends AsyncNotifier<List<ThreadModel>> {
  static const int _limit = 20;

  List<ThreadModel> _threads = [];
  String? _keyword;

  @override
  FutureOr<List<ThreadModel>> build() async {
    _threads = [];
    _keyword = null;
    _threads = await _fetch();
    return _threads;
  }

  Future<void> fetchNextThreads() async {
    state = await AsyncValue.guard(() async {
      final result = await _fetch();
      _threads.addAll(result);
      return _threads;
    });
  }

  Future<void> searchThreads(String keyword, bool isInitial, Function() onError) async {
    if (isInitial) _threads = [];
    _keyword = keyword;
    state = await AsyncValue.guard(() async {
      final result = await _fetch();
      _threads = result;
      return _threads;
    });

    if (state.hasError) {
      developer.log(state.error.toString());
      onError();
    }
  }

  Future<List<ThreadModel>> _fetch() async {
    final repository = ref.watch(threadRepositoryProvider);
    final result = await repository.getThreads(
      limit: _limit,
      lastCreatedAt: _threads.isNotEmpty ? _threads.last.createdAt : null,
      keyword: _keyword,
    );
    return result.docs.map((doc) => ThreadModel.fromJson(doc.data())).toList();
  }
}

final homeThreadsProvider =
    AsyncNotifierProvider<HomeThreadsProvider, List<ThreadModel>>(
      () => HomeThreadsProvider(),
    );
