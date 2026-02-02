import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'i_hero_http_client.dart';
import '../models/http_response_model.dart';

class HeroHttpClient implements IHeroHttpClient {
  // Optional singleton (works fine with getIt)
  static final HeroHttpClient _instance = HeroHttpClient._();
  factory HeroHttpClient() => _instance;
  HeroHttpClient._();

  final RetryClient _client = RetryClient(http.Client());

  Uri _buildUrl(String query) {
    final apiKey = dotenv.env['API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      log("❌ ERROR: API_KEY is missing in .env", level: 1000);
      throw Exception("API_KEY missing");
    }

    return Uri.https('superheroapi.com', '/api/$apiKey/search/$query');
  }

  @override
  Future<HttpResponseSearchModel> searchHeroes(String query) async {
    final url = _buildUrl(query);

    log("🔎 Calling API: $url");

    try {
      final response = await _client
          .get(url)
          .timeout(const Duration(seconds: 5));

      log("📡 Status: ${response.statusCode}");
      log("📦 Body: ${response.body}");

      if (response.statusCode == 200) {
        // The API sometimes returns text/html when the key is wrong
        final contentType = response.headers['content-type'] ?? '';

        if (!contentType.contains('application/json')) {
          log("❌ Unexpected content-type: $contentType", level: 1000);
          log("❌ Body: ${response.body}", level: 1000);
          throw Exception('Unexpected response format');
        }

        final json = jsonDecode(response.body);
        return HttpResponseSearchModel.fromJson(json);
      } else {
        log("❌ API error: ${response.statusCode}", level: 1000);
        log("❌ Body: ${response.body}", level: 1000);
        throw Exception('Failed to fetch heroes: ${response.statusCode}');
      }
    } on TimeoutException {
      log("⏳ Request timed out", level: 1000);
      throw Exception('Request timed out');
    } on http.ClientException catch (e) {
      log("🌐 Network error: ${e.message}", level: 1000);
      throw Exception('Network error: ${e.message}');
    }
  }

  void dispose() {
    _client.close();
  }
}
