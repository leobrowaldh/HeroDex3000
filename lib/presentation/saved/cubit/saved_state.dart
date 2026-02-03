import 'package:herodex/domain/entities/hero_entity.dart';

abstract class SavedState {}

class SavedInitial extends SavedState {}

class SavedLoading extends SavedState {}

class SavedLoaded extends SavedState {
  final List<HeroEntity> heroes;
  SavedLoaded(this.heroes);
}

class SavedError extends SavedState {
  final String message;
  SavedError(this.message);
}
