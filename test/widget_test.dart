import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/services/api_service.dart';

void main() {
  group('ApiService question retry logic', () {
    test('reduces the request amount until it finds a valid size', () {
      final amounts = ApiService.questionAmountsToTry(25).toList();

      expect(amounts.first, 25);
      expect(amounts, contains(20));
      expect(amounts, contains(15));
      expect(amounts.last, 1);
    });
  });
}
