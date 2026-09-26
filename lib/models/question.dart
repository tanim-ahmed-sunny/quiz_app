import 'package:html_unescape/html_unescape.dart';

final _unescape = HtmlUnescape();

class Question {
  final String category;
  final String type; // "multiple" | "boolean"
  final String difficulty; // "easy" | "medium" | "hard"
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  /// incorrect + correct, shuffled once and cached so the order never
  /// changes when the widget rebuilds.
  final List<String> allAnswers;

  const Question({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
    required this.allAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    final correct = _unescape.convert(json['correct_answer'] as String);
    final incorrect = (json['incorrect_answers'] as List)
        .map((e) => _unescape.convert(e as String))
        .toList();

    final all = [...incorrect, correct];
    if (type == 'boolean') {
      // Keep True / False in a predictable order.
      all.sort((a, b) => b.compareTo(a));
    } else {
      all.shuffle();
    }

    return Question(
      category: _unescape.convert(json['category'] as String),
      type: type,
      difficulty: json['difficulty'] as String,
      question: _unescape.convert(json['question'] as String),
      correctAnswer: correct,
      incorrectAnswers: incorrect,
      allAnswers: all,
    );
  }
}
