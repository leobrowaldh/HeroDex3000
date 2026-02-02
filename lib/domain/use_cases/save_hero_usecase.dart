import 'package:herodex/domain/repositories/i_hero_repository.dart';
import 'package:herodex/domain/entities/hero_entity.dart';

class SaveHeroUseCase {
  final IHeroRepository repo;
  SaveHeroUseCase(this.repo);

  Future<void> call(HeroEntity hero) {
    return repo.saveHero(hero);
  }
}
