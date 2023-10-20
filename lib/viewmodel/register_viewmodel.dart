import 'package:flutter/material.dart';
import 'package:flutter_mvvm/locator.dart';
import 'package:flutter_mvvm/services/firebase_sevice.dart';
import 'package:flutter_mvvm/services/local_storage_services.dart';
import 'package:flutter_mvvm/utils/validators.dart';
import 'package:flutter_mvvm/viewmodel/base_viewmodel.dart';

class RegisterViewModel extends BaseViewModel {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  bool _isHidden = false;

//services
  final FirebaseService _firebaseService = locator<FirebaseService>();

  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  //getter
  bool get isHidden => _isHidden;

  TextEditingController get nameController => _nameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPassworController =>
      _confirmPasswordController;

  String? Function(String? name) get nameValidator => Validator.nameValidator;
  String? Function(String? name) get emailValidator => Validator.emailValidator;
  String? Function(String? name) get passwordValidator =>
      Validator.passwordValidator;
  String? Function(String? name) get confirmPasswordValidator =>
      (confirmPassword) {
        return Validator.confirmPasswordValidator(
          confirmPassword,
          passwordController.text.trim(),
        );
      };

  set isHidden(bool val) {
    _isHidden = val;
    notifyListeners();
  }

  void onModelReady() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  void onModelDestroy() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  Future<bool> register() async {
    var res = await _firebaseService.signUp(_nameController.text,
        _emailController.text.trim(), _passwordController.text);
    _localStorageService.isLoggedIn = res != null;
    return res != null;
  }
}
