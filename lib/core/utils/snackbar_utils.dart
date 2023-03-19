import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    bool isError = false,
    void Function()? onPressed,
  }) {
    ///
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ///
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
        ),
      ),
      duration: const Duration(
        milliseconds: 2000,
      ),
      backgroundColor: isError
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.onSurfaceVariant,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
    );

    ///
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
