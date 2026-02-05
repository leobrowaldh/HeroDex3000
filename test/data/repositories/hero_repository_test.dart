import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:herodex/data/repositories/hero_repository.dart';
import 'package:herodex/data/datasource/i_hero_http_client.dart';
import 'package:herodex/data/datasource/i_local_db.dart';
import 'package:herodex/data/models/hero_api_model.dart';
import 'package:herodex/data/models/hero_db_model.dart';
import 'package:herodex/data/models/http_response_model.dart';
import 'package:herodex/domain/entities/hero_entity.dart';

class MockHttpClient extends Mock implements IHeroHttpClient {}

class MockLocalDb extends Mock implements ILocalDb {}

class FakeHeroDbModel extends Fake implements HeroDbModel {}

void main() {
  late MockHttpClient mockHttp;
  late MockLocalDb mockDb;
  late HeroRepository repo;

  setUpAll(() {
    registerFallbackValue(FakeHeroDbModel());
  });

  setUp(() {
    mockHttp = MockHttpClient();
    mockDb = MockLocalDb();

    repo = HeroRepository(httpClient: mockHttp, localDb: mockDb);
  });

  test('getSavedHeroes maps DB models to domain models', () async {
    when(() => mockDb.getAllHeroes()).thenAnswer(
      (_) async => [
        HeroDbModel(
          id: '1',
          externalId: '100',
          name: 'Batman',
          fullName: null,
          publisher: 'DC',
          alignment: 'good',
          imageUrl: 'batman.png',
          strength: 80,
          intelligence: 90,
          speed: 70,
          durability: 85,
          power: 60,
          combat: 95,
          aliases: null,
          race: null,
          gender: null,
          placeOfBirth: null,
          firstAppearance: null,
          occupation: null,
          base: null,
          groupAffiliation: null,
          relatives: null,
          latitude: null,
          longitude: null,
          locationDescription: null,
          createdAt: DateTime(2020),
          updatedAt: null,
        ),
      ],
    );

    final result = await repo.getSavedHeroes();

    expect(result.length, 1);
    expect(result.first.name, 'Batman');
    expect(result.first.localId, '1');
  });

  test('searchHeroes merges API and DB heroes', () async {
    when(() => mockHttp.searchHeroes('super')).thenAnswer(
      (_) async => HttpResponseSearchModel(
        response: 'success',
        resultsFor: 'super',
        results: [
          HeroApiModel(
            id: '200',
            name: 'Superman',
            fullName: null,
            alterEgos: null,
            aliases: null,
            placeOfBirth: null,
            firstAppearance: null,
            publisher: 'DC',
            alignment: 'good',
            gender: null,
            race: null,
            height: null,
            weight: null,
            eyeColor: null,
            hairColor: null,
            groupAffiliation: null,
            relatives: null,
            imageUrl: 'super.png',
            intelligence: '90',
            strength: '100',
            speed: '100',
            durability: '95',
            power: '100',
            combat: '85',
            occupation: null,
            base: null,
            createdAt: null,
            updatedAt: null,
          ),
        ],
      ),
    );

    when(() => mockDb.getAllHeroes()).thenAnswer(
      (_) async => [
        HeroDbModel(
          id: 'xyz',
          externalId: '200',
          name: 'Superman',
          fullName: null,
          publisher: 'DC',
          alignment: 'good',
          imageUrl: 'super.png',
          strength: 100,
          intelligence: 90,
          speed: 100,
          durability: 95,
          power: 100,
          combat: 85,
          aliases: null,
          race: null,
          gender: null,
          placeOfBirth: null,
          firstAppearance: null,
          occupation: null,
          base: null,
          groupAffiliation: null,
          relatives: null,
          latitude: null,
          longitude: null,
          locationDescription: null,
          createdAt: DateTime(2020),
          updatedAt: null,
        ),
      ],
    );

    final result = await repo.searchHeroes('super');

    expect(result.length, 1);
    expect(result.first.name, 'Superman');
    expect(result.first.localId, 'xyz');
  });

  test('saveHero saves hero using API cache', () async {
    when(() => mockHttp.searchHeroes('bat')).thenAnswer(
      (_) async => HttpResponseSearchModel(
        response: 'success',
        resultsFor: 'bat',
        results: [
          HeroApiModel(
            id: '300',
            name: 'Batman',
            fullName: null,
            alterEgos: null,
            aliases: null,
            placeOfBirth: null,
            firstAppearance: null,
            publisher: 'DC',
            alignment: 'good',
            gender: null,
            race: null,
            height: null,
            weight: null,
            eyeColor: null,
            hairColor: null,
            groupAffiliation: null,
            relatives: null,
            imageUrl: 'bat.png',
            intelligence: '90',
            strength: '80',
            speed: '70',
            durability: '85',
            power: '60',
            combat: '95',
            occupation: null,
            base: null,
            createdAt: null,
            updatedAt: null,
          ),
        ],
      ),
    );

    when(() => mockDb.getAllHeroes()).thenAnswer((_) async => []);
    when(() => mockDb.getHeroByExternalId(any())).thenAnswer((_) async => null);
    when(() => mockDb.saveHero(any())).thenAnswer((_) async => {});

    await repo.searchHeroes('bat');

    final hero = HeroEntity(
      externalId: '300',
      name: 'Batman',
      fullName: null,
      publisher: 'DC',
      alignment: HeroAlignment.hero,
      imageUrl: 'bat.png',
      stats: const HeroStats.empty(),
      lastKnownBattleLocation: null,
      createdAt: DateTime(2020),
      updatedAt: null,
    );

    await repo.saveHero(hero);

    verify(() => mockDb.saveHero(any())).called(1);
  });

  test('deleteHero calls localDb.deleteHero', () async {
    when(() => mockDb.deleteHero('abc')).thenAnswer((_) async => {});

    await repo.deleteHero('abc');

    verify(() => mockDb.deleteHero('abc')).called(1);
  });
}
