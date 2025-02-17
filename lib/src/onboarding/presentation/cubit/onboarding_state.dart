part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingCubitState extends Equatable {
  const OnboardingCubitState();

  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingCubitState {
  const OnboardingInitial();
}

final class CachingFirstTime extends OnboardingCubitState {
  const CachingFirstTime();
}

final class CachingIfUserFirstTime extends OnboardingCubitState {
  const CachingIfUserFirstTime();
}

final class UserCached extends OnboardingCubitState {
  const UserCached();
}

final class OnboardingStatus extends OnboardingCubitState {
  const OnboardingStatus({required this.isFirstTime});

  final bool isFirstTime;
}

final class OnboardingError extends OnboardingCubitState {
  const OnboardingError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
