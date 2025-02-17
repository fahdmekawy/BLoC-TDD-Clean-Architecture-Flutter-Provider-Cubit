import 'package:dartz/dartz.dart';
import 'package:education_app_tutorial/core/errors/failures.dart';
import 'package:education_app_tutorial/src/onboarding/domain/usecases/cache_first_time.dart';
import 'package:education_app_tutorial/src/onboarding/domain/usecases/check_if_user_first_time.dart';
import 'package:education_app_tutorial/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockCacheFirstTime extends Mock implements CacheFirstTime {}

class MockCheckIfUserIsFirstTime extends Mock
    implements CheckIfUserIsFirstTime {}

void main() {
  late CacheFirstTime cacheFirstTime;
  late CheckIfUserIsFirstTime checkIfUserIsFirstTime;
  late OnboardingCubit cubit;
  setUp(() {
    cacheFirstTime = MockCacheFirstTime();
    checkIfUserIsFirstTime = MockCheckIfUserIsFirstTime();
    cubit = OnboardingCubit(
      cacheFirstTime: cacheFirstTime,
      checkIfUserIsFirstTime: checkIfUserIsFirstTime,
    );
  });
  final tFailure =
      CacheFailure(message: 'Insufficient storage', statusCode: 404);

  test('Initial State should be [OnboardingInitial]', () {
    expect(cubit.state, const OnboardingInitial());
  });

  group('cacheFirstTime', () {
    blocTest<OnboardingCubit, OnboardingCubitState>(
      'should emit [CachingFirstTime, UserCached] when successful',
      build: () {
        when(() => cacheFirstTime()).thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTime(),
      expect: () => const [CachingFirstTime(), UserCached()],
      verify: (_) {
        verify(() => cacheFirstTime()).called(1);
        verifyNoMoreInteractions(cacheFirstTime);
      },
    );

    blocTest<OnboardingCubit, OnboardingCubitState>(
      'should emit [CachingFirstTime, OnboardingError] when unsuccessful',
      build: () {
        when(() => cacheFirstTime()).thenAnswer(
          (_) async => Left(tFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTime(),
      expect: () => [
        const CachingFirstTime(),
        OnboardingError(message: tFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => cacheFirstTime()).called(1);
        verifyNoMoreInteractions(cacheFirstTime);
      },
    );
  });
  group('checkIfUserFirstTime', () {
    blocTest<OnboardingCubit, OnboardingCubitState>(
      'should emit [CachingIfUserFirstTime, OnboardingStatus] when successful',
      build: () {
        when(() => checkIfUserIsFirstTime())
            .thenAnswer((_) async => const Right(false));
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTime(),
      expect: () => const [
        CachingIfUserFirstTime(),
        OnboardingStatus(isFirstTime: false)
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTime()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTime);
      },
    );
    blocTest<OnboardingCubit, OnboardingCubitState>(
      'should emit [CachingIfUserFirstTime, OnboardingError(true)] when unsuccessful',
      build: () {
        when(() => checkIfUserIsFirstTime())
            .thenAnswer((_) async => Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTime(),
      expect: () => const [
        CachingIfUserFirstTime(),
        OnboardingStatus(isFirstTime: true),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTime()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTime);
      },
    );
  });
}
