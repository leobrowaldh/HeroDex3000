import 'package:herodex/domain/repositories/i_hero_repository.dart';
import 'package:herodex/domain/entities/hero.dart';

class GetSavedHeroesUseCase {
  final IHeroRepository repo;
  GetSavedHeroesUseCase(this.repo);

  Future<List<Hero>> call() {
    return repo.getSavedHeroes();
  }
}
