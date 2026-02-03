import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:herodex/data/datasource/i_local_db.dart';
import 'package:herodex/data/models/hero_db_model.dart';

class LocalDb implements ILocalDb {
  final _collection = FirebaseFirestore.instance.collection('heroes');

  @override
  Future<void> saveHero(HeroDbModel hero) async {
    await _collection.doc(hero.id).set(hero.toJson());
  }

  @override
  Future<void> deleteHero(String localId) async {
    await _collection.doc(localId).delete();
  }

  @override
  Future<List<HeroDbModel>> getAllHeroes() async {
    final snapshot = await _collection.get();

    return snapshot.docs.map((doc) {
      return HeroDbModel.fromJson(
        doc.id, // <-- Firebase document ID
        doc.data(), // <-- JSON map
      );
    }).toList();
  }

  @override
  Future<HeroDbModel?> getHeroByLocalId(String localId) async {
    final doc = await _collection.doc(localId).get();
    if (!doc.exists) return null;

    return HeroDbModel.fromJson(
      doc.id, // <-- Firebase document ID
      doc.data()!, // <-- JSON map
    );
  }

  @override
  Future<HeroDbModel?> getHeroByExternalId(String externalId) async {
    final query = await _collection
        .where('externalId', isEqualTo: externalId)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;

    final doc = query.docs.first;
    return HeroDbModel.fromJson(
      doc.id,
      doc.data(),
    );
  }
}
