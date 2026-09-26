import 'package:flutter/material.dart';
import '../models/category.dart';
import '../theme.dart';

const Map<int, String> _emoji = {
  9: '🌍', 10: '📚', 11: '🎬', 12: '🎵', 13: '🎭', 14: '📺', 15: '🎮',
  16: '🎲', 17: '🔬', 18: '💻', 19: '🔢', 20: '🏺', 21: '⚽', 22: '🗺️',
  23: '📜', 24: '🏛️', 25: '🎨', 26: '🌟', 27: '🐾', 28: '🚗', 29: '🦸',
  30: '📱', 31: '🎌', 32: '🐭',
};

class CategoryCard extends StatelessWidget {
  final Category category;
  final Color color;
  final VoidCallback onTap;
  const CategoryCard(
      {super.key,
      required this.category,
      required this.color,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Text(_emoji[category.id] ?? '❓',
                      style: const TextStyle(fontSize: 56)),
                ),
              ),
              Text(category.displayName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: outfit(14, weight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}
