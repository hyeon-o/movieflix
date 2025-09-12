import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/models/thread_model.dart';

class ThreadRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getThreads({
    required int limit,
    int? lastCreatedAt,
    String? keyword,
  }) async {
    var query = _db
        .collection('threads')
        .orderBy('createdAt', descending: true)
        .limit(limit);
    if (keyword != null) {
      query = query.where('searchFields', arrayContains: keyword.toLowerCase());
    }
    if (lastCreatedAt != null) {
      query = query.startAfter([lastCreatedAt]);
    }
    return await query.get();
  }

  Future<List<UploadTask>> uploadThreadImages(
    List<File> images,
    String email,
  ) async {
    final tasks = images
        .map(
          (image) => _storage
              .ref()
              .child('images/$email/${DateTime.now().millisecondsSinceEpoch}')
              .putFile(image),
        )
        .toList();
    await Future.wait(tasks);
    return tasks;
  }

  Future<void> saveThread(ThreadModel thread) async {
    await _db.collection('threads').add(thread.toJson());
  }
}

final threadRepositoryProvider = Provider<ThreadRepository>((ref) {
  return ThreadRepository();
});
