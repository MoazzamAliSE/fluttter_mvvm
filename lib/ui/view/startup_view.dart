import 'package:flutter/material.dart';
import 'package:flutter_mvvm/ui/view/base_view.dart';
import 'package:flutter_mvvm/ui/view/home_view.dart';
import 'package:flutter_mvvm/ui/view/login_view.dart';
import 'package:flutter_mvvm/viewmodel/startup_viewmodel.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      builder: (context, model, widget) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      onModelReady: (model) {
        model
            .onModelReady()
            .then((value) => Navigator.of(context).pushReplacementNamed(
                  value ? HomeView.id : LoginView.id,
                ));
      },
    );
  }
}
