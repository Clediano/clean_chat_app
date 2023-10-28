import 'package:flutter/material.dart';

class LoadingColumn extends StatelessWidget {
  final String message;

  const LoadingColumn({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 18),
          Text('$message...')
        ],
      ),
    );
  }
}
