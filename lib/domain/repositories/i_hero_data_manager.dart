import 'package:herodex/domain/entities/hero.dart';

abstract class IHeroRepository {
  Future<void> saveHero(Hero hero);
  Future<List<Hero>> getHeroList();
  Future<List<Hero>> searchHero(String query);
  Future<void> deleteHero(String id);
  Future<Hero?> getHeroById(String id);
  Future<void> updateHero(Hero hero);
}
