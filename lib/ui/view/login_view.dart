import 'package:flutter/material.dart';
import 'package:flutter_mvvm/ui/components/custom_text_field.dart';
import 'package:flutter_mvvm/ui/view/base_view.dart';
import 'package:flutter_mvvm/ui/view/home_view.dart';
import 'package:flutter_mvvm/ui/view/register_view.dart';
import 'package:flutter_mvvm/utils/app_theme.dart';
import 'package:flutter_mvvm/viewmodel/login_viewmodel.dart';

class LoginView extends StatelessWidget {
  static const String id = 'login_view';
  LoginView({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  late final LoginViewModel _model;
  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady();
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, widget) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formkey,
                    child: SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Sign In',
                            // style: AppTheme.headline1,
                          ),
                          const SizedBox(height: 40),
                          _buildEmailTextField(),

                          const SizedBox(height: 20),
                          _buildPasswordTextField(),
                          // _buildPasswordTextField(),
                          const SizedBox(height: 20),
                          _buildLoginButton(context),
                          const SizedBox(height: 10),
                          _buildCreateAccountButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCreateAccountButton() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.of(_context).pushReplacementNamed(RegisterView.id);
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          "Don't have an account? Create one",
          style: AppTheme.bodyText1.copyWith(
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }

  Row _buildLoginButton(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            textStyle: AppTheme.button,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onPressed: () => _formkey.currentState!.validate()
              ? _model.login().then((value) {
                  if (!value) return;
                  Navigator.of(context).pushReplacementNamed(HomeView.id);
                })
              : null,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Log in"),
          ),
        ))
      ],
    );
  }

  CustomTextFormField _buildPasswordTextField() {
    return CustomTextFormField(
      controller: _model.passwordController,
      labelText: "password",
      hintText: "Enter you password",
      prefix: Icons.lock,
      obscureText: _model.isHidden,
      validator: _model.passwordValidator,
      suffix: IconButton(
        icon: _model.isHidden
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off),
        onPressed: () {
          _model.isHidden = !_model.isHidden;
        },
      ),
    );
  }

  CustomTextFormField _buildEmailTextField() {
    return CustomTextFormField(
      controller: _model.emailController,
      labelText: "Email",
      hintText: "Enter you email",
      prefix: Icons.email,
      validator: _model.emailValidator,
    );
  }
}
