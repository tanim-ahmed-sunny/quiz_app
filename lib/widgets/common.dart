import 'package:flutter/material.dart';
import '../theme.dart';

enum ButtonKind { teal, dark, outlined }

/// One button widget, three looks taken from the prototype:
/// teal (Get Started / Play Again), dark (Next), outlined (Start).
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonKind kind;
  const AppButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.kind = ButtonKind.teal});

  @override
  Widget build(BuildContext context) {
    final shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

    if (kind == ButtonKind.outlined) {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: AppColors.deepTeal, width: 1.5),
            shape: shape,
          ),
          child: Text(label,
              style: outfit(18, weight: FontWeight.w700, color: AppColors.deepTeal)),
        ),
      );
    }

    final bg = kind == ButtonKind.dark ? AppColors.deepTeal : AppColors.teal;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: bg,
          disabledBackgroundColor: bg.withAlpha(90),
          shape: shape,
        ),
        child: Text(label,
            style: outfit(17, weight: FontWeight.w700, color: Colors.white)),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  final String message;
  const LoadingView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.teal),
          const SizedBox(height: 16),
          Text(message, style: outfit(15, color: AppColors.muted)),
        ],
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const ErrorView({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_rounded,
                size: 48, color: AppColors.muted),
            const SizedBox(height: 16),
            Text(message,
                textAlign: TextAlign.center,
                style: outfit(16, weight: FontWeight.w500)),
            const SizedBox(height: 24),
            SizedBox(
                width: 180,
                child: AppButton(label: 'TRY AGAIN', onPressed: onRetry)),
          ],
        ),
      ),
    );
  }
}
