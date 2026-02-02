import 'package:herodex/domain/entities/hero_entity.dart';

abstract class IHeroRepository {
  Future<List<HeroEntity>> searchHeroes(String query);
  Future<List<HeroEntity>> getSavedHeroes();
  Future<void> saveHero(HeroEntity hero);
  Future<void> deleteHero(String id);
}
