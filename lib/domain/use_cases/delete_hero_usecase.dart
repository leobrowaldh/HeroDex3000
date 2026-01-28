import 'package:herodex/domain/repositories/i_hero_repository.dart';

class DeleteHeroUseCase {
  final IHeroRepository repo;
  DeleteHeroUseCase(this.repo);

  Future<void> call(String localId) {
    return repo.deleteHero(localId);
  }
}
