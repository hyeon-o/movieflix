import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

class MessageUtil {
  static void showInfoMessage({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static void showErrorMessage({
    required BuildContext context,
    required String message,
    Object? error,
  }) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
    if (kDebugMode && error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}
