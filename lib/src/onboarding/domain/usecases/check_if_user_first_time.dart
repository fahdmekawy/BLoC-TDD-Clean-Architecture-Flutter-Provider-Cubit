import 'package:education_app_tutorial/core/usecases/usecases.dart';
import 'package:education_app_tutorial/core/utils/typedefs.dart';
import 'package:education_app_tutorial/src/onboarding/domain/repos/onboarding_repo.dart';

class CheckIfUserIsFirstTime extends UsecaseWithoutParams<bool> {
  const CheckIfUserIsFirstTime(this._repo);

  final OnboardingRepo _repo;

  @override
  ResultFuture<bool> call() async => _repo.checkIfUserFirstTime();
}
