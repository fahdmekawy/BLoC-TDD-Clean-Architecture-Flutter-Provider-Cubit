import 'package:education_app_tutorial/core/usecases/usecases.dart';
import 'package:education_app_tutorial/core/utils/typedefs.dart';
import 'package:education_app_tutorial/src/auth/domain/entities/user.dart';
import 'package:education_app_tutorial/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignIn extends UsecaseWithParams<LocalUser, SignInParams> {
  const SignIn(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<LocalUser> call(SignInParams params) => _authRepo.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
      : this(
          email: '',
          password: '',
        );

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
