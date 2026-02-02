import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/domain/use_cases/search_heroes_usecase.dart';
import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchHeroesUseCase _searchHeroesUseCase;
  Timer? _debounce;

  SearchCubit(this._searchHeroesUseCase) : super(SearchInitial());

  void search(String query) {
    // Cancel previous timer
    _debounce?.cancel();

    // If empty → reset immediately
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    // Start debounce timer
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

  void reset() {
    emit(SearchInitial());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
