import 'package:ferdinand_coffee/components/form.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/pages/login/login.dart';
import 'package:ferdinand_coffee/services/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String? firstName;
String? lastName;
String? referralID;
String? email;
String? phoneNumber;
String? password;

class SignupPage extends StatelessWidget {
  static const routeName = "/register";
  SignupPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            SizedBox(height: height * 0.05),
            Center(
              child: Image.asset(
                'assets/icons/logo.png',
                scale: 2.0,
              ),
            ),
            SizedBox(height: height * 0.05),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Konto erstellen',
                    style: TextStyle(
                        color: Constants.secondaryColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.firstName;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      firstName = value;
                    },
                    labelText: AppLocalizations.of(context)!.firstName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.lastName;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      lastName = value;
                    },
                    labelText: AppLocalizations.of(context)!.lastName,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.phoneNumber;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    labelText: AppLocalizations.of(context)!.phoneNumber,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.emailError;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    labelText: "E-mail",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.length < 6) {
                        return AppLocalizations.of(context)!.passError;
                      }
                      return null;
                    },
                    labelText: AppLocalizations.of(context)!.password,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value!.length < 6) {
                          return AppLocalizations.of(context)!.passError;
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      labelText: AppLocalizations.of(context)!.confirmPassword),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    onChanged: (value) {
                      referralID = value;
                    },
                    labelText: AppLocalizations.of(context)!.refID,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        SignupUser signupUser = SignupUser();
                        signupUser.signAuth(email, password, firstName,
                            lastName, phoneNumber, referralID);
                      }
                    },
                    buttonText: AppLocalizations.of(context)!.joinNow,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                height: 1, color: Constants.lightGrayColor)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)!.or,
                            style: const TextStyle(color: Constants.greyColor),
                          ),
                        ),
                        Expanded(
                            child: Container(
                                height: 1, color: Constants.lightGrayColor))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, LoginPage.routeName);
                        },
                        child: RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                  color: Constants.greyColor,
                                  fontFamily: 'Avenir'),
                              text: AppLocalizations.of(context)!.haveAccount,
                              children: [
                                TextSpan(
                                    text: AppLocalizations.of(context)!.login,
                                    style: const TextStyle(
                                        color: Constants.rustColor))
                              ]),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
