class ThreadModel {
  final String email;
  final String content;
  final List<String> imageUrls;
  final int createdAt;
  final List<String> searchFields;

  ThreadModel({
    required this.email,
    required this.content,
    required this.imageUrls,
    required this.createdAt,
    required this.searchFields,
  });

  factory ThreadModel.fromJson(Map<String, dynamic> json) {
    return ThreadModel(
      email: json['email'],
      content: json['content'],
      imageUrls: List<String>.from(json['imageUrls']),
      createdAt: json['createdAt'],
      searchFields: List<String>.from(json['searchFields']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'content': content,
      'imageUrls': imageUrls,
      'createdAt': createdAt,
      'searchFields': searchFields,
    };
  }
}