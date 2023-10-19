import 'package:flutter/material.dart';
import 'package:flutter_mvvm/ui/view/base_view.dart';
import 'package:flutter_mvvm/viewmodel/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  static const String id = 'login_view';
  LoginView({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (context, model, widget) {
        return const Scaffold();
      },
    );
  }
}
