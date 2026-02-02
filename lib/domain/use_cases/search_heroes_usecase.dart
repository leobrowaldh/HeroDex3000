import 'package:herodex/domain/repositories/i_hero_repository.dart';
import 'package:herodex/domain/entities/hero_entity.dart';

class SearchHeroesUseCase {
  final IHeroRepository repo;
  SearchHeroesUseCase(this.repo);

  Future<List<HeroEntity>> call(String query) {
    return repo.searchHeroes(query);
  }
}
