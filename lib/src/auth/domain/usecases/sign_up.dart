import 'package:education_app_tutorial/core/usecases/usecases.dart';
import 'package:education_app_tutorial/core/utils/typedefs.dart';
import 'package:education_app_tutorial/src/auth/domain/entities/user.dart';
import 'package:education_app_tutorial/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class SignUp extends UsecaseWithParams<LocalUser, SignUpParams> {
  const SignUp(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<LocalUser> call(SignUpParams params) => _authRepo.signUp(
        email: params.email,
        password: params.password,
        fullName: params.fullName,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.fullName,
  });

  const SignUpParams.empty()
      : this(
          email: '',
          password: '',
          fullName: '',
        );

  final String email;
  final String password;
  final String fullName;

  @override
  List<Object?> get props => [email, password, fullName];
}
