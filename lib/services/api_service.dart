import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/category.dart';
import '../models/question.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}

class ApiService {
  static const _host = 'opentdb.com';

  static Future<Map<String, dynamic>> _get(Uri uri) async {
    try {
      final res = await http.get(uri).timeout(const Duration(seconds: 15));
      if (res.statusCode == 429) {
        throw ApiException('Too many requests. Wait a few seconds and retry.');
      }
      if (res.statusCode != 200) {
        throw ApiException('Server error (${res.statusCode}). Try again.');
      }
      return jsonDecode(res.body) as Map<String, dynamic>;
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw ApiException(
          'The request timed out. Check your connection and retry.');
    } on FormatException {
      throw ApiException(
          'Got an unexpected response from the server. Try again.');
    } catch (_) {
      throw ApiException(
          'Can\'t reach the server. Check your internet connection and retry.');
    }
  }

  static Future<List<Category>> fetchCategories() async {
    final body = await _get(Uri.https(_host, '/api_category.php'));
    final list = body['trivia_categories'] as List?;
    if (list == null || list.isEmpty) {
      throw ApiException('No categories were returned. Try again.');
    }
    return list
        .map((j) => Category.fromJson(j as Map<String, dynamic>))
        .toList();
  }

  static Future<List<Question>> fetchQuestions({
    required int amount,
    required int categoryId,
    String? difficulty,
    String? type,
  }) async {
    final requestedAmount = amount.clamp(1, 50);
    final params = {
      'amount': '$requestedAmount',
      'category': '$categoryId',
      if (difficulty != null) 'difficulty': difficulty,
      if (type != null) 'type': type,
    };

    final body = await _get(Uri.https(_host, '/api.php', params));
    switch (body['response_code']) {
      case 0:
        final results = body['results'] as List? ?? [];
        if (results.length != requestedAmount) {
          throw ApiException(
              'The database returned only ${results.length} of $requestedAmount requested questions. Try fewer questions or broaden the difficulty/type filters.');
        }
        return results
            .map((j) => Question.fromJson(j as Map<String, dynamic>))
            .toList();
      case 1:
        throw ApiException(
            'Not enough questions are available for these settings. Try fewer questions or set difficulty/type to Any.');
      case 5:
        throw ApiException('Too many requests. Wait a few seconds and retry.');
      default:
        throw ApiException('Couldn\'t load questions. Try again.');
    }
  }
}
