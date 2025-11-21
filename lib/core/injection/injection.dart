import 'package:get_it/get_it.dart';
import 'package:magic_slides/core/data/services/file_service.dart';
import 'package:magic_slides/feature/authentication/authentication_injection.dart';
import 'package:magic_slides/core/preferences/app_preferences.dart';
import 'package:magic_slides/feature/home/home_injection.dart';
import 'package:magic_slides/network/api_service.dart';

GetIt mainModule = GetIt.asNewInstance();

class Injection {
  void inject() {
    mainModule.registerLazySingleton<AppPreferences>(() => AppPreferences());
    mainModule.registerLazySingleton<ApiService>(() => ApiService());
    mainModule.registerLazySingleton<FileService>(() => FileService());
    AuthenticationInjection().inject();
    HomeInjection().inject();
  }
}
