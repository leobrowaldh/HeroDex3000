enum HeroAlignment { hero, villain, neutral, unknown }

class HeroStats {
  final int strength;
  final int intelligence;
  final int speed;
  final int durability;
  final int power;
  final int combat;

  const HeroStats({
    required this.strength,
    required this.intelligence,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  const HeroStats.empty()
    : strength = 0,
      intelligence = 0,
      speed = 0,
      durability = 0,
      power = 0,
      combat = 0;

  int get fightingPower => strength + combat + power;
}

class HeroLocation {
  final double? latitude;
  final double? longitude;
  final String? description;

  const HeroLocation({this.latitude, this.longitude, this.description});
}

class HeroEntity {
  final String? localId;
  final String? externalId;

  final String name;
  final String? fullName;
  final String? publisher;
  final HeroAlignment alignment;

  final String? imageUrl;

  final HeroStats stats;

  final HeroLocation? lastKnownBattleLocation;

  // Metadata
  final DateTime createdAt;
  final DateTime? updatedAt;

  const HeroEntity({
    this.localId,
    this.externalId,
    required this.name,
    this.fullName,
    this.publisher,
    required this.alignment,
    required this.imageUrl,
    required this.stats,
    this.lastKnownBattleLocation,
    required this.createdAt,
    this.updatedAt,
  });

  bool get isSaved => localId != null;
}
