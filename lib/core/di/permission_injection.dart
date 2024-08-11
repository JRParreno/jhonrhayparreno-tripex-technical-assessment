// coverage:ignore-file
import 'package:get_it/get_it.dart';
import 'package:jhon_rhay_parreno_technical_assessment/core/permission/app_permission.dart';

void initPersmissionService(GetIt serviceLocator) {
  serviceLocator
      .registerLazySingleton<PermissionService>(() => PermissionServiceImpl());
}
