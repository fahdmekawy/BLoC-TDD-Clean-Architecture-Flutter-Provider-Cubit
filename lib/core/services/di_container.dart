import 'package:education_app_tutorial/src/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:education_app_tutorial/src/onboarding/data/repos/onboarding_repo_impl.dart';
import 'package:education_app_tutorial/src/onboarding/domain/repos/onboarding_repo.dart';
import 'package:education_app_tutorial/src/onboarding/domain/usecases/cache_first_time.dart';
import 'package:education_app_tutorial/src/onboarding/domain/usecases/check_if_user_first_time.dart';
import 'package:education_app_tutorial/src/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Register SharedPreferences asynchronously
  sl
    ..registerSingletonAsync<SharedPreferences>(
      () async => SharedPreferences.getInstance(),
    )

    // Feature --> Onboarding
    // Business Logic

    ..registerFactory(() =>
        OnboardingCubit(checkIfUserIsFirstTime: sl(), cacheFirstTime: sl()))
    ..registerLazySingleton<CheckIfUserIsFirstTime>(
        () => CheckIfUserIsFirstTime(sl()))
    ..registerLazySingleton<CacheFirstTime>(() => CacheFirstTime(sl()))
    ..registerLazySingleton<OnboardingRepo>(() => OnboardingRepoImpl(sl()))
    ..registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(sl()),
    );
  // Ensure async dependencies are ready before use
  await sl.allReady();
}
