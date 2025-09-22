class TextUtil {
  static List<String> extractKeywords(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), ' ')
        .split(RegExp(r'\s+'))
        .where((word) => word.length > 1)
        .toSet()
        .toList();
  }

  static String formatCreatedAtTime(int createdAt) {
    return DateTime.fromMillisecondsSinceEpoch(
              createdAt,
            ).difference(DateTime.now()).abs().inMinutes <
            60
        ? '${DateTime.fromMillisecondsSinceEpoch(createdAt).difference(DateTime.now()).abs().inMinutes}분 전'
        : DateTime.fromMillisecondsSinceEpoch(
                createdAt,
              ).difference(DateTime.now()).abs().inHours <
              24
        ? '${DateTime.fromMillisecondsSinceEpoch(createdAt).difference(DateTime.now()).abs().inHours}시간 전'
        : '${DateTime.fromMillisecondsSinceEpoch(createdAt).difference(DateTime.now()).abs().inDays}일 전';
  }
}
