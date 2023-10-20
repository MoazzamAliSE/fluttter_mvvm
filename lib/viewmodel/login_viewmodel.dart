import 'package:flutter/material.dart';
import 'package:flutter_mvvm/locator.dart';
import 'package:flutter_mvvm/services/firebase_sevice.dart';
import 'package:flutter_mvvm/services/local_storage_services.dart';
import 'package:flutter_mvvm/utils/validators.dart';
import 'package:flutter_mvvm/viewmodel/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  late final TextEditingController _emailTextEditingController;
  late final TextEditingController _passwordTextEditingController;

  bool _isHidden = true;

//services

  final FirebaseService _firebaseService = locator<FirebaseService>();
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

// getter
  bool get isHidden => _isHidden;

  TextEditingController get emailController => _emailTextEditingController;
  TextEditingController get passwordController =>
      _passwordTextEditingController;

  String? Function(String? password) get passwordValidator =>
      Validator.passwordValidator;

  String? Function(String? email) get emailValidator =>
      Validator.emailValidator;

  // setter
  set isHidden(bool val) {
    _isHidden = val;
    notifyListeners();
  }

  void onModelReady() {
    _emailTextEditingController = TextEditingController();
    _passwordTextEditingController = TextEditingController();
  }

  onModelDestroy() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

  Future<bool> login() async {
    var res = await _firebaseService.signIn(
      _emailTextEditingController.text.trim(),
      _passwordTextEditingController.text,
    );
    _localStorageService.isLoggedIn = res != null;
    return res != null;
  }
}
