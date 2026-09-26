import 'package:flutter/material.dart';
import '../models/category.dart';
import '../services/api_service.dart';
import '../theme.dart';
import '../widgets/category_card.dart';
import '../widgets/common.dart';
import 'quiz_config_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  // Card colours in prototype order: blue, mint, yellow, lilac, pink, peach.
  static const _cardColors = [
    Color(0xFFC9D0FA),
    Color(0xFFCBF7D6),
    Color(0xFFFBFBC6),
    Color(0xFFEFC9FA),
    Color(0xFFFBC8C8),
    Color(0xFFFBE3C8),
  ];
  // Shown first, in the same order as the prototype.
  static const _featured = [9, 10, 23, 17, 25, 28];

  List<Category> _categories = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await ApiService.fetchCategories();
      if (!mounted) return;
      final featured = [
        for (final id in _featured) ...data.where((c) => c.id == id)
      ];
      final rest = data.where((c) => !_featured.contains(c.id));
      setState(() {
        _categories = [...featured, ...rest];
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

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_loading) {
      body = const LoadingView(message: 'Loading categories…');
    } else if (_error != null) {
      body = ErrorView(message: _error!, onRetry: _load);
    } else {
      body = GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        itemCount: _categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.88,
        ),
        itemBuilder: (_, i) {
          final c = _categories[i];
          return CategoryCard(
            category: c,
            color: _cardColors[i % _cardColors.length],
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => QuizConfigScreen(category: c)),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quizzical',
                      style: outfit(34, weight: FontWeight.w800, color: AppColors.ink)),
                  const SizedBox(height: 4),
                  Text('choose a category to focus on:', style: lora(15)),
                ],
              ),
            ),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
