import 'package:flutter/material.dart';
import '../theme.dart';

Widget _dot(double size, Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle));

/// Home screen artwork: big yellow "?", kid face, small pink/green marks.
class HomeIllustration extends StatelessWidget {
  const HomeIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF7B3FE4);
    return SizedBox(
      width: 280,
      height: 250,
      child: Stack(
        children: [
          Positioned(
            left: 60,
            top: -10,
            child: Transform.rotate(
              angle: 0.08,
              child: Text('?',
                  style: outfit(240, weight: FontWeight.w900, color: const Color(0xFFFFB627))
                      .copyWith(height: 1)),
            ),
          ),
          // yellow ball
          Positioned(left: 44, bottom: 22, child: _dot(46, const Color(0xFFFFC93C))),
          // red circle with green "="
          Positioned(
            left: 0,
            top: 62,
            child: Transform.rotate(
              angle: -0.3,
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                    color: Color(0xFFF0616D), shape: BoxShape.circle),
                child: const Icon(Icons.drag_handle_rounded,
                    size: 38, color: Color(0xFF5CCB6C)),
              ),
            ),
          ),
          // pink "?"
          Positioned(
            right: 8,
            top: 60,
            child: Transform.rotate(
              angle: 0.15,
              child: Text('?',
                  style: outfit(90, weight: FontWeight.w900, color: const Color(0xFFF0616D))
                      .copyWith(height: 1)),
            ),
          ),
          // small green mark
          Positioned(
            right: 22,
            bottom: 16,
            child: Transform.rotate(
              angle: 0.4,
              child: Text('?',
                  style: outfit(56, weight: FontWeight.w900, color: const Color(0xFF5CCB6C))
                      .copyWith(height: 1)),
            ),
          ),
          // face
          Positioned(
            left: 84,
            top: 92,
            child: SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                children: [
                  Positioned(top: 0, left: 8, child: _dot(104, purple)),
                  Positioned(top: 16, left: 0, child: _dot(38, purple)),
                  Positioned(top: 10, right: 0, child: _dot(38, purple)),
                  Positioned(
                      bottom: 0, left: 14, child: _dot(92, const Color(0xFFFFDCC8))),
                  Positioned(
                      left: 44,
                      top: 66,
                      child: Container(
                          width: 7,
                          height: 10,
                          decoration: BoxDecoration(
                              color: const Color(0xFF3B2A6B),
                              borderRadius: BorderRadius.circular(5)))),
                  Positioned(
                      left: 72,
                      top: 66,
                      child: Container(
                          width: 7,
                          height: 10,
                          decoration: BoxDecoration(
                              color: const Color(0xFF3B2A6B),
                              borderRadius: BorderRadius.circular(5)))),
                  Positioned(
                      left: 28,
                      top: 82,
                      child: _dot(16, const Color(0xFFF7A1B5).withAlpha(140))),
                  Positioned(
                      left: 80,
                      top: 82,
                      child: _dot(16, const Color(0xFFF7A1B5).withAlpha(140))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Gear + toggle artwork (Configuration screen and the "Keep Trying!" result).
class ConfigIllustration extends StatelessWidget {
  const ConfigIllustration({super.key});

  Widget _toggle() => Container(
        width: 96,
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xFFF0503C),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: _dot(22, const Color(0xFFF7A1C0)),
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 150,
      child: Stack(
        children: [
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              width: 140,
              height: 124,
              decoration: BoxDecoration(
                  color: const Color(0xFFCFE6F5),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _toggle(),
                  const SizedBox(height: 14),
                  _toggle(),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFD86B),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.settings,
                  size: 48, color: Color(0xFFB9862A)),
            ),
          ),
          const Positioned(
            right: 0,
            bottom: 0,
            child: Text('👈🏾', style: TextStyle(fontSize: 62)),
          ),
        ],
      ),
    );
  }
}
