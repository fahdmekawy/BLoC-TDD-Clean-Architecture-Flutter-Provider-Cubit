import 'package:dartz/dartz.dart';
import 'package:education_app_tutorial/core/errors/failures.dart';
import 'package:education_app_tutorial/src/onboarding/domain/repos/onboarding_repo.dart';
import 'package:education_app_tutorial/src/onboarding/domain/usecases/cache_first_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repo_mock.dart';

void main() {
  late OnboardingRepo repo;
  late CacheFirstTime usecase;

  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CacheFirstTime(repo);
  });

  final tServerError =
      ServerFailure(message: 'Unknown Error Occurred', statusCode: 500);

  test(
      'should call [OnboardingRepo.cacheFirstTime] and return the correct data',
      () async {
    // Arrange
    when(() => repo.cacheFirstTime()).thenAnswer(
      (_) async => Left(tServerError),
    );
    // Act
    final result = await usecase();
    // Assert
    expect(
      result,
      equals(
        Left<Failure, dynamic>(tServerError),
      ),
    );
    verify(() => repo.cacheFirstTime()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
