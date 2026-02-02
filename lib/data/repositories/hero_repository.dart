import 'package:uuid/uuid.dart';

import 'package:herodex/domain/entities/hero_entity.dart';
import 'package:herodex/domain/repositories/i_hero_repository.dart';

import 'package:herodex/data/datasource/i_hero_http_client.dart';
import 'package:herodex/data/datasource/i_local_db.dart';
import 'package:herodex/data/models/hero_api_model.dart';
import 'package:herodex/data/models/hero_db_model.dart';
import 'package:herodex/data/mappers/hero_mapper.dart';

class HeroRepository implements IHeroRepository {
  final IHeroHttpClient _httpClient;
  final ILocalDb _localDb;

  // Cache of API heroes keyed by externalId (API id)
  final Map<String, HeroApiModel> _apiCache = {};

  HeroRepository({
    required IHeroHttpClient httpClient,
    required ILocalDb localDb,
  }) : _httpClient = httpClient,
       _localDb = localDb;

  @override
  Future<List<HeroEntity>> searchHeroes(String query) async {
    // 1. Fetch from API
    final response = await _httpClient.searchHeroes(query);
    final List<HeroApiModel> apiResults = response.results;

    // 2. Fetch saved heroes from local DB
    final List<HeroDbModel> savedDbHeroes = await _localDb.getAllHeroes();

    // 3. Map saved heroes by externalId for quick lookup
    final Map<String?, HeroDbModel> savedByExternalId = {
      for (final dbHero in savedDbHeroes) dbHero.externalId: dbHero,
    };

    // 4. Refresh API cache
    _apiCache.clear();
    for (final apiHero in apiResults) {
      if (apiHero.id != null) {
        _apiCache[apiHero.id!] = apiHero;
      }
    }

    // 5. Merge API + saved heroes into domain models
    final List<HeroEntity> domainResults = apiResults.map((apiHero) {
      final dbHero = savedByExternalId[apiHero.id];

      if (dbHero != null) {
        // Already saved → use DB → Domain (has localId)
        return HeroMapper.fromDb(dbHero);
      } else {
        // Not saved → use API → Domain (localId = null)
        return HeroMapper.fromApi(apiHero);
      }
    }).toList();

    return domainResults;
  }

  @override
  Future<List<HeroEntity>> getSavedHeroes() async {
    final savedDbHeroes = await _localDb.getAllHeroes();
    return savedDbHeroes.map(HeroMapper.fromDb).toList();
  }

  @override
  Future<void> saveHero(HeroEntity hero) async {
    final externalId = hero.externalId;
    if (externalId == null) {
      throw Exception('Cannot save hero without externalId');
    }

    final apiHero = _apiCache[externalId];
    if (apiHero == null) {
      throw Exception(
        'Hero not found in API cache for externalId: $externalId',
      );
    }

    final localId = const Uuid().v4();

    final dbModel = HeroMapper.apiToDb(apiHero, localId: localId);

    await _localDb.saveHero(dbModel);
  }

  @override
  Future<void> deleteHero(String id) async {
    await _localDb.deleteHero(id);
  }
}
