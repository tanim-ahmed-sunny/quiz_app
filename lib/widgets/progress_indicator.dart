import 'package:flutter/material.dart';
import '../theme.dart';

/// Thin blue bar under the "7/10" header.
class QuizProgress extends StatelessWidget {
  final int current; // 1-based
  final int total;
  const QuizProgress({super.key, required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: current / total,
        minHeight: 6,
        color: AppColors.progress,
        backgroundColor: AppColors.progressTrack,
      ),
    );
  }
}
