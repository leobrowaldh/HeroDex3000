import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/domain/use_cases/get_saved_heroes_usecase.dart';
import 'package:herodex/domain/entities/hero_entity.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetSavedHeroesUseCase _getSavedHeroes;

  HomeCubit(this._getSavedHeroes) : super(HomeInitial());

  Future<void> load() async {
    emit(HomeLoading());

    try {
      final heroes = await _getSavedHeroes();
      final totalPower = heroes.fold<int>(
        0,
        (sum, hero) => sum + hero.stats.fightingPower,
      );

      emit(HomeLoaded(heroes: heroes, totalPower: totalPower));
    } catch (e) {
      emit(HomeError('Kunde inte ladda data'));
    }
  }
}
