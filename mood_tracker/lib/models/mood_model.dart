import 'package:mood_tracker/utils/text_util.dart';

class MoodModel {
  static const String collectionName = 'moods';

  static const String emailField = 'email';
  static const String moodField = 'mood';
  static const String contentField = 'content';
  static const String createdAtField = 'createdAt';
  static const String schKwrdsField = '_schKwrds';

  final String? id;
  final String email;
  final String mood;
  final String content;
  final int createdAt;
  final List<String> schKwrds;

  MoodModel({
    this.id,
    required this.email,
    required this.mood,
    required this.content,
    required this.createdAt,
    List<String>? schKwrds,
  }) : schKwrds = schKwrds ?? TextUtil.extractKeywords(content);

  factory MoodModel.fromJson(String id,Map<String, dynamic> json) {
    return MoodModel(
      id: id,
      email: json[emailField],
      mood: json[moodField],
      content: json[contentField],
      createdAt: json[createdAtField],
      schKwrds: List<String>.from(json[schKwrdsField]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      emailField: email,
      moodField: mood,
      contentField: content,
      createdAtField: createdAt,
      schKwrdsField: schKwrds,
    };
  }
}
