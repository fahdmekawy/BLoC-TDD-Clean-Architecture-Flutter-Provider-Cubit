import 'package:dartz/dartz.dart';
import 'package:education_app_tutorial/core/errors/exceptions.dart';
import 'package:education_app_tutorial/core/errors/failures.dart';
import 'package:education_app_tutorial/src/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:education_app_tutorial/src/onboarding/data/repos/onboarding_repo_impl.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingLocalDataSource extends Mock
    implements OnboardingLocalDataSource {}

void main() {
  late OnboardingLocalDataSource localDataSource;
  late OnboardingRepoImpl repoImpl;

  setUp(
    () => {
      localDataSource = MockOnboardingLocalDataSource(),
      repoImpl = OnboardingRepoImpl(localDataSource),
    },
  );

  test('should be a subclass of [OnboardingRepo]', () {
    expect(repoImpl, isA<OnboardingRepoImpl>());
  });

  group('cacheFirstTimer', () {
    test(
        'should complete successfully when call to '
        'localDataSource is successful', () async {
      // arrange
      when(() => localDataSource.cacheFirstTime()).thenAnswer(
        (_) async => Future.value(),
      );

      // act
      final result = await repoImpl.cacheFirstTime();

      // assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => localDataSource.cacheFirstTime()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });

    test('should return [CacheFailure] when call to localDataSource failed',
        () async {
      // arrange
      when(() => localDataSource.cacheFirstTime()).thenThrow(
        const CacheException(message: 'Insufficient Storage'),
      );

      // act
      final result = await repoImpl.cacheFirstTime();

      // assert
      expect(
        result,
        equals(
          Left<CacheFailure, dynamic>(
            CacheFailure(message: 'Insufficient Storage', statusCode: 500),
          ),
        ),
      );
      verify(() => localDataSource.cacheFirstTime()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test('should return true when user is first timer', () async {
      // arrange
      when(() => localDataSource.checkIfUserFirstTime())
          .thenAnswer((_) async => Future.value(true));

      // act
      final result = await repoImpl.checkIfUserFirstTime();

      // assert
      expect(result, equals(const Right<dynamic, bool>(true)));
      verify(() => localDataSource.checkIfUserFirstTime()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });

    test('should return false if user is NOT a first timer', () async {
      // arrange
      when(() => localDataSource.checkIfUserFirstTime())
          .thenAnswer((_) async => Future.value(false));

      // act
      final result = await repoImpl.checkIfUserFirstTime();

      // assert
      expect(result, equals(const Right<dynamic, bool>(false)));
      verify(() => localDataSource.checkIfUserFirstTime()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });

    test('should return [CacheFailure] when call to localDataSource failed',
        () async {
      // arrange
      when(() => localDataSource.checkIfUserFirstTime()).thenThrow(
        const CacheException(message: 'Insufficient Storage'),
      );

      // act
      final result = await repoImpl.checkIfUserFirstTime();

      // assert
      expect(
        result,
        equals(
          Left<CacheFailure, dynamic>(
            CacheFailure(message: 'Insufficient Storage', statusCode: 500),
          ),
        ),
      );
      verify(() => localDataSource.checkIfUserFirstTime()).called(1);
      verifyNoMoreInteractions(localDataSource);
    });
  });
}
