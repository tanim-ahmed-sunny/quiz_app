import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/question.dart';
import '../services/api_service.dart';
import '../theme.dart';
import '../widgets/answer_option.dart';
import '../widgets/common.dart';
import '../widgets/progress_indicator.dart';
import 'results_screen.dart';

class QuizScreen extends StatefulWidget {
  final Category category;
  final int amount;
  final String? difficulty;
  final String? type;

  const QuizScreen({
    super.key,
    required this.category,
    required this.amount,
    this.difficulty,
    this.type,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  bool _loading = true;
  String? _error;

  int _index = 0;
  int _score = 0;
  String? _selected;

  @override
  void initState() {
    super.initState();
    _load(); // fetch once; paginate locally afterwards
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final q = await ApiService.fetchQuestions(
        amount: widget.amount,
        categoryId: widget.category.id,
        difficulty: widget.difficulty,
        type: widget.type,
      );
      if (!mounted) return;
      setState(() {
        _questions = q;
        _index = 0;
        _score = 0;
        _selected = null;
        _loading = false;
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _loading = false;
      });
    }
  }

  void _select(String answer) {
    if (_selected != null) return; // locked after the first tap
    setState(() {
      _selected = answer;
      if (answer == _questions[_index].correctAnswer) _score++;
    });
  }

  void _next() {
    if (_index == _questions.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              ResultsScreen(score: _score, total: _questions.length),
        ),
      );
    } else {
      setState(() {
        _index++;
        _selected = null;
      });
    }
  }

  Future<void> _exit() async {
    final quit = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Exit quiz?'),
        content: const Text('Your progress will be lost.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(c, false),
              child: const Text('Keep playing')),
          TextButton(
              onPressed: () => Navigator.pop(c, true),
              child: const Text('Exit')),
        ],
      ),
    );
    if (quit == true && mounted) {
      Navigator.popUntil(context, (r) => r.settings.name == 'categories');
    }
  }

  AnswerState _stateFor(Question q, String option) {
    if (_selected != option) return AnswerState.idle;
    return option == q.correctAnswer ? AnswerState.correct : AnswerState.wrong;
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_loading) {
      body = const LoadingView(message: 'Loading questions…');
    } else if (_error != null) {
      body = ErrorView(
        message: _error!,
        onRetry: _load,
        secondaryActionLabel: 'CHANGE SETTINGS',
        onSecondaryAction: () => Navigator.pop(context),
      );
    } else {
      final q = _questions[_index];
      final isLast = _index == _questions.length - 1;
      body = Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        child: Column(
          children: [
            SizedBox(
              height: 36,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text('${_index + 1}/${_questions.length}',
                      style: outfit(16, weight: FontWeight.w700)),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: _exit,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('EXIT',
                              style: outfit(13, weight: FontWeight.w700)),
                          const SizedBox(width: 4),
                          const Icon(Icons.logout_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            QuizProgress(current: _index + 1, total: _questions.length),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 130),
                    padding: const EdgeInsets.all(24),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(30),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Text(q.question, style: baloo(15, height: 1.6)),
                  ),
                  const SizedBox(height: 20),
                  for (final option in q.allAnswers)
                    AnswerOption(
                      text: option,
                      state: _stateFor(q, option),
                      onTap: () => _select(option),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            AppButton(
              label: isLast ? 'Finish' : 'Next',
              kind: ButtonKind.dark,
              onPressed: _selected == null ? null : _next,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.quizBg,
      body: SafeArea(child: body),
    );
  }
}
