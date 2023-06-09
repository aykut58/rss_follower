import 'package:flutter/material.dart';

class RssError extends StatelessWidget {
  const RssError({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 18.0,
        ),
      ),
    );
  }
}