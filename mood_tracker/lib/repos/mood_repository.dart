import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_tracker/models/mood_model.dart';

class MoodRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<MoodModel>> getMoods({
    required String email,
    required int limit,
    int? lastCreatedAt,
    String? keyword,
  }) async {
    var query = _db
        .collection(MoodModel.collectionName)
        .where(MoodModel.emailField, isEqualTo: email)
        .orderBy(MoodModel.createdAtField, descending: true)
        .limit(limit);
    if (keyword != null) {
      query = query.where(
        MoodModel.schKwrdsField,
        arrayContains: keyword.trim().toLowerCase(),
      );
    }
    if (lastCreatedAt != null) {
      query = query.startAfter([lastCreatedAt]);
    }

    final snapshot = await query.get();
    return snapshot.docs.map((e) => MoodModel.fromJson(e.id, e.data())).toList();
  }

  Future<void> saveMood(MoodModel mood) async {
    await _db.collection(MoodModel.collectionName).add(mood.toJson());
  }

  Future<void> deleteMood(String id) async {
    await _db.collection(MoodModel.collectionName).doc(id).delete();
  }
}

final moodRepositoryProvider = Provider<MoodRepository>((ref) {
  return MoodRepository();
});
