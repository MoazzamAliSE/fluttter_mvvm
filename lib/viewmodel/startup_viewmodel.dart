import 'package:flutter_mvvm/locator.dart';
import 'package:flutter_mvvm/services/local_storage_services.dart';
import 'package:flutter_mvvm/viewmodel/base_viewmodel.dart';

class StartUpViewModel extends BaseViewModel {
  final LocalStorageService localStorageService =
      locator<LocalStorageService>();

  Future<bool> onModelReady() async {
    return Future.delayed(
        const Duration(
          seconds: 2,
        ), () {
      return localStorageService.isLoggedIn;
    });
  }
}
