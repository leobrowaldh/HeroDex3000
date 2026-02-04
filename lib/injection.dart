import 'package:get_it/get_it.dart';

import 'package:herodex/data/datasource/i_hero_http_client.dart';
import 'package:herodex/data/datasource/hero_http_client.dart';

import 'package:herodex/data/datasource/i_local_db.dart';
import 'package:herodex/data/datasource/local_db.dart';

import 'package:herodex/domain/repositories/i_hero_repository.dart';
import 'package:herodex/data/repositories/hero_repository.dart';
import 'package:herodex/domain/use_cases/delete_hero_usecase.dart';
import 'package:herodex/domain/use_cases/get_saved_heroes_usecase.dart';
import 'package:herodex/domain/use_cases/save_hero_usecase.dart';
import 'package:herodex/domain/use_cases/search_heroes_usecase.dart';
import 'package:herodex/presentation/onboarding/services/onboarding_service.dart';
import 'package:herodex/presentation/saved/cubit/saved_cubit.dart';
import 'package:herodex/presentation/search/cubit/search_cubit.dart';
import 'package:herodex/presentation/theme/theme_service.dart';
import 'package:herodex/presentation/theme/cubit/theme_cubit.dart';
import 'package:herodex/presentation/settings/cubit/settings_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // -----------------------------
  // DATA SOURCES
  // -----------------------------
  getIt.registerLazySingleton<IHeroHttpClient>(() => HeroHttpClient());
  getIt.registerLazySingleton<ILocalDb>(() => LocalDb());

  // -----------------------------
  // REPOSITORY
  // -----------------------------
  getIt.registerLazySingleton<IHeroRepository>(
    () => HeroRepository(
      httpClient: getIt<IHeroHttpClient>(),
      localDb: getIt<ILocalDb>(),
    ),
  );

  // -----------------------------
  // USE CASES
  // -----------------------------
  getIt.registerLazySingleton<SearchHeroesUseCase>(
    () => SearchHeroesUseCase(getIt<IHeroRepository>()),
  );

  getIt.registerLazySingleton<GetSavedHeroesUseCase>(
    () => GetSavedHeroesUseCase(getIt<IHeroRepository>()),
  );

  getIt.registerLazySingleton<SaveHeroUseCase>(
    () => SaveHeroUseCase(getIt<IHeroRepository>()),
  );

  getIt.registerLazySingleton<DeleteHeroUseCase>(
    () => DeleteHeroUseCase(getIt<IHeroRepository>()),
  );

  // -----------------------------
  // SERVICES
  // -----------------------------
  getIt.registerLazySingleton<OnboardingService>(() => OnboardingService());

  // -----------------------------
  // CUBITS
  // -----------------------------
  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(
      getIt<SearchHeroesUseCase>(),
      getIt<SaveHeroUseCase>(),
      getIt<DeleteHeroUseCase>(),
    ),
  );

  getIt.registerFactory<SavedCubit>(
    () => SavedCubit(
      getSavedHeroesUseCase: getIt<GetSavedHeroesUseCase>(),
      deleteHeroUseCase: getIt<DeleteHeroUseCase>(),
    ),
  );

  getIt.registerLazySingleton<ThemeService>(() => ThemeService());

  getIt.registerFactory<ThemeCubit>(
    () => ThemeCubit(getIt<ThemeService>()),
  );

  getIt.registerFactory<SettingsCubit>(
    () => SettingsCubit(getIt<OnboardingService>()),
  );
}
