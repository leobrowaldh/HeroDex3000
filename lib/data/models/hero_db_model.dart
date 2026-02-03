class HeroDbModel {
  final String id; // Firebase document ID
  final String? externalId;

  final String name;
  final String? fullName;
  final String? publisher;
  final String alignment;
  final String? imageUrl;

  // Stats
  final int strength;
  final int intelligence;
  final int speed;
  final int durability;
  final int power;
  final int combat;

  // Optional details
  final List<String>? aliases;
  final String? race;
  final String? gender;
  final String? placeOfBirth;
  final String? firstAppearance;
  final String? occupation;
  final String? base;
  final String? groupAffiliation;
  final String? relatives;

  // Location
  final double? latitude;
  final double? longitude;
  final String? locationDescription;

  // Metadata
  final DateTime createdAt;
  final DateTime? updatedAt;

  const HeroDbModel({
    required this.id,
    this.externalId,
    required this.name,
    this.fullName,
    this.publisher,
    required this.alignment,
    this.imageUrl,
    required this.strength,
    required this.intelligence,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
    this.aliases,
    this.race,
    this.gender,
    this.placeOfBirth,
    this.firstAppearance,
    this.occupation,
    this.base,
    this.groupAffiliation,
    this.relatives,
    this.latitude,
    this.longitude,
    this.locationDescription,
    required this.createdAt,
    this.updatedAt,
  });

  /// Firebase does NOT include the document ID inside the JSON.
  /// So we must pass it in manually.
  factory HeroDbModel.fromJson(String id, Map<String, dynamic> json) {
    return HeroDbModel(
      id: id,
      externalId: json['externalId'],
      name: json['name'],
      fullName: json['fullName'],
      publisher: json['publisher'],
      alignment: json['alignment'],
      imageUrl: json['imageUrl'],
      strength: json['strength'],
      intelligence: json['intelligence'],
      speed: json['speed'],
      durability: json['durability'],
      power: json['power'],
      combat: json['combat'],
      aliases: (json['aliases'] as List?)?.map((e) => e.toString()).toList(),
      race: json['race'],
      gender: json['gender'],
      placeOfBirth: json['placeOfBirth'],
      firstAppearance: json['firstAppearance'],
      occupation: json['occupation'],
      base: json['base'],
      groupAffiliation: json['groupAffiliation'],
      relatives: json['relatives'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      locationDescription: json['locationDescription'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  /// Firebase stores the ID separately, so we do NOT include it here.
  Map<String, dynamic> toJson() {
    return {
      'externalId': externalId,
      'name': name,
      'fullName': fullName,
      'publisher': publisher,
      'alignment': alignment,
      'imageUrl': imageUrl,
      'strength': strength,
      'intelligence': intelligence,
      'speed': speed,
      'durability': durability,
      'power': power,
      'combat': combat,
      'aliases': aliases,
      'race': race,
      'gender': gender,
      'placeOfBirth': placeOfBirth,
      'firstAppearance': firstAppearance,
      'occupation': occupation,
      'base': base,
      'groupAffiliation': groupAffiliation,
      'relatives': relatives,
      'latitude': latitude,
      'longitude': longitude,
      'locationDescription': locationDescription,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
