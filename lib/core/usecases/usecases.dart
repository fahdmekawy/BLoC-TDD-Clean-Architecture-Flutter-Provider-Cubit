import 'package:education_app_tutorial/core/utils/typedefs.dart';

abstract class UseaseWithParams<Type, Params> {
  const UseaseWithParams();

  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  ResultFuture<Type> call();
}
