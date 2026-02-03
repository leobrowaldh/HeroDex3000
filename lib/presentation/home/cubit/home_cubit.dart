import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/domain/use_cases/get_saved_heroes_usecase.dart';
import 'package:herodex/domain/entities/hero_entity.dart';
import 'package:herodex/data/datasource/war_updates_data.dart';
import 'package:logger/logger.dart';

import 'package:herodex/domain/entities/war_update.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetSavedHeroesUseCase _getSavedHeroes;
  final logger = Logger();

  HomeCubit(this._getSavedHeroes) : super(HomeInitial());

  Future<void> load() async {
    emit(HomeLoading());

    try {
      final heroes = await _getSavedHeroes();
      
      final totalPower = heroes.fold<int>(
        0,
        (sum, hero) => sum + hero.stats.fightingPower,
      );

      final heroCount = heroes.where((h) => h.alignment == HeroAlignment.hero).length;
      final villainCount = heroes.where((h) => h.alignment == HeroAlignment.villain).length;

      // Pick 3 random war updates
      final updates = List<WarUpdate>.from(WarUpdatesData.updates)..shuffle();
      final selectedUpdates = updates.take(3).toList();

      emit(HomeLoaded(
        heroes: heroes,
        totalPower: totalPower,
        heroCount: heroCount,
        villainCount: villainCount,
        warUpdates: selectedUpdates,
      ));
    } catch (e, stack) {
      logger.e(
        'HomeCubit.load() failed',
        error: e,
        stackTrace: stack,
      );

      emit(HomeError('Could not load data.'));
    }
  }
}
