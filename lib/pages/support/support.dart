import 'package:ferdinand_coffee/components/form.dart';
import 'package:ferdinand_coffee/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../services/auth/support.dart';

String? emailSubject;

String? emailBody;

class HelpCenter extends StatefulWidget {
  static const routeName = "/help-center";

  HelpCenter({Key? key}) : super(key: key);

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
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
                  Text(
                    AppLocalizations.of(context)!.contactSupport,
                    style: const TextStyle(
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
                        return AppLocalizations.of(context)!.title;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      emailSubject = value;
                    },
                    labelText: AppLocalizations.of(context)!.title,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    maxLines: 10,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.yourMessage;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      emailBody = value;
                    },
                    labelText: AppLocalizations.of(context)!.yourMessage,
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final SupportRequest support = SupportRequest();
                        support.submitRequest(emailSubject, emailBody, context);
                      }
                    },
                    buttonText: AppLocalizations.of(context)!.sendMessage,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
