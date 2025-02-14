import 'package:education_app_tutorial/core/usecases/usecases.dart';
import 'package:education_app_tutorial/core/utils/typedefs.dart';
import 'package:education_app_tutorial/src/onboarding/domain/repos/onboarding_repo.dart';

class CacheFirstTime extends UsecaseWithoutParams<void> {
  const CacheFirstTime(this.repo);

  final OnboardingRepo repo;

  @override
  ResultFuture<void> call() async => repo.cacheFirstTime();
}
