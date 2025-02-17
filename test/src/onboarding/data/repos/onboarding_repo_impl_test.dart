import 'package:dartz/dartz.dart';
import 'package:education_app_tutorial/core/errors/exceptions.dart';
import 'package:education_app_tutorial/src/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:education_app_tutorial/src/onboarding/data/repos/onboarding_repo_impl.dart';
import 'package:education_app_tutorial/src/onboarding/domain/repos/onboarding_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingLocalDataSrc extends Mock
    implements OnboardingLocalDataSource {}

void main() {
  late OnboardingLocalDataSource localDataSource;
  late OnboardingRepoImpl repoImpl;

  setUp(() {
    localDataSource = MockOnboardingLocalDataSrc();
    repoImpl = OnboardingRepoImpl(localDataSource);
  });

  test('should be a subclass of [OnboardingRepo]', () {
    expect(repoImpl, isA<OnboardingRepo>());
  });

  group('cacheFirstTime', () {
    test(
      'should complete successfully when call to local source is successful',
      () async {
        // Arrange
        when(() => localDataSource.cacheFirstTime())
            .thenAnswer((_) async => Future.value());

        // Act
        final result = await repoImpl.cacheFirstTime();

        // Assert
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => localDataSource.cacheFirstTime()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );

    test(
      'should return [CacheFailure] when call to local source is unsuccessful',
      () async {
        // Arrange
        when(() => localDataSource.cacheFirstTime()).thenAnswer(
            (_) async => const CacheException(message: 'Insufficient storage'));
        // Act
        final result = await repoImpl.cacheFirstTime();
        // Assert
        expect(
          result,
          equals(
            const Left<CacheException, dynamic>(
              CacheException(message: 'Insufficient storage'),
            ),
          ),
        );
        verify(() => localDataSource.cacheFirstTime()).called(1);
        verifyNoMoreInteractions(localDataSource);
      },
    );
  });
}
