import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/illustrations.dart';
import 'categories_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            children: [
              const Spacer(),
              const HomeIllustration(),
              const SizedBox(height: 24),
              Text('Quizzical',
                  style: outfit(38, weight: FontWeight.w700, color: AppColors.ink)),
              const SizedBox(height: 4),
              Text(kStudentName,
                  style: outfit(26, weight: FontWeight.w600, color: AppColors.ink)),
              const Spacer(flex: 2),
              AppButton(
                label: 'GET STARTED',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: const RouteSettings(name: 'categories'),
                    builder: (_) => const CategoriesScreen(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
