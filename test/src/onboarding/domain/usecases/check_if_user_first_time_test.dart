import 'package:dartz/dartz.dart';
import 'package:education_app_tutorial/src/onboarding/domain/usecases/check_if_user_first_time.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repo_mock.dart';

void main() {
  late MockOnboardingRepo repo;
  late CheckIfUserIsFirstTime usecase;

  setUp(
    () => {
      repo = MockOnboardingRepo(),
      usecase = CheckIfUserIsFirstTime(repo),
    },
  );

  test(
    'should get a response from MockOnboardingRepo',
    () async {
      // arrange (stubbing)
      when(() => repo.checkIfUserFirstTime())
          .thenAnswer((_) async => const Right(true));

      // act
      final result = await usecase();

      // assert
      expect(result, equals(const Right<dynamic, bool>(true)));
      verify(() => repo.checkIfUserFirstTime()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
