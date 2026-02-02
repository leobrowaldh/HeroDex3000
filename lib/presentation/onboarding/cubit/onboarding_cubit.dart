import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:herodex/presentation/onboarding/services/onboarding_service.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingService _service;

  OnboardingCubit(this._service) : super(OnboardingInitial());

  Future<void> completeOnboarding() async {
    await _service.setOnboardingDone(true);
    emit(OnboardingCompleted());
  }
}
