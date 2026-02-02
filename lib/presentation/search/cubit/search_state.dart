import 'package:equatable/equatable.dart';
import 'package:herodex/domain/entities/hero_entity.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<HeroEntity> heroes;

  const SearchSuccess(this.heroes);

  @override
  List<Object?> get props => [heroes];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchEmpty extends SearchState {}
