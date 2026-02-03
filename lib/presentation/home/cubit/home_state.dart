part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<HeroEntity> heroes;
  final int totalPower;
  final int heroCount;
  final int villainCount;
  final List<WarUpdate> warUpdates;

  HomeLoaded({
    required this.heroes,
    required this.totalPower,
    required this.heroCount,
    required this.villainCount,
    required this.warUpdates,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
