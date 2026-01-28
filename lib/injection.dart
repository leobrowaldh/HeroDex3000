import 'package:get_it/get_it.dart';

import 'package:herodex/data/datasource/i_hero_http_client.dart';
import 'package:herodex/data/datasource/hero_http_client.dart';

import 'package:herodex/data/datasource/i_local_db.dart';
import 'package:herodex/data/datasource/local_db.dart';

import 'package:herodex/domain/repositories/i_hero_repository.dart';
import 'package:herodex/data/repositories/hero_repository.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<IHeroHttpClient>(() => HeroHttpClient());
  getIt.registerLazySingleton<ILocalDb>(() => LocalDb());
  getIt.registerLazySingleton<IHeroRepository>(
    () => HeroRepository(
      httpClient: getIt<IHeroHttpClient>(),
      localDb: getIt<ILocalDb>(),
    ),
  );
}
