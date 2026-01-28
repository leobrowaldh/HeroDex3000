import 'package:herodex/domain/entities/hero.dart';

abstract class IHeroRepository {
  Future<List<Hero>> searchHeroes(String query);
  Future<List<Hero>> getSavedHeroes();
  Future<void> saveHero(Hero hero);
  Future<void> deleteHero(String id);
}
