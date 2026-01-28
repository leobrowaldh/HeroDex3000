import 'package:herodex/data/models/hero_db_model.dart';

abstract class ILocalDb {
  Future<void> saveHero(HeroDbModel hero);
  Future<void> deleteHero(String localId);
  Future<List<HeroDbModel>> getAllHeroes();
  Future<HeroDbModel?> getHeroByLocalId(String localId);
}
