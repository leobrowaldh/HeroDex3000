import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/domain/entities/hero_entity.dart';
import 'package:herodex/domain/use_cases/delete_hero_usecase.dart';
import 'package:herodex/domain/use_cases/get_saved_heroes_usecase.dart';
import 'package:herodex/presentation/saved/cubit/saved_state.dart';

class SavedCubit extends Cubit<SavedState> {
  final GetSavedHeroesUseCase _getSavedHeroesUseCase;
  final DeleteHeroUseCase _deleteHeroUseCase;

  SavedCubit({
    required GetSavedHeroesUseCase getSavedHeroesUseCase,
    required DeleteHeroUseCase deleteHeroUseCase,
  })  : _getSavedHeroesUseCase = getSavedHeroesUseCase,
        _deleteHeroUseCase = deleteHeroUseCase,
        super(SavedInitial());

  Future<void> loadSavedHeroes() async {
    emit(SavedLoading());
    try {
      final heroes = await _getSavedHeroesUseCase();
      emit(SavedLoaded(heroes));
    } catch (e) {
      emit(SavedError(e.toString()));
    }
  }

  Future<void> deleteHero(HeroEntity hero) async {
    if (hero.localId == null) return;
    
    try {
      await _deleteHeroUseCase(hero.localId!);
      await loadSavedHeroes();
    } catch (e) {
      emit(SavedError("Failed to delete hero: $e"));
      // Reload to ensure consistent state
      loadSavedHeroes();
    }
  }
}
