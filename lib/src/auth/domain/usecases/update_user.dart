import 'package:education_app_tutorial/core/enums/update_user.dart';
import 'package:education_app_tutorial/core/usecases/usecases.dart';
import 'package:education_app_tutorial/core/utils/typedefs.dart';
import 'package:education_app_tutorial/src/auth/domain/repos/auth_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateUser extends UsecaseWithParams<void, UpdateUserParams> {
  const UpdateUser(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _authRepo.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.action,
    this.userData,
  });

  const UpdateUserParams.empty()
      : this(
          action: UpdateUserAction.displayName,
          userData: '',
        );

  final UpdateUserAction action;
  final dynamic userData;

  @override
  List<Object?> get props => [action, userData];
}
