import 'package:dartz/dartz.dart';
import 'package:education_app_tutorial/core/errors/exceptions.dart';
import 'package:education_app_tutorial/core/errors/failures.dart';
import 'package:education_app_tutorial/core/utils/typedefs.dart';
import 'package:education_app_tutorial/src/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:education_app_tutorial/src/onboarding/domain/repos/onboarding_repo.dart';

class OnboardingRepoImpl implements OnboardingRepo {
  const OnboardingRepoImpl(this._localDataSource);

  final OnboardingLocalDataSource _localDataSource;

  @override
  ResultFuture<void> cacheFirstTime() async {
    try {
      await _localDataSource.cacheFirstTime();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<bool> checkIfUserFirstTime() {
    throw UnimplementedError();
  }
}
