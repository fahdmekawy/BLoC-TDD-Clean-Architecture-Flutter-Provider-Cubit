import 'package:education_app_tutorial/core/errors/exceptions.dart';
import 'package:education_app_tutorial/core/errors/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDataSource {
  const OnboardingLocalDataSource();

  Future<void> cacheFirstTime();

  Future<bool> checkIfUserFirstTime();
}

const kFirstTimeKey = 'first_time';

class OnboardingLocalDataSourceImpl extends OnboardingLocalDataSource {
  OnboardingLocalDataSourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> cacheFirstTime() async {
    try {
      await _prefs.setBool(kFirstTimeKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserFirstTime() async {
    try {
      return _prefs.getBool(kFirstTimeKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
