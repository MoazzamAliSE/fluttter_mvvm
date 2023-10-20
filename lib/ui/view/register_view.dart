import 'package:flutter/material.dart';
import 'package:flutter_mvvm/ui/components/custom_text_field.dart';
import 'package:flutter_mvvm/ui/view/base_view.dart';
import 'package:flutter_mvvm/ui/view/home_view.dart';
import 'package:flutter_mvvm/ui/view/login_view.dart';
import 'package:flutter_mvvm/utils/app_theme.dart';
import 'package:flutter_mvvm/viewmodel/register_viewmodel.dart';

class RegisterView extends StatelessWidget {
  static const String id = 'register_view';

  RegisterView({Key? key}) : super(key: key);
  late final RegisterViewModel _model;
  final _formkey = GlobalKey<FormState>();
  late final BuildContext _context;

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      onModelReady: (model) {
        _model = model;
        _context = context;
        model.onModelReady();
      },
      onModelDestroy: (model) => model.onModelDestroy(),
      builder: (context, model, widget) => GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formkey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sign Up',
                          style: AppTheme.headline1,
                        ),
                        const SizedBox(height: 40),
                        _buildNameTextField(),

                        // (),
                        const SizedBox(height: 20),
                        _buildEmailTextField(),
                        // (),
                        const SizedBox(height: 20),

                        _buildPasswordTextField(),
                        // (),
                        const SizedBox(height: 20),

                        _buildConfirmPasswordTextField(), // (),
                        const SizedBox(height: 20),
                        _buildRegisterButton(),
                        const SizedBox(height: 20),
                        // (),
                        // _buildRegisterButton(),
                        _buildLogInButton()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildRegisterButton() {
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
                    ? _model.register().then((value) {
                        if (!value) return;

                        debugPrint("going to Homeview");
                        Navigator.of(_context)
                            .pushReplacementNamed(HomeView.id);
                      })
                    : null,
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('Sign Up'),
                )))
      ],
    );
  }

  Align _buildLogInButton() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          Navigator.of(_context).pushReplacementNamed(LoginView.id);
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        child: Text(
          'Already have an account?',
          style: AppTheme.bodyText1.copyWith(
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }

  CustomTextFormField _buildConfirmPasswordTextField() {
    return CustomTextFormField(
      controller: _model.confirmPassworController,
      labelText: "Confirm Password",
      hintText: "Again enter your password",
      prefix: Icons.lock,
      validator: _model.confirmPasswordValidator,
      obscureText: _model.isHidden,
    );
  }

  CustomTextFormField _buildPasswordTextField() {
    return CustomTextFormField(
      controller: _model.passwordController,
      labelText: "Password",
      hintText: "Enter your password",
      prefix: Icons.lock,
      validator: _model.passwordValidator,
      obscureText: _model.isHidden,
      suffix: IconButton(
          onPressed: () {
            _model.isHidden = !_model.isHidden;
          },
          icon: _model.isHidden
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off)),
    );
  }

  CustomTextFormField _buildEmailTextField() {
    return CustomTextFormField(
      controller: _model.emailController,
      labelText: "Email",
      hintText: "Enter your email",
      prefix: Icons.email,
      validator: _model.emailValidator,
    );
  }

  CustomTextFormField _buildNameTextField() {
    return CustomTextFormField(
      controller: _model.nameController,
      labelText: "Name",
      hintText: "Enter your name",
      prefix: Icons.person,
      validator: _model.nameValidator,
    );
  }
}
