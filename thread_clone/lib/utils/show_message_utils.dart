import 'package:flutter/material.dart';

class ShowMessageUtils {
  static void showInfoMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
  }

  static void showErrorMessage(BuildContext context, Object error) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(error.toString())));
  }
}
