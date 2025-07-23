import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../errors/failure.dart';

class ErrorScreen extends StatelessWidget {
  final Failure failure;

  const ErrorScreen({super.key, required this.failure});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Lottie.asset(
          'assets/lottie/error404.json',
        ),
        const SizedBox(height: 40),
        Text(
          'Error: ${failure.error}',
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(
            color: Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
