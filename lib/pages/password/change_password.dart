import 'package:ferdinand_coffee/core/constants.dart';

import 'package:ferdinand_coffee/services/auth/change_password.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/form.dart';

class ChangePasswordPage extends StatefulWidget {
  static const routeName = "/chnage-password";

  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  String? newPassword;
  String? oldPassword;
  String? cPassword;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
            ),
            Center(
              child: Image.asset(
                'assets/icons/logo.png',
                scale: 2.0,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.changePassword,
                    style: const TextStyle(
                        color: Constants.secondaryColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    AppLocalizations.of(context)!.generalInstruction,
                    style: const TextStyle(
                        color: Constants.greyColor,
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.oldPassword;
                      }
                      return null;
                    },
                    obscureText: true,
                    labelText: AppLocalizations.of(context)!.oldPassword,
                    onChanged: (value) {
                      oldPassword = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    validator: (value) {
                      if (value!.length < 6) {
                        return AppLocalizations.of(context)!.passError;
                      }
                      return null;
                    },
                    labelText: AppLocalizations.of(context)!.newPassword,
                    obscureText: true,
                    onChanged: (value) {
                      newPassword = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomFormField(
                    validator: (value) {
                      if (value!.length < 6) {
                        return AppLocalizations.of(context)!.passError;
                      }
                      return null;
                    },
                    labelText: AppLocalizations.of(context)!.repeatPassword,
                    obscureText: true,
                    onChanged: (value) {
                      cPassword = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    buttonText: AppLocalizations.of(context)!.changePassword,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        ChangePasswordApi passwordApi = ChangePasswordApi();
                        passwordApi.changePassword(
                            oldPassword, newPassword, cPassword, context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
