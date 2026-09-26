import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/illustrations.dart';

class ResultsScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultsScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    final percent = total == 0 ? 0 : (score / total * 100).round();
    final passed = percent >= 50;

    final boxColor = passed ? AppColors.passBox : AppColors.failBox;
    final haloColor = passed ? AppColors.passHalo : AppColors.failHalo;
    final percentColor = passed ? AppColors.ink : Colors.white;

    // Back is disabled: "Play Again" is the way out.
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            child: Column(
              children: [
                const Spacer(),
                if (passed)
                  const Text('🎉', style: TextStyle(fontSize: 130))
                else
                  const ConfigIllustration(),
                const SizedBox(height: 24),
                Text(passed ? 'Congratulations' : 'Keep Trying!',
                    style: outfit(30, weight: FontWeight.w700, color: AppColors.ink)),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: haloColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Container(
                    width: 190,
                    height: 62,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: boxColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text('$percent%',
                        style: outfit(30, weight: FontWeight.w800, color: percentColor)),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    passed
                        ? 'You\'ve got a great foundation. Ready to try a different category?'
                        : 'Don\'t give up! Practice makes perfect. Try again to improve your score.',
                    textAlign: TextAlign.center,
                    style: baloo(13, height: 1.8),
                  ),
                ),
                const Spacer(flex: 2),
                AppButton(
                  label: 'PLAY AGAIN',
                  // Unwind to Categories and drop everything above it.
                  onPressed: () => Navigator.popUntil(
                      context, (r) => r.settings.name == 'categories'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
