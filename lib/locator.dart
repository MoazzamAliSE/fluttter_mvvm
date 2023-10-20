import 'package:flutter_mvvm/services/api_services.dart';
import 'package:flutter_mvvm/services/firebase_sevice.dart';
import 'package:flutter_mvvm/services/local_storage_services.dart';
import 'package:flutter_mvvm/viewmodel/home_viewmodel.dart';
import 'package:flutter_mvvm/viewmodel/login_viewmodel.dart';
import 'package:flutter_mvvm/viewmodel/profile_viewmodel.dart';
import 'package:flutter_mvvm/viewmodel/register_viewmodel.dart';
import 'package:flutter_mvvm/viewmodel/startup_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future<void> setUpLocator() async {
  // Services
  locator.registerSingleton<LocalStorageService>(
    await LocalStorageService.getInstance(),
  );
  locator.registerSingleton<FirebaseService>(FirebaseService());
  locator.registerSingleton<ApiService>(ApiService());

//viewmodel
  locator.registerFactory<StartUpViewModel>(() => StartUpViewModel());
  locator.registerFactory<LoginViewModel>(() => LoginViewModel());
  locator.registerFactory<RegisterViewModel>(() => RegisterViewModel());
  locator.registerFactory<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
}
