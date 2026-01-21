import 'hero_api_model.dart';

class HttpResponseSearchModel {
  final String response;
  final String resultsFor;
  final List<HeroApiModel> results;

  HttpResponseSearchModel({
    required this.response,
    required this.resultsFor,
    required this.results,
  });

  factory HttpResponseSearchModel.fromJson(Map<String, dynamic> json) {
    return HttpResponseSearchModel(
      response: json['response'] ?? '',
      resultsFor: json['results-for'] ?? '',
      results: (json['results'] != null && json['results'] is List)
          ? (json['results'] as List<dynamic>)
                .map((e) => HeroApiModel.fromJson(e))
                .toList()
          : [],
    );
  }
}
