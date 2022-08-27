import 'package:ferdinand_coffee/core/constants.dart';
import 'package:ferdinand_coffee/pages/sign_up/sign_up.dart';
import 'package:ferdinand_coffee/services/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/form.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/login";

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;
  String? email;
  String? password;
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
                    AppLocalizations.of(context)!.welcome,
                    style: const TextStyle(
                        color: Constants.secondaryColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    AppLocalizations.of(context)!.loginInstruction,
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
                        return AppLocalizations.of(context)!.emailError;
                      }
                      return null;
                    },
                    labelText: "Email",
                    onChanged: (value) {
                      email = value;
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
                    labelText: AppLocalizations.of(context)!.password,
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            checkColor: Constants.greyColor,
                            value: isChecked,
                            onChanged: (e) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            },
                            side: const BorderSide(
                                color: Constants.greyColor, width: 0),
                          ),
                          Text(
                            AppLocalizations.of(context)!.rememberMe,
                            style: const TextStyle(
                                color: Constants.greyColor, fontSize: 10),
                          ),
                        ],
                      ),
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: const TextStyle(
                            color: Constants.rustColor, fontSize: 10),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonText: AppLocalizations.of(context)!.login,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Loginuser auth = Loginuser();
                        auth.loginAuth(email, password, context);
                      }
                    },
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
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, SignupPage.routeName);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                              style: const TextStyle(
                                  color: Constants.greyColor,
                                  fontFamily: 'Avenir'),
                              text: AppLocalizations.of(context)!.notRegistered,
                              children: [
                                TextSpan(
                                    text: AppLocalizations.of(context)!.signup,
                                    style:
                                        TextStyle(color: Constants.rustColor))
                              ]),
                        ),
                      ],
                    ),
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
