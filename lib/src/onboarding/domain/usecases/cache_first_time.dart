import 'package:education_app_tutorial/core/usecases/usecases.dart';
import 'package:education_app_tutorial/core/utils/typedefs.dart';
import 'package:education_app_tutorial/src/onboarding/domain/repos/onboarding_repo.dart';

class CacheFirstTime extends UsecaseWithoutParams<void> {
  const CacheFirstTime(this._repo);

  final OnboardingRepo _repo;

  @override
  ResultFuture<void> call() async => _repo.cacheFirstTime();
}
