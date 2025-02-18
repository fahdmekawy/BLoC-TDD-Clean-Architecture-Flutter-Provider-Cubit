import 'package:education_app_tutorial/core/enums/update_user.dart';
import 'package:education_app_tutorial/core/utils/typedefs.dart';
import 'package:education_app_tutorial/src/auth/domain/entities/user.dart';

abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<void> forgotPassword({String email});

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultFuture<LocalUser> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    dynamic userData,
  });
}
