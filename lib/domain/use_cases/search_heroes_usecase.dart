import 'package:herodex/domain/repositories/i_hero_repository.dart';
import 'package:herodex/domain/entities/hero.dart';

class SearchHeroesUseCase {
  final IHeroRepository repo;
  SearchHeroesUseCase(this.repo);

  Future<List<Hero>> call(String query) {
    return repo.searchHeroes(query);
  }
}
