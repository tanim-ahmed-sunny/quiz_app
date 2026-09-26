import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:quiz_app/services/api_service.dart';
import 'package:quiz_app/widgets/common.dart';

void main() {
  group('ApiService question requests', () {
    test('does not silently reduce the requested question count', () async {
      final requestedAmounts = <String>[];
      final request = http.runWithClient(
        () => ApiService.fetchQuestions(amount: 50, categoryId: 9),
        () => MockClient((request) async {
          requestedAmounts.add(request.url.queryParameters['amount']!);
          return http.Response(
            jsonEncode({'response_code': 1, 'results': []}),
            200,
          );
        }),
      );

      await expectLater(
        request,
        throwsA(
          isA<ApiException>().having(
            (error) => error.message,
            'message',
            contains('Not enough questions'),
          ),
        ),
      );
      expect(requestedAmounts, ['50']);
    });
  });

  testWidgets('error view offers its configured secondary action',
      (tester) async {
    var settingsChanged = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ErrorView(
            message: 'Not enough questions.',
            onRetry: () {},
            secondaryActionLabel: 'CHANGE SETTINGS',
            onSecondaryAction: () => settingsChanged = true,
          ),
        ),
      ),
    );

    final settingsLabel = find.text('CHANGE SETTINGS');
    expect(settingsLabel, findsOneWidget);

    final labelRect = tester.getRect(settingsLabel);
    final buttonRect = tester.getRect(find.byType(OutlinedButton));
    expect(labelRect.center.dx, closeTo(buttonRect.center.dx, 1));

    await tester.tap(settingsLabel);
    expect(settingsChanged, isTrue);
  });
}
