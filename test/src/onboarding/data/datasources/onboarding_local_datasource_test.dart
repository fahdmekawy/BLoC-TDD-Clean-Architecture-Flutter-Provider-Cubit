import 'package:education_app_tutorial/core/errors/exceptions.dart';
import 'package:education_app_tutorial/src/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test/flutter_test.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnboardingLocalDataSource localDataSource;

  setUp(() {
    prefs = MockSharedPreferences();
    localDataSource = OnboardingLocalDataSourceImpl(prefs);
  });

  group('cacheFirstTime', () {
    test(
      'should call [SharedPreferences] to cache the data',
      () async {
        // Arrange
        when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);

        // Act
        await localDataSource.cacheFirstTime();
        // Assert
        verify(() => prefs.setBool(kFirstTimeKey, false)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );

    test(
      'should throw a [CacheException] when there is an error caching the data ',
      () async {
        // Arrange
        when(() => prefs.setBool(any(), any())).thenThrow(Exception());
        // Act
        final methodCall = localDataSource.cacheFirstTime;
        expect(() => methodCall(), throwsA(isA<CacheException>()));
        verify(() => prefs.setBool(kFirstTimeKey, false)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );
  });

  group('checkIfUserFirstTime', () {
    test(
      'should call [SharedPreferences] to check if the user is first '
      'time and return the right response from storage when data exists',
      () async {
        // Arrange
        when(() => prefs.getBool(any())).thenReturn(false);
        // Act
        final result = await localDataSource.checkIfUserFirstTime();
        // Assert
        expect(result, false);
        verify(() => prefs.getBool(kFirstTimeKey)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );

    test(
      'should return true if there is no data in storage',
      () async {
        // Arrange
        when(() => prefs.getBool(any())).thenReturn(null);
        // Act
        final result = await localDataSource.checkIfUserFirstTime();
        // Assert
        expect(result, true);
        verify(() => prefs.getBool(kFirstTimeKey)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );

    test(
      'should throw a [CacheException] when there is an error caching the data ',
      () async {
        // Arrange
        when(() => prefs.getBool(any())).thenThrow(Exception());
        // Act
        final methodCall = localDataSource.checkIfUserFirstTime;
        // Assert
        expect(methodCall, throwsA(isA<CacheException>()));
        verify(() => prefs.getBool(kFirstTimeKey)).called(1);
        verifyNoMoreInteractions(prefs);
      },
    );
  });
}
