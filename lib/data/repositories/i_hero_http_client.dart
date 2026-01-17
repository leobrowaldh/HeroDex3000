import 'package:herodex/data/models/http_response_model.dart';

abstract class IHeroHttpClient {
  Future<HttpResponseSearchModel> searchHeroes(String query);
}
