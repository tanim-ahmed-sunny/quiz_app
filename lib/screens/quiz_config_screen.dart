import 'package:flutter/material.dart';

import '../models/category.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/illustrations.dart';
import 'quiz_screen.dart';

class QuizConfigScreen extends StatefulWidget {
  final Category category;
  const QuizConfigScreen({super.key, required this.category});

  @override
  State<QuizConfigScreen> createState() => _QuizConfigScreenState();
}

class _QuizConfigScreenState extends State<QuizConfigScreen> {
  double _amount = 25; // 1–50 (OpenTDB max per request)
  String _difficulty = 'any';
  String _type = 'any';

  static const _difficulties = {
    'any': 'Any Difficulty',
    'easy': 'Easy',
    'medium': 'Medium',
    'hard': 'Hard',
  };
  static const _types = {
    'any': 'Any Type',
    'multiple': 'Multiple Choice',
    'boolean': 'True / False',
  };

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 8),
        child: Text(text, style: outfit(16, weight: FontWeight.w700)),
      );

  Widget _dropdown(
      String value, Map<String, String> items, ValueChanged<String> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.line),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          style: outfit(14, weight: FontWeight.w500),
          items: items.entries
              .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
              .toList(),
          onChanged: (v) {
            if (v != null) setState(() => onChanged(v));
          },
        ),
      ),
    );
  }

  void _start() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => QuizScreen(
          category: widget.category,
          amount: _amount.round(),
          difficulty: _difficulty == 'any' ? null : _difficulty,
          type: _type == 'any' ? null : _type,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          children: [
            const Center(child: ConfigIllustration()),
            const SizedBox(height: 12),
            Center(
              child: Text('Quizzical',
                  style: outfit(32,
                      weight: FontWeight.w800, color: AppColors.ink)),
            ),
            Center(
              child: Text('Configuration',
                  style: outfit(15, weight: FontWeight.w400)),
            ),
            Center(
              child: Text(widget.category.displayName,
                  style: outfit(15, weight: FontWeight.w400)),
            ),
            _label('Number of Questions'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select 1-50',
                    style: outfit(11,
                        weight: FontWeight.w400, color: AppColors.muted)),
                Text('${_amount.round()}',
                    style: outfit(12,
                        weight: FontWeight.w700, color: AppColors.slider)),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 5,
                activeTrackColor: AppColors.slider,
                inactiveTrackColor: AppColors.sliderTrack,
                thumbColor: AppColors.slider,
                overlayColor: AppColors.slider.withAlpha(30),
              ),
              child: Slider(
                min: 1,
                max: 50,
                divisions: 49,
                value: _amount,
                onChanged: (v) => setState(() => _amount = v),
              ),
            ),
            _label('Difficulty Level'),
            _dropdown(_difficulty, _difficulties, (v) => _difficulty = v),
            _label('Question Type'),
            _dropdown(_type, _types, (v) => _type = v),
            const SizedBox(height: 28),
            AppButton(
                label: 'START', kind: ButtonKind.outlined, onPressed: _start),
          ],
        ),
      ),
    );
  }
}
