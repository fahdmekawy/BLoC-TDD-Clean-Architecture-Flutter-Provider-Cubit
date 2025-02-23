import 'package:dartz/dartz.dart';
import 'package:education_app_tutorial/core/enums/update_user.dart';
import 'package:education_app_tutorial/core/errors/failures.dart';
import 'package:education_app_tutorial/src/auth/domain/usecases/update_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo_mock.dart';

void main() {
  late MockAuthRepo repo;
  late UpdateUser updateUser;

  setUp(() {
    repo = MockAuthRepo();
    updateUser = UpdateUser(repo);
    registerFallbackValue(UpdateUserAction.displayName);
  });

  const tUpdateUserParams = UpdateUserParams(
    action: UpdateUserAction.displayName,
    userData: 'testUserData',
  );

  test('should update user when provided valid parameters', () async {
    when(
      () => repo.updateUser(
        action: any(named: 'action'),
        userData: tUpdateUserParams.userData,
      ),
    ).thenAnswer((_) async => const Right<Failure, void>(null));

    final result = await updateUser(tUpdateUserParams);

    expect(result, const Right<Failure, void>(null));
    verify(
      () => repo.updateUser(
        action: tUpdateUserParams.action,
        userData: tUpdateUserParams.userData,
      ),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
