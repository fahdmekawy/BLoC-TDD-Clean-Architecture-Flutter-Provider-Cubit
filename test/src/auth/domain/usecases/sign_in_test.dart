import 'package:dartz/dartz.dart';
import 'package:education_app_tutorial/src/auth/domain/entities/user.dart';
import 'package:education_app_tutorial/src/auth/domain/repos/auth_repo.dart';
import 'package:education_app_tutorial/src/auth/domain/usecases/sign_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo_mock.dart';

void main() {
  late AuthRepo repo;
  late SignIn usecase;

  const tEmail = 'test email';
  const tPassword = 'test password';

  final tUser = LocalUser.empty();

  setUp(
    () => {
      repo = MockAuthRepo(),
      usecase = SignIn(repo),
    },
  );

  test('should return [LocalUser] data from the AuthRepo', () async {
    // arrange / stub
    when(
      () => repo.signIn(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => Right(tUser));

    // act
    final result = await usecase(
      const SignInParams(email: tEmail, password: tPassword),
    );

    // assert
    expect(result, Right<dynamic, LocalUser>(tUser));
    verify(() => repo.signIn(email: tEmail, password: tPassword)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
