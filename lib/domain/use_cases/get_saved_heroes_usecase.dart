import 'package:herodex/domain/repositories/i_hero_repository.dart';
import 'package:herodex/domain/entities/hero_entity.dart';

class GetSavedHeroesUseCase {
  final IHeroRepository repo;
  GetSavedHeroesUseCase(this.repo);

  Future<List<HeroEntity>> call() {
    return repo.getSavedHeroes();
  }
}
