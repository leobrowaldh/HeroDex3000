import 'package:herodex/data/models/hero_api_model.dart';
import 'package:herodex/data/models/hero_db_model.dart';
import 'package:herodex/domain/entities/hero.dart';

class HeroMapper {
  // -------------------------
  // API → Domain
  // -------------------------
  static Hero fromApi(HeroApiModel api) {
    return Hero(
      id: api.localId,
      externalId: api.id,
      name: api.name,
      fullName: api.fullName,
      publisher: api.publisher,
      alignment: _mapAlignment(api.alignment),
      imageUrl: api.imageUrl,
      stats: HeroStats(
        strength: _parseInt(api.strength),
        intelligence: _parseInt(api.intelligence),
        speed: _parseInt(api.speed),
        durability: _parseInt(api.durability),
        power: _parseInt(api.power),
        combat: _parseInt(api.combat),
      ),
      lastKnownBattleLocation: null,
      createdAt: DateTime.now(),
      updatedAt: null,
      isFavorite: false,
      isFromApi: true,
    );
  }

  // -------------------------
  // API → DB
  // -------------------------
  static HeroDbModel apiToDb(HeroApiModel api) {
    return HeroDbModel(
      id: api.localId,
      externalId: api.id,
      name: api.name,
      fullName: api.fullName,
      publisher: api.publisher,
      alignment: api.alignment ?? "unknown",
      imageUrl: api.imageUrl,
      strength: _parseInt(api.strength),
      intelligence: _parseInt(api.intelligence),
      speed: _parseInt(api.speed),
      durability: _parseInt(api.durability),
      power: _parseInt(api.power),
      combat: _parseInt(api.combat),
      aliases: api.aliases,
      race: api.race,
      gender: api.gender,
      placeOfBirth: api.placeOfBirth,
      firstAppearance: api.firstAppearance,
      occupation: api.occupation,
      base: api.base,
      groupAffiliation: api.groupAffiliation,
      relatives: api.relatives,
      latitude: null,
      longitude: null,
      locationDescription: null,
      createdAt: DateTime.now(),
      updatedAt: null,
      isFavorite: false,
      isFromApi: true,
    );
  }

  // -------------------------
  // DB → Domain
  // -------------------------
  static Hero fromDb(HeroDbModel db) {
    return Hero(
      id: db.id,
      externalId: db.externalId,
      name: db.name,
      fullName: db.fullName,
      publisher: db.publisher,
      alignment: _mapAlignment(db.alignment),
      imageUrl: db.imageUrl,
      stats: HeroStats(
        strength: db.strength,
        intelligence: db.intelligence,
        speed: db.speed,
        durability: db.durability,
        power: db.power,
        combat: db.combat,
      ),
      lastKnownBattleLocation: db.latitude != null
          ? HeroLocation(
              latitude: db.latitude,
              longitude: db.longitude,
              description: db.locationDescription,
            )
          : null,
      createdAt: db.createdAt,
      updatedAt: db.updatedAt,
      isFavorite: db.isFavorite,
      isFromApi: db.isFromApi,
    );
  }

  // -------------------------
  // Domain → DB (for updates)
  // -------------------------
  static HeroDbModel toDb(Hero hero, HeroDbModel existing) {
    return HeroDbModel(
      id: hero.id,
      externalId: hero.externalId,
      name: hero.name,
      fullName: hero.fullName,
      publisher: hero.publisher,
      alignment: hero.alignment.name,
      imageUrl: hero.imageUrl,
      strength: hero.stats.strength,
      intelligence: hero.stats.intelligence,
      speed: hero.stats.speed,
      durability: hero.stats.durability,
      power: hero.stats.power,
      combat: hero.stats.combat,
      aliases: existing.aliases,
      race: existing.race,
      gender: existing.gender,
      placeOfBirth: existing.placeOfBirth,
      firstAppearance: existing.firstAppearance,
      occupation: existing.occupation,
      base: existing.base,
      groupAffiliation: existing.groupAffiliation,
      relatives: existing.relatives,
      latitude: hero.lastKnownBattleLocation?.latitude,
      longitude: hero.lastKnownBattleLocation?.longitude,
      locationDescription: hero.lastKnownBattleLocation?.description,
      createdAt: existing.createdAt,
      updatedAt: DateTime.now(),
      isFavorite: hero.isFavorite,
      isFromApi: hero.isFromApi,
    );
  }

  // -------------------------
  // Helpers
  // -------------------------
  static int _parseInt(String? value) {
    return int.tryParse(value ?? "") ?? 0;
  }

  static HeroAlignment _mapAlignment(String? value) {
    switch (value) {
      case "good":
        return HeroAlignment.hero;
      case "bad":
        return HeroAlignment.villain;
      case "neutral":
        return HeroAlignment.neutral;
      default:
        return HeroAlignment.unknown;
    }
  }
}
