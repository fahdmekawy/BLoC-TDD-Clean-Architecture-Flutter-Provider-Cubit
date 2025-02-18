import 'package:education_app_tutorial/core/usecases/usecases.dart';
import 'package:education_app_tutorial/core/utils/typedefs.dart';
import 'package:education_app_tutorial/src/auth/domain/repos/auth_repo.dart';

class ForgotPassword extends UsecaseWithParams<void, String> {
  const ForgotPassword(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(String params) =>
      _authRepo.forgotPassword(email: params);
}
