import 'package:flutter/material.dart';
import 'package:flutter_mvvm/enums/view_state.dart';
import 'package:flutter_mvvm/ui/components/custom_text_field.dart';
import 'package:flutter_mvvm/ui/view/base_view.dart';
import 'package:flutter_mvvm/ui/view/login_view.dart';
import 'package:flutter_mvvm/utils/app_theme.dart';
import 'package:flutter_mvvm/viewmodel/profile_viewmodel.dart';

class ProfileView extends StatelessWidget {
  static const String id = 'profile_view';
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BaseView<ProfileViewModel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, widget) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile View'),
            actions: [
              IconButton(
                onPressed: () async {
                  await model.signout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginView.id,
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          body: model.state == ViewState.BUSY
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Email:',
                              style: AppTheme.headline4,
                            ),
                            SizedBox(
                              width: size.width / 1.8,
                              child: CustomTextFormField(
                                initialValue: model.email,
                                enabled: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Name:',
                            style: AppTheme.headline4,
                          ),
                          SizedBox(
                            width: size.width / 1.8,
                            child: CustomTextFormField(
                              controller: model.controller,
                              enabled: model.isEditing,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: model.isEditing
                    ? FloatingActionButton.extended(
                        onPressed: () {
                          model.cancelChanges();
                        },
                        label: const Text('Cancel'),
                        icon: const Icon(Icons.close),
                      )
                    : null,
              ),
              FloatingActionButton.extended(
                onPressed: () {
                  if (!model.isEditing) {
                    model.isEditing = !model.isEditing;
                    return;
                  }

                  if (!model.isChanged) return;
                  model.update();
                },
                backgroundColor: model.isEditing && !model.isChanged
                    ? AppTheme.lightBlue.withOpacity(0.6)
                    : AppTheme.lightBlue,
                label:
                    model.isEditing ? const Text('Save') : const Text('Edit'),
                icon: model.isEditing
                    ? const Icon(Icons.save)
                    : const Icon(Icons.edit),
              ),
            ],
          ),
        );
      },
    );
  }
}
