part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<HeroEntity> heroes;
  final int totalPower;

  HomeLoaded({required this.heroes, required this.totalPower});
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
