import 'package:education_app_tutorial/core/utils/typedefs.dart';

abstract class OnboardingRepo {
  const OnboardingRepo();

  ResultFuture<void> cacheFirstTime();

  ResultFuture<bool> checkIfUserFirstTime();
}
