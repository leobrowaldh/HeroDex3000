import 'package:herodex/domain/repositories/i_hero_repository.dart';
import 'package:herodex/domain/entities/hero.dart';

class SaveHeroUseCase {
  final IHeroRepository repo;
  SaveHeroUseCase(this.repo);

  Future<void> call(Hero hero) {
    return repo.saveHero(hero);
  }
}
