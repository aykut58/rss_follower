import 'package:flutter/material.dart';
class RssLoading extends StatelessWidget {
  const RssLoading({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          )
        ],
      ),
    );
  }
}