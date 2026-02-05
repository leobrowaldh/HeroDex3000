import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/domain/entities/hero_entity.dart';
import 'package:herodex/domain/use_cases/search_heroes_usecase.dart';
import 'package:herodex/domain/use_cases/save_hero_usecase.dart';
import 'package:herodex/domain/use_cases/delete_hero_usecase.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchHeroesUseCase _searchHeroesUseCase;
  final SaveHeroUseCase _saveHeroUseCase;
  final DeleteHeroUseCase _deleteHeroUseCase;

  Timer? _debounce;

  SearchCubit(
    this._searchHeroesUseCase,
    this._saveHeroUseCase,
    this._deleteHeroUseCase,
  ) : super(SearchInitial());

  // -----------------------------
  // SEARCH WITH DEBOUNCE
  // -----------------------------
  void search(String query) {
    _debounce?.cancel();

    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 900), () async {
      emit(SearchLoading());

      try {
        final heroes = await _searchHeroesUseCase(query);

        if (heroes.isEmpty) {
          emit(SearchEmpty());
        } else {
          emit(SearchSuccess(heroes));
        }
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });
  }

  // -----------------------------
  // TOGGLE SAVE / UNSAVE
  // -----------------------------
  Future<void> toggleSave(HeroEntity hero) async {
    try {
      if (hero.isSaved) {
        // UNSAVE
        await _deleteHeroUseCase(hero.localId!);

        if (state is SearchSuccess) {
          final current = (state as SearchSuccess).heroes;

          final updated = current.map((h) {
            if (h.externalId == hero.externalId) {
              return h.copyWithLocalId(null);
            }
            return h;
          }).toList();

          emit(SearchSuccess(updated));
        }
      } else {
        // SAVE
        await _saveHeroUseCase(hero);

        if (state is SearchSuccess) {
          final current = (state as SearchSuccess).heroes;

          final updated = current.map((h) {
            if (h.externalId == hero.externalId) {
              return h.copyWithLocalId("saved-ui");
            }
            return h;
          }).toList();

          emit(SearchSuccess(updated));
        }
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  // -----------------------------
  // RESET
  // -----------------------------
  void reset() {
    emit(SearchInitial());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
