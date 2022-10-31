import 'package:ferdinand_coffee/core/constants.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

import '../../../components/form.dart';
import '../../../services/admin/send_notification.dart';
import '../../product_details/product_details.dart';

class SendNotificationPage extends StatefulWidget {
  static const routeName = "/notification-sender";

  const SendNotificationPage({Key? key}) : super(key: key);

  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  String? message;
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: MyAppBar(title: AppLocalizations.of(context)!.sendNotification),
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
                    AppLocalizations.of(context)!.sendNotification,
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
                    maxLines: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter message to broadcast';
                      }
                      return null;
                    },
                    labelText: AppLocalizations.of(context)!.yourMessage,
                    onChanged: (value) {
                      message = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    buttonText: AppLocalizations.of(context)!.sendNotification,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        SendNotificationApi _notification =
                            SendNotificationApi();
                        _notification.notification(message);
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
