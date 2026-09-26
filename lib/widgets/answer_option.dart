import 'package:flutter/material.dart';
import '../theme.dart';

enum AnswerState { idle, correct, wrong }

class AnswerOption extends StatelessWidget {
  final String text;
  final AnswerState state;
  final VoidCallback? onTap;
  const AnswerOption(
      {super.key, required this.text, required this.state, this.onTap});

  @override
  Widget build(BuildContext context) {
    Color fill = Colors.white;
    Color textColor = AppColors.text;
    Widget icon = const Icon(Icons.radio_button_unchecked,
        size: 22, color: AppColors.text);

    if (state == AnswerState.correct) {
      fill = AppColors.correctFill;
      textColor = AppColors.deepTeal;
      icon = const Icon(Icons.check_circle,
          size: 22, color: AppColors.deepTeal);
    } else if (state == AnswerState.wrong) {
      fill = AppColors.wrongFill;
      icon = const Icon(Icons.cancel, size: 22, color: AppColors.wrongIcon);
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: fill,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              children: [
                Expanded(
                    child: Text(text, style: baloo(15, color: textColor))),
                icon,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
