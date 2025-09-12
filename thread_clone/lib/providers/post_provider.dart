import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/models/thread_model.dart';
import 'package:thread_clone/providers/user_provider.dart';
import 'package:thread_clone/repos/thread_repository.dart';

class PostViewModel extends AsyncNotifier<void> {
  late final ThreadRepository _threadRepository;

  @override
  FutureOr<void> build() {
    _threadRepository = ref.read(threadRepositoryProvider);
  }

  Future<void> submitPost(
    String content,
    List<File> images,
    Function() onSuccess,
    Function(String) onError,
  ) async {
    state = const AsyncValue.loading();
    final imageUploadTasks = await _threadRepository.uploadThreadImages(
      images,
      ref.read(userProvider).value?.email ?? '',
    );
    final imageUrls = await Future.wait(
      imageUploadTasks.map(
        (image) async => await image.snapshot.ref.getDownloadURL(),
      ),
    );
    state = await AsyncValue.guard(
      () => _threadRepository.saveThread(
        ThreadModel(
          email: ref.read(userProvider).value?.email ?? '',
          content: content,
          imageUrls: imageUrls,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          searchFields: content.split(' ').map((word) => word.toLowerCase()).toList(),
        ),
      ),
    );
    state.whenOrNull(
      data: (data) {
        onSuccess();
      },
      error: (error, stackTrace) {
        onError(error.toString());
      },
    );
  }
}

final postProvider = AsyncNotifierProvider<PostViewModel, void>(
  () => PostViewModel(),
);
